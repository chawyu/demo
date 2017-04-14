//
//  UserMng.m
//  iOSDemo
//
//  Created by 周维 on 17/2/21.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "RecentMng.h"
#import "RecentEntity.h"
@interface RecentMng()
@property (nonatomic, strong) NSMutableDictionary* allRecents;
@end

@implementation RecentMng
- (void)test{
    for (int i=0; i<30; ++i) {
        RecentEntity* user = [[RecentEntity alloc] init];
        user.uid = [NSString stringWithFormat:@"id%d", i];
        user.lastUpdateTime = arc4random_uniform(10);
        user.lastMsg = [NSString stringWithFormat:@"lastmsg%d", i];
        user.userType = UserType_Player;
        
        [self addNewRecent:user];
    }
  
}
+ (instancetype)shareInstance
{
    static RecentMng* g_RecentMng;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_RecentMng = [[RecentMng alloc] init];
    });
    return g_RecentMng;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        self.allRecents = [[NSMutableDictionary alloc] init];
    }
    return self;
}


- (void)addNewRecent:(RecentEntity*)recent
{
    if (!recent) {
        return;
    }
    if (!self.allRecents) {
        self.allRecents = [[NSMutableDictionary alloc] init];
    }
    
    [self.allRecents setObject:recent forKey:user.uid];
}
- (RecentEntity*)getRecent:(NSString*)uid{
    return [self.allRecents objectForKey:uid];
}
- (NSArray*)getAllRecent{
    return [self.allRecents allValues];
}


@end
