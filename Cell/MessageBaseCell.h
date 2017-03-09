//
//  MessageBaseCell.h
//  iOSDemo
//
//  Created by 周维 on 17/3/4.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatCellProtocol.h"
typedef NS_ENUM(NSUInteger, BubbleType)
{
    BubbleType_Left,
    BubbleType_Right
};
@class MessageEntity;
@interface MessageBaseCell : UITableViewCell<ChatCellProtocol>
@property (nonatomic, strong) UILabel* userName;
@property (nonatomic, strong) UILabel* userContent;
@property (nonatomic, strong) UIImageView* userAvater;
@property (nonatomic, strong) UIImageView* userBubble;
@property (nonatomic, assign) BubbleType userType;
-(void)setContent:(MessageEntity*)message;
@end
