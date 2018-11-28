
//
//  MyCenterViewController.m
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "MyCenterViewController.h"
#import "UserHeadView.h"
#import "TableTitleHeadView.h"
#import "InviteView.h"

@interface MyCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UserHeadView * headView;
@property (strong,nonatomic) UITableView * tableView;
@end

@implementation MyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)addSubView{
    self.headView = [[UserHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(288))];
    WS(weakSelf);
    self.headView.joinMember = ^{
        [weakSelf.tableView reloadData];
    };
    [self.headView configWithDict:@{}];
//    [self.view addSubview:self.headView];
    
    UITableView * tabelview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT - 49) style:UITableViewStylePlain];
    tabelview.delegate = self;
    tabelview.dataSource = self;
    tabelview.tableHeaderView = self.headView;
    tabelview.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    footView.backgroundColor = KBGColor;
    tabelview.tableFooterView = footView;//[UIView new];
    tabelview.backgroundColor = KBGColor;//[UIColor whiteColor];
    [self.view addSubview:tabelview];
    self.tableView = tabelview;
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, TAB_BAR_HEIGHT, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *invitecell = [tableView dequeueReusableCellWithIdentifier:@"invite"];
    if (!invitecell) {
        invitecell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"invite"];
    }
    InviteView * invite = [[InviteView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(146))];
    [invitecell addSubview:invite];
    return invitecell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCALE_W(146);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SCALE_W(181.5 + 42);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(181.5))];
    headView.backgroundColor = [UIColor whiteColor];
    MagicLabel * label1 = [[MagicLabel alloc] initWithFrame:CGRectMake(10, SCALE_W(12), SCREEN_WIDTH - 20, SCALE_W(54))];
    label1.numberOfLines = 3;
    label1.text = @"什么是魔方工分：魔方工分用于奖励会员对魔方好物做出的贡献，会员通过信息分享/邀请好友/会员卡充值/完成分销任务等各种方式均可获得工分。";
    label1.font =  UIFontRegularOfSize(SCALE_W(12));
    [headView addSubview:label1];
    
    MagicLineView * line1 = [[MagicLineView alloc] initWithFrame:CGRectMake(10, SCALE_W(77.5), SCREEN_WIDTH - 20, 0.5)];
    [headView addSubview:line1];
    
    MagicLabel * fenhongLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10, SCALE_W(90.5), SCREEN_WIDTH - 20, 13)];
    fenhongLabel.text = @"今日工分分红：1.34元";
    fenhongLabel.font =  UIFontRegularOfSize(13);
    fenhongLabel.textColor = Gray666Color;
    [headView addSubview:fenhongLabel];
    
    MagicLabel * label2 = [[MagicLabel alloc] initWithFrame:CGRectMake(10, SCALE_W(115.5), SCREEN_WIDTH - 20, SCALE_W(36))];
    label2.numberOfLines = 2;
    label2.text = @"什么是工分分红：魔方好物会依据每位会员的工分值，每日将总分销利润的20%作为分红奖励自动发放至会员账户。";
    label2.font =  UIFontRegularOfSize(SCALE_W(12));
    [headView addSubview:label2];
    
    MagicLineView * line2 = [[MagicLineView alloc] initWithFrame:CGRectMake(0, SCALE_W(181.5) - SCALE_W(10), SCREEN_WIDTH, SCALE_W(10))];
    [headView addSubview:line2];
    
    TableTitleHeadView * head = [[TableTitleHeadView alloc] initWithFrame:CGRectMake(0, SCALE_W(181.5), SCREEN_WIDTH, SCALE_W(42))];
    [head setUpTitle:@"组队"];
    [headView addSubview:head];
    return headView;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 0) {
//        return 10;
//    }else{
//        return 0.01;
//    }
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section == 0) {
//        UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
//        footView.backgroundColor = KBGColor;
//        return footView;
//    }else{
//        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
//    }
//}
@end
