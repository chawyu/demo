//
//  MessageEntity.h
//  iOSDemo
//
//  Created by 周维 on 17/3/1.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "BaseEntity.h"
typedef NS_ENUM(NSUInteger, MessageType) {
    MessageType_Text,
    MessageType_Image,
    MessageType_Voice,
};
@interface MessageEntity : BaseEntity
@property(nonatomic, assign) MessageType msgType;
@property(nonatomic, copy) NSString* msgId;
@property(nonatomic, copy) NSString* sourceId;
@property(nonatomic, copy) NSString* destId;
@property(nonatomic, copy) NSString* msgContent;
@property(nonatomic, assign) NSTimeInterval msgTime;
-(MessageEntity*)initWithMsgId:(NSString*)msgId msgType:(MessageType)msgType msgTime:(NSTimeInterval)msgTime msgSrc:(NSString*)srcId msgDest:(NSString*)destId msgContent:(NSString*)content;
@end
