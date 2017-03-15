//
//  MyMessageViewController.h
//  iOSDemo
//
//  Created by 周维 on 17/2/11.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "BaseViewController.h"
@class UserEntity;
@interface MyMessageViewController : BaseViewController<UITableViewDataSource, UITabBarDelegate>
@property (strong, nonatomic) UserEntity* user;

@end
