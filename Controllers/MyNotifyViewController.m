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
#import "RecentMng.h"
#import "MyMessageViewController.h"
#import "RDVTabBarController.h"
@interface MyNotifyViewController ()
@property (strong, nonatomic) UITableView* tableview;
//@property (strong, nonatomic) NSMutableDictionary* notifydata;
@property (strong, nonatomic) NSArray* list;

@end

@implementation MyNotifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    self.tableview = [[UITableView alloc] initWithFrame: self.view.bounds style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor redColor];
    [self.tableview registerClass: [NotifyCell class] forCellReuseIdentifier:CellIdentifier_NotifyCell];
    [self.view addSubview:self.tableview];
    
   
    [[UserMng shareInstance]test];
    [[RecentMng shareInstance]test];
    self.list = [[RecentMng shareInstance]getAllRecent];
   
    [self sortDatas];
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    // [self.myTableView reloadData];
    // [self startPolling];
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
    if (!cell)
    {
        cell = [[NotifyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier_NotifyCell];
       // cell.contentLabel.delegate = self;
    }
    RecentEntity* user = self.list[indexPath.row];
    [cell setUser:user];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecentEntity* user = self.list[indexPath.row];
    //TODO check user life
    MyMessageViewController* vc = [[MyMessageViewController alloc] init];
    //vc.user = user;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
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
