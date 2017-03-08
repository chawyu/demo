//
//  MessageTextCell.h
//  iOSDemo
//
//  Created by 周维 on 17/3/1.
//  Copyright © 2017年 chaw. All rights reserved.
//


#import "MessageBaseCell.h"

#define CellIdentifier_MessageTextCell @"CellIdentifier_MessageTextCell"

@class MessageEntity;
@interface MessageTextCell : MessageBaseCell
-(void)setContent:(MessageEntity*)message;

@end
