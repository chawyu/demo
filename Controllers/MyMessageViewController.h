//
//  MyMessageViewController.h
//  iOSDemo
//
//  Created by 周维 on 17/2/11.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "BaseViewController.h"
#import "InputView.h"
@class RecentEntity;
@class MessageEntity;
@interface MyMessageViewController : BaseViewController<UITableViewDataSource, UITabBarDelegate, InputViewDelegate>
//@property (strong, nonatomic) RecentEntity* user;
@property (strong, nonatomic) NSString * uid;
- (void)sendMessage:(id)obj
- (void)sendMessageWithEntity:(MessageEntity *)msg;
@end
