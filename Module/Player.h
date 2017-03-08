//
//  Player.h
//  iOSDemo
//
//  Created by 周维 on 17/3/7.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property (nonatomic, copy) NSString* uid;
@property (nonatomic, assign) NSUInteger lastUpdateTime;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, copy) NSString* avatar;
@property (nonatomic, assign) NSUInteger sex;

+ (instancetype)shareInstance;
@end
