//
//  LYViewController.m
//  DataStorage_plist
//
//  Created by lanouhn on 16/6/22.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

/*
 属性列表是一种 XML 格式的文件,扩展名为plist
 如果对象是NSString, NSDictionary, NSArray, NSData, NSNumber, 等类型,就可以使用 writeToFile: automically: 方法直接将对象写到属性列表中
 获取 plist 文件中的数据 根据要获取数据的类型使用相应的方法 如: array数据类型使用 arrayWithContentsOfFile:
 */



/*
 ------------------------ 应用沙盒 ----------------------

 每个iOS应用都有自己的应用沙盒(应用沙盒就是文件系统目录)与其他文件系统隔离.应用必须待在自己的沙盒里,其他应用不能访问该沙盒.
 
 模拟器应用沙盒的根路径在: (apple是用户名, 6.0是模拟器版本)
 
 /Users/apple/Library/Application Support/iPhone Simulator/6.0/Applications
 
 或者: /Users/用户名/资源库/Application Support/iPhone Simulator/6.1/Applications
 
 注意:
 
 默认情况下，模拟器的目录是隐藏的，要想显示出来，需要在Mac终端输入下面的命令：
 
 显示Mac隐藏文件的命令：defaults write com.apple.finder AppleShowAllFiles YES
 
 隐藏Mac隐藏文件的命令：defaults write com.apple.finder AppleShowAllFiles NO
 
 ------------------------ 应用沙盒结构分析 ----------------------

 > 应用程序包:包含了所有的资源文件和可执行文件.
 
 > Documents:
 
 保存应用运行时生成的需要持久化的数据,iTunes同步设备时会备份该目录.例如游戏应用可将游戏存档保存在该目录.
 
 > tmp:
 
 保存应用运行时所需的临时数据,使用完毕后再将相应的文件从该目录删除.应用没有运行时,系统也可能会清除该目录下的文件.iTunes同步设备时不会备份该目录.
 
 > Library/Caches:
 
 保存应用运行时生成的需要持久化的数据,iTunes同步设备时不会备份该目录.一般存储体积大,不需要备份的非重要数据.
 
 > Library/Preference:
 
 保存应用的所有偏好设置,iOS的setting(设置)应用会在该目录中查找应用的设置信息.iTunes同步设备时会备份该目录.
 
 ------------------------ 应用沙盒目录的常见获取方式 ----------------------
 
 ==> 沙盒根路径:
 NSString *home = NSHomeDirectory();
 
 ==> Documents:(2种方式)
 1> 利用沙盒根目录拼接"Documents"字符串:
 NSString *home = NSHomeDirectory();
 NSString *documents = [home stringByAppendingPathComponent:@"Documents"];
 // 不建议采用，因为新版本的操作系统可能会修改目录名
 
 2> 利用NSSearchPathForDirectoriesInDomains函数:
 // NSDocumentDirectory 查找Documents 文件夹
 // NSUserDomainMask 代表从用户文件夹下找
 // YES 代表展开路径中的波浪字符“~”
 NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, NO);
 // 在iOS中，只有一个目录跟传入的参数匹配，所以这个集合里面只有一个元素
 NSString *documents = [array objectAtIndex:0];
 
 ==> tmp:
 NSString *tmp= NSTemporaryDirectory();
 
 ==> Library/Caches:(跟Documents类似的两种方法)
 1> 利用沙盒跟目录拼接"Caches"字符串.
 2> 利用NSSearchPathForDirectoriesInDomains函数(将函数的第一个参数改为:NSCachesDirectory即可).
 
 ==> Library/Preference:通过 NSUserDefaults 类存取该目录下的设置信息.

 */



#import "LYViewController.h"
#import "Person.h"


@interface LYViewController ()

@end

@implementation LYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)clickSaveButton:(UIButton *)sender {
    // ------------- 获取 documents 文件夹路径 ------------
    // 1⃣️获取应用程序根目录,并拼接文件名
    // NSString *home = NSHomeDirectory();
        // 不建议写
    // NSString *documentsPath = [home stringByAppendingString:@"Documents"];
        // 不建议 Documents 写死
    // NSString *documentsPath = [home stringByAppendingPathComponent:@"Documents"];
    
    // 2⃣️利用 NSSearchPathForDirectoriesInDomains 函数:(推荐使用此方法动态获取)
    /* 
     * NSDocumentDirectory 查找Documents 文件夹
     * NSUserDomainMask 在用户目录下查找
     * YES 代表展开路径中的波浪字符"~"
     */
    // ==> 在用户目录下查找 Documents 文件夹
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // 在iOS中,只有一个目录跟传入的参数匹配,所以这个集合里面只有一个元素
    NSString *documentsPath = [array objectAtIndex:0];
    
    // ------------- 拼接文件路径 ------------
    NSString *path = [documentsPath stringByAppendingPathComponent:@"abc.plist"];
    NSLog(@"%@", path);
    
    // ------------- 将数据写入文件 ------------
    // 数组对象的写入
//    NSArray *arr = @[@"China", @"America"];
//    [arr writeToFile:path atomically:YES];
    
    // 字典对象的写入
//    NSDictionary *dic = @{@"name":@"LY", @"age":@"18"};
//    [dic writeToFile:path atomically:YES];
    
    /*
     * plist 只能存储系统自带的一些常规的类(NSString, NSDictionary, NSArray, NSData, NSNumber), 也就是有writeToFile 方法的对象才可以使用 plist 保存数据
     */
    
    // 自定义的对象不能直接保存到 plist 中
//    Person *person = [[Person alloc]init];
//    person.name = @"tom";
//    
//    NSDictionary *dic1 = @{@"person":@"A"};
//    [dic1 writeToFile:path atomically:YES];
    
}


// 点击读取按钮
- (IBAction)clickReadButton:(UIButton *)sender {
    // 1 获取路径
    NSString *docmentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path = [docmentsPath stringByAppendingPathComponent:@"abc.plist"];
    
    // 2 获取数据
        // 获取数组数据
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"%@", arr);
        // 获取字典数据
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"%@", dic);

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
