//
//  MySocialViewController.m
//  iOSDemo
//
//  Created by 周维 on 17/2/11.
//  Copyright © 2017年 chaw. All rights reserved.
//
#import "NotifyCell.h"
#import "MySocialViewController.h"

@interface MySocialViewController ()
@property (strong, nonatomic) UITableView* tableview;
@property (strong, nonatomic) NSMutableDictionary* notifydata;
@property (strong, nonatomic) NSArray* list;
@end

@implementation MySocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
   // UserEntity* user = self.list[indexPath.row];
   // [cell setUser:user];
    return cell;
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
