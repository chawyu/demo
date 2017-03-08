//
//  UserEntity.h
//  iOSDemo
//
//  Created by 周维 on 17/2/21.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "BaseEntity.h"

@interface UserEntity : BaseEntity
@property (nonatomic, strong) NSString* name;
@property (nonatomic, copy) NSString* avatar;
@property (nonatomic, assign) NSUInteger sex;
//auto set by setName
@property (nonatomic, copy) NSString* namepinyin;
- (id)initWithName:(NSString*)name;
@end
