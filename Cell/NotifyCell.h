//
//  NotifyCell.h
//  iOSDemo
//
//  Created by 周维 on 17/2/16.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CellIdentifier_NotifyCell @"CellIdentifier_NotifyCell"

typedef NS_ENUM(NSInteger, NotifyCellType) {
    NotifyCellTypeNone = 0,
    NotifyCellTypeAt,
};
@class RecentEntity;
@interface NotifyCell : UITableViewCell
@property (assign, nonatomic) NotifyCellType;
-(void)setUser:(UserEntity*)user;
+ (CGFloat) cellHeight;

@end
