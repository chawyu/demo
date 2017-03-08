//
//  ContactCell.h
//  iOSDemo
//
//  Created by 周维 on 17/2/22.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CellIdentifier_ContactCell @"CellIdentifier_ContactCell"
@class UserEntity;
@interface ContactCell : UITableViewCell
-(void)setUser:(UserEntity*)user;
+ (CGFloat) cellHeight;
@end
