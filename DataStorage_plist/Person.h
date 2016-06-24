//
//  Person.h
//  DataStorage_plist
//
//  Created by lanouhn on 16/6/23.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *gender;
@property (nonatomic, assign)NSInteger age;

@end
