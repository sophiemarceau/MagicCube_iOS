
//
//  MyCenterViewController.m
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "MyCenterViewController.h"
#import "SettingViewController.h"

#import "UserHeadView.h"
#import "TableTitleHeadView.h"
#import "InviteView.h"
#import "ZTYAlertView.h"

@interface MyCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UserHeadView * headView;
@property (strong,nonatomic) UITableView * tableView;
@property (strong,nonatomic) ZTYAlertView * alertView;
@property (strong,nonatomic) MagicLabel * fenhongLabel;
@property (strong,nonatomic) MagicLabel * invitedetailLabel;
@end

@implementation MyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self requestGetUserInfo];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

#pragma mark -- 数据
- (void)requestGetUserInfo{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    WS(weakSelf)
    NSLog(@"-----kAppApiGetUser--->%@",params);
    NMShowLoadIng;
    
    [BTERequestTools requestWithURLString:kAppApiGetAccount parameters:params type:HttpRequestTypeGet success:^(id responseObject) {

        NMRemovLoadIng;
        NSLog(@"---kAppApiGetUser--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            [weakSelf performSelectorOnMainThread:@selector(dealUserInfo:) withObject:responseObject waitUntilDone:YES];
        }else{
            NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
            [BHToast showMessage:message];
        }
    } failure:^(NSError *error)  {

        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
    
}

- (void)dealUserInfo:(NSDictionary *)responseObject{
    
    NSDictionary * dataDict = [responseObject objectForKey:@"data"];
    [self.headView configWithDict:dataDict];
    
    UIFont *font =  UIFontMediumOfSize(16);
    NSDictionary * attubtrDict = @{NSFontAttributeName:font,NSForegroundColorAttributeName:RedMagicColor};
    NSDictionary * todayIncome = [dataDict objectForKey:@"todayIncome"];
    
    NSString *point = [NSString stringWithFormat:@"  %.2f元",[[todayIncome objectForKey:@"point"] doubleValue]];
    NSString *pointString =[NSString stringWithFormat:@"今日工分分红%@",point];
    NSAttributedString * attributestring = [MagicRichTool initWithString:pointString dict:attubtrDict subString:point];
    self.fenhongLabel.attributedText = attributestring;
    
    NSDictionary * userInfo = [dataDict objectForKey:@"userInfo"];
    NSDictionary * inviteattubtrDict = @{NSForegroundColorAttributeName:RedMagicColor};
    NSString *inviteString =@"我的邀请码：48484953";
    NSString *inviteNum = @"48484953";
    NSAttributedString * inviteattributestring = [MagicRichTool initWithString:inviteString dict:inviteattubtrDict subString:inviteNum];
    self.invitedetailLabel.attributedText = inviteattributestring;
    
}

- (void)requestCreateDistribution{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    WS(weakSelf)
    NSLog(@"-----kAppApiGetUser--->%@",params);
    NMShowLoadIng;
    
    [BTERequestTools requestWithURLString:kAppApiGetUser parameters:params type:HttpRequestTypeGet success:^(id responseObject) {
        
        NMRemovLoadIng;
        NSLog(@"---kAppApiGetUser--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            [weakSelf performSelectorOnMainThread:@selector(dealUserInfo:) withObject:responseObject waitUntilDone:YES];
        }else{
            NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
            [BHToast showMessage:message];
        }
    } failure:^(NSError *error)  {
        
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
    
}

-(void)addSubView{
    self.headView = [[UserHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(288))];
    WS(weakSelf);
    self.headView.btnClickBlock = ^(NSInteger clickIndex) {
//        [weakSelf.tableView reloadData];
        if (clickIndex == 3000) {
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.alertView];
        }else if(clickIndex == 3001){
            SettingViewController * settingVC = [[SettingViewController alloc] init];
            [weakSelf.navigationController pushViewController:settingVC animated:YES];
        }
        
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
    return 0;
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
    return SCALE_W(181.5 + 60);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(181.5))];
    headView.backgroundColor = [UIColor whiteColor];
    MagicLabel * label1 = [[MagicLabel alloc] initWithFrame:CGRectMake(10, SCALE_W(12), SCREEN_WIDTH - 20, SCALE_W(36))];
    label1.numberOfLines = 3;
    label1.text = @"魔方工分用于奖励会员对魔方好物做出的贡献，会员通过信息分享/邀请好友/会员卡充值/完成分销任务等各种方式均可获得工分。";
    label1.font =  UIFontRegularOfSize(SCALE_W(12));
    [headView addSubview:label1];
    
    MagicLineView * line1 = [[MagicLineView alloc] initWithFrame:CGRectMake(10, SCALE_W(67.5), SCREEN_WIDTH - 20, 0.5)];
    [headView addSubview:line1];
    
    MagicLabel * fenhongLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10, SCALE_W(68), SCREEN_WIDTH - 20, SCALE_W(36))];
    fenhongLabel.font =  UIFontRegularOfSize(14);
    fenhongLabel.textColor = Gray666Color;
    [headView addSubview:fenhongLabel];
    
    UIFont *font =  UIFontMediumOfSize(16);
    NSDictionary * attubtrDict = @{NSFontAttributeName:font,NSForegroundColorAttributeName:RedMagicColor};
    NSString *deliveryPrice =@"今日工分分红  1.34元";
    NSString *price = @"  1.34元";
    NSAttributedString * attributestring = [MagicRichTool initWithString:deliveryPrice dict:attubtrDict subString:price];
    fenhongLabel.attributedText = attributestring;
    self.fenhongLabel = fenhongLabel;
    
    MagicLabel * label2 = [[MagicLabel alloc] initWithFrame:CGRectMake(10, SCALE_W(68 + 36), SCREEN_WIDTH - 20, SCALE_W(36))];
    label2.numberOfLines = 2;
    label2.text = @"魔方好物会依据每位会员的工分值，每日将总分销利润的20%作为分红奖励自动发放至会员账户。";
    label2.font =  UIFontRegularOfSize(SCALE_W(12));
    [headView addSubview:label2];
    
    MagicLineView * line2 = [[MagicLineView alloc] initWithFrame:CGRectMake(0, SCALE_W(181.5) - SCALE_W(10), SCREEN_WIDTH, SCALE_W(10))];
    [headView addSubview:line2];
    
    UIButton * inviteBGView = [[UIButton alloc] initWithFrame:CGRectMake(0, SCALE_W(181.5), SCREEN_WIDTH, SCALE_W(60))];
    
    UIImageView * iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCALE_W(10), SCALE_W(12), SCALE_W(34), SCALE_W(36))];
    iconImg.image = [UIImage imageNamed:@"invitefriend"];
    [inviteBGView addSubview:iconImg];
    
    MagicLabel * titleLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(54), SCALE_W(14), SCREEN_WIDTH - SCALE_W(54) - SCALE_W(50), SCALE_W(14))];
    titleLabel.textColor = Gray666Color;
    [inviteBGView addSubview:titleLabel];
    
    
    MagicLabel *detailLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(54), SCALE_W(34),SCREEN_WIDTH - SCALE_W(54) - SCALE_W(50), SCALE_W(12))];
    detailLabel.font = UIFontRegularOfSize(12);
    [inviteBGView addSubview:detailLabel];
    
    titleLabel.text = @"邀请好友加入魔方";
    
    
    NSDictionary * inviteattubtrDict = @{NSForegroundColorAttributeName:RedMagicColor};
    NSString *inviteString =@"我的邀请码：48484953";
    NSString *inviteNum = @"48484953";
    NSAttributedString * inviteattributestring = [MagicRichTool initWithString:inviteString dict:inviteattubtrDict subString:inviteNum];
    detailLabel.attributedText = inviteattributestring;
    self.invitedetailLabel = detailLabel;
    
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - SCALE_W(34), SCALE_W(22), SCALE_W(15), SCALE_W(16))];
    imgView.image = [UIImage imageNamed:@"rightArrow"];
    [inviteBGView addSubview:imgView];
    
    [headView addSubview:inviteBGView];
    return headView;
}

- (ZTYAlertView *)alertView{
    if (!_alertView) {
        _alertView = [[ZTYAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
    }
    return _alertView;
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
