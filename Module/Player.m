//
//  Player.m
//  iOSDemo
//
//  Created by 周维 on 17/3/7.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "Player.h"

@implementation Player
+ (instancetype)shareInstance{
    static Player* g_Player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_Player = [[Player alloc] init];
    });
    return g_Player;
}
@end
