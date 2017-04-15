//
//  BaseEntity.h
//  iOSDemo
//
//  Created by 周维 on 17/2/21.
//  Copyright © 2017年 chaw. All rights reserved.
//


#import "UserEntity.h"
@interface RecentEntity : BaseEntity
@property(nonatomic, assign)NSUInteger unReadCount;
@property(nonatomic, copy)NSString *lastMsg;
@property (nonatomic, assign)UserType userType;

@end