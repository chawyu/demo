//
//  RootTabBarController.m
//  iOSDemo
//
//  Created by 周维 on 17/2/7.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "RootTabBarController.h"
#import "BaseNaviagtionController.h"
#import "MyGameViewController.h"
#import "MyViewController.h"
#import "MySocialViewController.h"
#import "MyContactViewController.h"
//#import "MyMessageViewController.h"
#import "MyNotifyViewController.h"
#import "RDVTabBarItem.h"


@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupControllers];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupControllers {
    MyGameViewController* mygame = [[MyGameViewController alloc] init];
    BaseNaviagtionController* nav_mygame = [[BaseNaviagtionController alloc] initWithRootViewController:mygame];
    
    MyNotifyViewController* mymessage = [[MyNotifyViewController alloc] init];
    BaseNaviagtionController* nav_mymessage = [[BaseNaviagtionController alloc] initWithRootViewController:mymessage];
    
    MyContactViewController* mysocial = [[MyContactViewController alloc] init];
    BaseNaviagtionController* nav_mysocial = [[BaseNaviagtionController alloc] initWithRootViewController:mysocial];
    
    MyViewController* my = [[MyViewController alloc] init];
    BaseNaviagtionController* nav_my = [[BaseNaviagtionController alloc] initWithRootViewController:my];
    
    [self setViewControllers:@[nav_mygame, nav_mymessage, nav_mysocial, nav_my]];
    
    NSArray* tabbarimages = @[@"mygame", @"mymessage", @"mysocial", @"my"];
    NSArray* tabbartitles = @[@"游戏", @"消息", @"通讯录", @"我的"];
    
  
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
       // item.titlePositionAdjustment = UIOffsetMake(0, 3);
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabbarimages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabbarimages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabbartitles objectAtIndex:index]];
       // item.backgroundColor = [UIColor redColor];
        index++;
    }
    
    self.tabBar.translucent = YES;
    self.delegate = self;
    
    
}
#pragma mark - RDVTabBarController
- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedViewController != viewController) {
        return YES;
    }
 
    //NSLog(@"--->%@", viewController);
    return NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
