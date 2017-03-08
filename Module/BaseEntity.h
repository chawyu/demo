//
//  BaseEntity.h
//  iOSDemo
//
//  Created by 周维 on 17/2/21.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseEntity : NSObject
@property (nonatomic, copy) NSString* uid;
@property (nonatomic, assign) NSUInteger lastUpdateTime;

@end
