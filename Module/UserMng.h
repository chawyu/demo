//
//  UserMng.h
//  iOSDemo
//
//  Created by 周维 on 17/2/21.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserEntity.h"
@interface UserMng : NSObject
+ (instancetype)shareInstance;
- (id)init;
- (void)addNewUser:(UserEntity*)user;
- (NSArray*)getAllUsers;
- (NSMutableDictionary*)getKeyDictionary;
@end
