//
//  UserMng.m
//  iOSDemo
//
//  Created by 周维 on 17/2/21.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "UserMng.h"

@interface UserMng()
@property (nonatomic, strong) NSMutableDictionary* allUsers;
@end

@implementation UserMng
+ (instancetype)shareInstance
{
    static UserMng* g_UserMng;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_UserMng = [[UserMng alloc] init];
    });
    return g_UserMng;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        self.allUsers = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addNewUser:(UserEntity*)user
{
    if (!user) {
        return;
    }
    if (!self.allUsers) {
        self.allUsers = [[NSMutableDictionary alloc] init];
    }
    
    [self.allUsers setObject:user forKey:user.uid];
}
- (UserEntity*)getUser:(NSString*)uid{
    return [self.allUsers objectForKey:uid];
}
- (NSArray*)getAllUsers{
    return [self.allUsers allValues];
}
- (NSMutableDictionary*)getKeyDictionary{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    [self.allUsers enumerateKeysAndObjectsUsingBlock:^(NSString* key, id obj, BOOL* stop){
        //id 判断class
        if ([obj isKindOfClass:[UserEntity class]]) {
            UserEntity* user = (UserEntity*)obj;
            if (user.namepinyin.length >= 1) {
                NSString* key = [user.namepinyin substringToIndex:1];
                if ([[dic allKeys]containsObject:key]) {
                    NSMutableArray* array = [dic objectForKey:key];
                    [array addObject:user];
                }else{
                    NSMutableArray* array = [[NSMutableArray alloc]init];
                    [array addObject:user];
                    [dic setObject:array forKey:key];
                    
                }
            }
            //sort
        }
        
    }];
    return dic;
}

@end
