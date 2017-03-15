//
//  MyNotifyViewController.m
//  iOSDemo
//
//  Created by 周维 on 17/2/16.
//  Copyright © 2017年 chaw. All rights reserved.
//
#import "NSString+Common.h"
#import "NotifyCell.h"
#import "MyNotifyViewController.h"
#import "UserMng.h"

@interface MyNotifyViewController ()
@property (strong, nonatomic) UITableView* tableview;
//@property (strong, nonatomic) NSMutableDictionary* notifydata;
@property (strong, nonatomic) NSArray* list;

@end

@implementation MyNotifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableview = [[UITableView alloc] initWithFrame: self.view.bounds style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor redColor];
    [self.tableview registerClass: [NotifyCell class] forCellReuseIdentifier:CellIdentifier_NotifyCell];
    [self.view addSubview:self.tableview];
    for (int i=0; i<30; ++i) {
        UserEntity* user = [[UserEntity alloc] initWithName:[NSString stringWithFormat:@"name%lu", (unsigned long)arc4random_uniform(10)]];
        user.uid = [NSString stringWithFormat:@"id%d", i];
        
        user.lastUpdateTime = arc4random_uniform(10);
        user.name = [NSString stringWithFormat:@"name%d", i];
       // user.namepinyin = [user.name transformToPinyin];
        [[UserMng shareInstance]addNewUser:user];
    }
    //-----
    UserEntity* user = [[UserEntity alloc] init];
    user.uid = @"me";
    user.lastUpdateTime = 100;
    user.name = @"周维";
     //user.namepinyin = [user.name transformToPinyin];
    
    [[UserMng shareInstance]addNewUser:user];
    
    UserEntity* user1 = [[UserEntity alloc] init];
    user1.uid = @"t2";
    user1.lastUpdateTime = 100;
    user1.name = @"about";
   //  user1.namepinyin = [user1.name transformToPinyin];
    [[UserMng shareInstance]addNewUser:user1];
    
    //-----
    self.list = [[UserMng shareInstance]getAllUsers];
   
    [self sortDatas];
    
    
}
-(void)sortDatas{
    NSSortDescriptor* des1 = [[NSSortDescriptor alloc]initWithKey:@"lastUpdateTime" ascending:YES];
   NSSortDescriptor* des2 = [[NSSortDescriptor alloc]initWithKey:@"uid" ascending:NO];
    NSArray* sortarray =[ NSArray arrayWithObjects:des1,des2, nil];
    self.list = [self.list sortedArrayUsingDescriptors:sortarray];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableView
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.list count];
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NotifyCell cellHeight];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotifyCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_NotifyCell forIndexPath:indexPath];
    UserEntity* user = self.list[indexPath.row];
    [cell setUser:user];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserEntity* user = self.list[indexPath.row];
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
