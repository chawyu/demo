//
//  ChatCellProtocol.h
//  iOSDemo
//
//  Created by 周维 on 17/3/9.
//  Copyright © 2017年 chaw. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MessageEntity;
@protocol ChatCellProtocol <NSObject>
- (CGSize)sizeForContent:(MessageEntity*)message;

- (CGFloat)contentUpGapWithBubble;

- (CGFloat)contentDownGapWithBubble;

- (CGFloat)contentLeftGapWithBubble;

- (CGFloat)contentRightGapWithBubble;

- (void)layoutContentView:(MessageEntity*)message;

- (CGFloat)cellHeightForMessage:(MessageEntity*)message;
@end
