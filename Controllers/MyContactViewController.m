//
//  MyContactViewController.m
//  iOSDemo
//
//  Created by 周维 on 17/2/22.
//  Copyright © 2017年 chaw. All rights reserved.
//
#import "ContactCell.h"
#import "MyContactViewController.h"
#import "UserMng.h"
@interface MyContactViewController ()
@property (strong, nonatomic) UITableView* tableview;
//------------------------------------
@property (strong, nonatomic) NSMutableDictionary* contactData;
@property (strong, nonatomic) NSArray* contactArray;
//------------------------------------


@end
@implementation MyContactViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableview = [[UITableView alloc] initWithFrame: self.view.bounds style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass: [ContactCell class] forCellReuseIdentifier:CellIdentifier_ContactCell];
    self.tableview.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableview.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    self.tableview.sectionIndexColor = [UIColor redColor];
    [self.view addSubview:self.tableview];

    self.contactData = [[UserMng shareInstance] getKeyDictionary];
    NSArray* array = [NSArray arrayWithArray: [self.contactData allKeys]];
    self.contactArray = [array sortedArrayUsingComparator:^(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
   
    return index;
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.contactArray;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([self.contactArray count] > section) {
        return [self.contactArray objectAtIndex:section];
    }
    return nil;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    if (height <= 0) {
        return nil;
    }
    //todo
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, height)];
    headerV.backgroundColor = [UIColor redColor];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.font = [UIFont systemFontOfSize:12];
    titleL.textColor = [UIColor blackColor];
    titleL.text = [self tableView:tableView titleForHeaderInSection:section];
    [headerV addSubview:titleL];
   
    return headerV;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.contactArray count];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.contactArray count] > section) {
        NSArray* array = [self.contactData objectForKey:
                          [self.contactArray objectAtIndex:section]];
        return [array count];
    }
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ContactCell cellHeight];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_ContactCell forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier_ContactCell];
       
    }
    NSArray* array = [self.contactData objectForKey:
                      [self.contactArray objectAtIndex:indexPath.section]];
    UserEntity* user = array[indexPath.row];
    [cell setUser:user];
    return cell;
}
@end
