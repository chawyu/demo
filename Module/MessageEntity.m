//
//  MessageEntity.m
//  iOSDemo
//
//  Created by 周维 on 17/3/1.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "MessageEntity.h"

@implementation MessageEntity
-(MessageEntity*)initWithMsgId:(NSString*)msgId msgType:(MessageType)msgType msgTime:(NSTimeInterval)msgTime msgSrc:(NSString*)srcId msgDest:(NSString*)destId msgContent:(NSString*)content{
    self = [super init];
    if (self) {
        _msgId = msgId;
        _msgType = msgType;
        _sourceId = srcId;
        _destId = destId;
        _msgTime = msgTime;
        _msgContent = content;
        
    }
    return self;
}


@end
