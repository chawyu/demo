//
//  UserEntity.m
//  iOSDemo
//
//  Created by 周维 on 17/2/21.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "UserEntity.h"
#import "NSString+Common.h"

@implementation UserEntity
- (id)initWithName:(NSString*)name{
    self = [super init];
    if (self){
        self.name = name;
        
    }
    return self;
}
- (void)setName:(NSString *)name{
    if (name) {
        _name = [name copy];
        self.namepinyin = [_name transformToPinyin];
    }
    
}

@end
