//
//  MessageMng.h
//  iOSDemo
//
//  Created by 周维 on 17/3/1.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserEntity;
@class MessageEntity;
@interface MessageMng : NSObject
@property(nonatomic, strong) UserEntity* user;
@property(nonatomic, strong) NSMutableArray* messageArray;

-(void)addMessage:(MessageEntity*)message;
-(CGFloat)cellHeightForMessage:(MessageEntity*)message;
@end
