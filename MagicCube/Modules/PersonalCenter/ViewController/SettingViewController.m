//
//  SettingViewController.m
//  MagicCube
//
//  Created by wanmeizty on 21/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "JoinClubViewController.h"
#import "MyInviteViewController.h"
#import "OpinionViewController.h"
#import "AboutViewController.h"
#import "AppDelegate.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSArray * dataArray;
@property (strong,nonatomic) UITableView * tableView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self addSubViews];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
//

- (void)requestLogout{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    WS(weakSelf)
    NSLog(@"-----kAppApiLogout--->%@",params);
    NMShowLoadIng;
    
    [BTERequestTools requestWithURLString:kAppApiLogout parameters:params type:HttpRequestTypePost success:^(id responseObject) {
        
        NMRemovLoadIng;
        NSLog(@"---kAppApiLogout--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            [User removeLoginData];
            [weakSelf.navigationController popToRootViewControllerAnimated:NO];
            AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            [appDelegate setupKeyWindow];
        }else{
            NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
            [BHToast showMessage:message];
        }
    } failure:^(NSError *error)  {
        
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
    
}

- (void)initData{
    self.title = @"设置";
    
    self.dataArray = @[@[@{@"left":@"加入魔方社群",@"right":@"",@"showRight":@(YES)},
                         @{@"left":@"我的邀请",@"right":@"0个好友",@"showRight":@(YES)}],
                       @[@{@"left":@"意见反馈",@"right":@"",@"showRight":@(YES)},
                         @{@"left":@"版本升级",@"right":[NSString stringWithFormat:@"v%@",kCurrentVersion],@"showRight":@(NO)},
                         @{@"left":@"关于",@"right":@"",@"showRight":@(YES)}],];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"setting"];
    if (!cell) {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"setting"];
    }
    NSDictionary * cellDict = self.dataArray[indexPath.section][indexPath.row];
    [cell configDict:cellDict];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    headView.backgroundColor = KBGColor;
    return headView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            JoinClubViewController * join = [[JoinClubViewController alloc] init];
            [self.navigationController pushViewController:join animated:YES];
        }else if (indexPath.row == 1){
            MyInviteViewController * invite = [[MyInviteViewController alloc] init];
            [self.navigationController pushViewController:invite animated:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            OpinionViewController * opinio = [[OpinionViewController alloc] init];
            [self.navigationController pushViewController:opinio animated:YES];
        }else if (indexPath.row == 1){
            
        }else if (indexPath.row == 2){
            AboutViewController * about = [[AboutViewController alloc] init];
            [self.navigationController pushViewController:about animated:YES];
        }
    }
}

- (void)addSubViews{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIButton * footView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 58)];
    [footView addTarget:self action:@selector(requestLogout) forControlEvents:UIControlEventTouchUpInside];
    footView.backgroundColor = KBGColor;
    
    MagicLabel * label = [[MagicLabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 48)];
    label.text = @"退出登录";
    label.backgroundColor = BHColorWhite;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHexString:@"999999" alpha:0.6];
    [footView addSubview:label];
    self.tableView.tableFooterView = footView;
    self.tableView.rowHeight = [SettingTableViewCell cellHeight];
    [self.view addSubview:self.tableView];
}

- (void)footClick{
    
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
