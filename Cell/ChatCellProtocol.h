//
//  ChatCellProtocol.h
//  iOSDemo
//
//  Created by 周维 on 17/3/9.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MessageEntity;
@protocol ChatCellProtocol <NSObject>
- (CGSize)sizeForContent:(MessageEntity*)message;

- (float)contentUpGapWithBubble;

- (float)contentDownGapWithBubble;

- (float)contentLeftGapWithBubble;

- (float)contentRightGapWithBubble;

- (void)layoutContentView:(MessageEntity*)message;

- (float)cellHeightForMessage:(MessageEntity*)message;
@end
