//
//  MessageMng.m
//  iOSDemo
//
//  Created by 周维 on 17/3/1.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "MessageMng.h"
#import "MessageEntity.h"

@implementation MessageMng
-(id)init{
    self = [super init];
    if (self) {
        self.messageArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addMessage:(MessageEntity*)message{
    [self.messageArray addObject:message];
    
}


@end
