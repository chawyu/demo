//
//  UserMng.h
//  iOSDemo
//
//  Created by 周维 on 17/2/21.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RecentEntity;
@interface RecentMng : NSObject
+ (instancetype)shareInstance;
- (id)init;
- (void)addNewRecent:(RecentEntity*)user;
- (NSArray*)getAllRecent;
- (RecentEntity*)getRecent:(NSString*)uid;
- (void)test;

@end