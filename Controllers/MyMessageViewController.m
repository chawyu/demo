//
//  MyMessageViewController.m
//  iOSDemo
//
//  Created by 周维 on 17/2/11.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "MyMessageViewController.h"
#import <Masonry/Masonry.h>
#import "MessageMng.h"
#import "MessageEntity.h"
#import "MessageTextCell.h"
#import "Player.h"
#import "InputView.h"

@interface MyMessageViewController ()
@property (strong, nonatomic) UITableView* tableview;
@property (strong, nonatomic) InputView* inputView;
@property (strong, nonatomic) NSMutableDictionary* messagedata;
@property (strong, nonatomic) MessageMng* msgMng;

@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass: [MessageTextCell class] forCellReuseIdentifier:CellIdentifier_MessageTextCell];

    self.inputView = [InputView inputViewWithType:InputViewType_PriMsg placeHolder:@""];
    self.inputView.isAlwaysShow = YES;
    
    [self.view addSubview:self.tableview];
    self.msgMng = [[MessageMng alloc] init];
    MessageEntity* m1 = [[MessageEntity alloc ]initWithMsgId:@"1" msgType:MessageType_Text msgTime:333333 msgSrc:@"id1" msgDest:@"test2" msgContent:@"fasljjl"];
    MessageEntity* m2 = [[MessageEntity alloc ]initWithMsgId:@"1" msgType:MessageType_Text msgTime:333333 msgSrc:@"id2" msgDest:@"test2" msgContent:@"faslfasdfsadfasdfasdfasdfafjjl"];
    MessageEntity* m3 = [[MessageEntity alloc ]initWithMsgId:@"1" msgType:MessageType_Text msgTime:333333 msgSrc:@"id3" msgDest:@"test2" msgContent:@"发送到发送到发送到发所发生的发大水发SFFAI倨傲四大家疯狂拉升付款了"];
    MessageEntity* m4 = [[MessageEntity alloc ]initWithMsgId:@"1" msgType:MessageType_Text msgTime:333333 msgSrc:@"me" msgDest:@"test2" msgContent:@"发送到发送到发发斯蒂芬fdasfaf"];
    MessageEntity* m5 = [[MessageEntity alloc ]initWithMsgId:@"1" msgType:MessageType_Text msgTime:333333 msgSrc:@"id4" msgDest:@"test2" msgContent:@"fasdf发来撒很费劲阿萨德发射计划付款哈萨克的复合卡书法课身份卡刷卡费发山东科技凤凰卡收到话费卡水电费卡刷卡复活卡水电费卡好看的十分好看教案上客户积分换卡是否"];
    [self.msgMng addMessage:m1];
    [self.msgMng addMessage:m2];
    [self.msgMng addMessage:m3];
    [self.msgMng addMessage:m4];
    [self.msgMng addMessage:m5];

    [Player shareInstance].uid = @"me";



}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.inputView) {
        [self.inputView prepareToDismiss];
    }
    //[self stopPolling];
    //[[AudioManager shared] stopAll];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //    键盘
    if (self.inputView) {
        [self.inputView prepareToShow];
    }
   // [self.myTableView reloadData];
   // [self startPolling];
}
#pragma mark - UITableView
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.msgMng.messageArray count];
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageEntity* message = [self.msgMng.messageArray objectAtIndex:indexPath.row];
    return [self.msgMng cellHeightForMessage:message];
}
- (UITableViewCell*)_MessageTextCell_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath message:(MessageEntity*)message
{
        MessageTextCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_MessageTextCell forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[MessageTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier_MessageTextCell];
       // cell.contentLabel.delegate = self;
    }
    if ([Player shareInstance].uid == message.sourceId){
        cell.userType = BubbleType_Right;
    }else{
        cell.userType = BubbleType_Left;
    }
    [cell setContent:message];
    return cell;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = nil;
    MessageEntity* message = [self.msgMng.messageArray objectAtIndex:indexPath.row];
    if (message.msgType == MessageType_Text) {
        cell = [self _MessageTextCell_tableView:tableView cellForRowAtIndexPath:indexPath message:message];
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
