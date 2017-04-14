//
//  UserEntity.h
//  iOSDemo
//
//  Created by 周维 on 17/2/21.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "BaseEntity.h"
typedef NS_ENUM(NSUInteger, UserType) {
    UserType_Player,
    UserType_Group,
    UserType_System,
};
@interface UserEntity : BaseEntity
@property (nonatomic, strong) NSString* name;
@property (nonatomic, copy) NSString* avatar;
@property (nonatomic, assign) NSUInteger sex;
@property (nonatomic, assign) UserType userType;
//auto set by setName
@property (nonatomic, copy) NSString* namepinyin;
- (id)initWithName:(NSString*)name;
@end
