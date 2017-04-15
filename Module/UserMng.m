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
- (void)test{
    for (int i=0; i<30; ++i) {
        UserEntity* user = [[UserEntity alloc] initWithName:[NSString stringWithFormat:@"name%lu", (unsigned long)arc4random_uniform(10)]];
        user.uid = [NSString stringWithFormat:@"id%d", i];
        user.lastUpdateTime = arc4random_uniform(10);
        user.name = [NSString stringWithFormat:@"name%d", i];
        user.userType = UserType_Player;
        [self addNewUser:user];
    }
    UserEntity* user = [[UserEntity alloc] init];
    user.uid = @"me";
    user.lastUpdateTime = 100;
    user.name = @"周维";
    user.userType = UserType_Player;
    [self addNewUser:user];
    
    
    UserEntity* user1 = [[UserEntity alloc] init];
    user1.uid = @"t2";
    user1.lastUpdateTime = 100;
    user1.name = @"about";
    user1.userType = UserType_Player;
    [self addNewUser:user1];

}
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
