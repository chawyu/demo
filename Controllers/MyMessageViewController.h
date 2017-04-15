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
@interface MyMessageViewController : BaseViewController<UITableViewDataSource, UITabBarDelegate, InputViewDelegate>
@property (strong, nonatomic) RecentEntity* user;

@end
