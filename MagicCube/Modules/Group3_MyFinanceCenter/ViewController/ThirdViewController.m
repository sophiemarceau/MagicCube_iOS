//
//  ThirdViewController.m
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "ThirdViewController.h"
#import "HisstoryTableViewCell.h"
#import "NSString+Size.h"
#import "SettingViewController.h"
@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int current_page,total_count;
    UIImageView *redBgView;
}
@property (nonatomic, strong) NSMutableArray *listArray,*btnViewsArray,*accountArray;
@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) UIImageView *headerImageView,*memImageLevelView;
@property (nonatomic, strong) UILabel *nameLabel,*namedesLabel;
//@property (nonatomic, strong) UILabel *accountValueLabel;
//@property (nonatomic, strong) UILabel *scoresLabel;
@property (nonatomic, strong) UIView *incomeView;
@property (nonatomic, strong) UIView *historyView;
@property (nonatomic, strong) UIView *listHeadView;
@property (nonatomic, strong) UIImageView *moneyView;
@property (nonatomic, strong) UILabel *moneyLabel,*moneyTitleLabel,*incomeValueLabel;
@property (nonatomic, strong) UIButton *checkMoneyBtn,*settingBtn;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    [self initSubviews];
}

-(void)requestInfoData{
    NSMutableDictionary * pramaDic = @{}.mutableCopy;
    [pramaDic setObject:User.token forKey:@"CUBE-TOKEN"];
    [BTERequestTools requestWithURLString:kAppApiGetAccount parameters:pramaDic type:HttpRequestTypeGet success:^(id responseObject) {
        NMRemovLoadIng;
        NSLog(@"---kAppApiGetAccount--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            NSDictionary *dic = [responseObject objectForKey:@"data"];
            NSDictionary *infoDic = [dic objectForKey:@"userInfo"];
            NSArray *memberRuleArray = [dic objectForKey:@"memberRule"];
            NSDictionary *todayDic = [dic objectForKey:@"todayIncome"];
            NSArray *accountArray = [dic objectForKey:@"account"];
    
            [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"Bitmap"]];
            NSString *telStr =  stringFormat([infoDic objectForKey:@"tel"]);
            NSString *nickNameStr =  stringFormat([infoDic objectForKey:@"nickname"]);
            if ([telStr isEqualToString:nickNameStr]) {
              NSString *nameStr =  [NSString stringWithFormat:@"%@****%@",[nickNameStr substringToIndex:4],[nickNameStr substringFromIndex:7]];
              CGFloat widh = [nameStr widthWithFont: UIFontMediumOfSize(16) constrainedToHeight:16];
                if (widh < SCREEN_WIDTH - self.nameLabel.frame.origin.x - 85) {
                    self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.origin.y, widh, 16);
                }else{
                    self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.origin.y, SCREEN_WIDTH - self.nameLabel.frame.origin.x - 40, 16);
                }
                self.nameLabel.text = nameStr;
            }else{
                self.nameLabel.text = nickNameStr;
            }
            self.memImageLevelView.frame = CGRectMake(self.nameLabel.right +10, 61, 15, 15);
//            self.namedesLabel.frame = CGRectMake(self.memImageLevelView.right +10, 64, 40, 10);

           
            if(accountArray && accountArray.count > 0){
                for (NSDictionary *tempDic  in accountArray) {
                    if ([tempDic[@"type"] isEqualToString:@"BALANCE"]) {
                        self.moneyLabel.text = [NSString stringWithFormat: @"¥%@",[tempDic objectForKey:@"available"]];
                    }
                    if ([tempDic[@"type"] isEqualToString:@"MEMBER"]) {
//                        self.accountValueLabel.text =  [NSString stringWithFormat: @"会员卡余额：¥%@",[tempDic objectForKey:@"available"]];
                    }
                    if ([tempDic[@"type"] isEqualToString:@"POINT"]) {
//                         self.scoresLabel.text = [NSString stringWithFormat: @"魔方工分：%@",[tempDic objectForKey:@"available"]];
                    }
                }
            }
            
//            if(memberRuleArray && memberRuleArray.count > 0){
//                NSString *memberLevel = stringFormat([infoDic objectForKey:@"memberLevel"]);
//                for (NSDictionary *tempDic  in memberRuleArray) {
//                    if ([stringFormat([infoDic objectForKey:@"level"]) isEqualToString:memberLevel]) {
//                        self.memImageLevelView.hidden = NO;
////                        self.namedesLabel.hidden = NO;
//                        if ([memberLevel isEqualToString:@"1"]) {
//                            self.memImageLevelView.image = [UIImage imageNamed:@"putonghuiyuan"];
//                        }
//                        if ([memberLevel isEqualToString:@"2"]) {
//                            self.memImageLevelView.image = [UIImage imageNamed:@"baijinhuiyuan"];
//                        }
//                        if ([memberLevel isEqualToString:@"3"]) {
//                            self.memImageLevelView.image = [UIImage imageNamed:@"huangjinhuiyuan"];
//                        }
//                        if ([memberLevel isEqualToString:@"4"]) {
//                            self.memImageLevelView.image = [UIImage imageNamed:@"zuanshihuiyuan"];
//                        }
//                        self.namedesLabel.text = [NSString stringWithFormat: @"%@",[tempDic objectForKey:@"name"]];
//                    }else{
//                        self.memImageLevelView.image = [UIImage imageNamed:@"putonghuiyuan"];
//                        self.namedesLabel.hidden = YES;
//                    }
//                }
//            }
            
            
            for(int i = 0; i < self.accountArray.count ;i++){
                UILabel *tempLabel = self.accountArray[i];
                if (i == 0) {
                    tempLabel.text = stringFormat( [todayDic objectForKey:@"distribution"]);
                }
                if (i == 1) {
                    tempLabel.text =stringFormat( [todayDic objectForKey:@"team"]);
                }
//                if (i == 2) {
//                    tempLabel.text =stringFormat( [todayDic objectForKey:@"point"]);
//                }
            }
            self.incomeValueLabel.text = [NSString stringWithFormat:@"¥%ld", [[todayDic objectForKey:@"distribution"] integerValue]+[[todayDic objectForKey:@"team"] integerValue]+[[todayDic objectForKey:@"point"] integerValue]];
        }
    } failure:^(NSError *error)  {
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
}

-(void)requestIncomeData{
    NSMutableDictionary *pramaDic = @{}.mutableCopy;
    [pramaDic setObject:User.token forKey:@"CUBE-TOKEN"];
    [BTERequestTools requestWithURLString:kAppApiGetIncome parameters:pramaDic type:HttpRequestTypeGet success:^(id responseObject) {
        NMRemovLoadIng;
//        NSLog(@"---kAppApiGetIncome--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            NSArray *array = [responseObject objectForKey:@"data"][@"list"];
            if (array && array.count> 0) {
                [self.listArray removeAllObjects];
                [self.listArray addObjectsFromArray:array];
                [self.listView reloadData];
            }
        }
    } failure:^(NSError *error)  {
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
}

-(void)gotoSettingClick{
    SettingViewController * settingVC = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

-(void)initDatas{
    self.title = @"产品详情";
    self.listArray = [NSMutableArray array];
}

-(void)initSubviews{
    [self.view addSubview:self.listView];
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        self.listView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.listView.contentInset = UIEdgeInsetsMake(0, 0, TAB_BAR_HEIGHT, 0);
    self.listView.scrollIndicatorInsets = self.listView.contentInset;
}

-(void)gotoScoresList{}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HisstoryTableViewCell cellHeight];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"detailCell";
    HisstoryTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HisstoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell configwidth:self.listArray[indexPath.row]];
    return cell;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self requestIncomeData];
    [self requestInfoData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark  initView
-(UITableView *)listView{
    if (_listView == nil) {
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT  - TAB_BAR_HEIGHT)];
        _listView.dataSource = self;
        _listView.delegate = self;
        _listView.backgroundColor = KBGColor;
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self setTableHeadView];
        [self setTableFooterView];
    }
    return _listView;
}

- (void)setTableHeadView{
    UIView *headbgview = [[UIView alloc] initWithFrame:CGRectZero];
    headbgview.backgroundColor = KBGColor;
    
    redBgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    redBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 162);
    redBgView.image = [UIImage imageNamed:@"redBgIcon"];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 60, 60)];
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.layer.cornerRadius = 30;
    [redBgView addSubview:self.headerImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(94, 61, SCREEN_WIDTH / 2, 16)];
   
    self.nameLabel.font = UIFontMediumOfSize(16);
    self.nameLabel.textColor = [UIColor whiteColor];
    [redBgView addSubview:self.nameLabel];
    
//    self.memImageLevelView = [[UIImageView alloc] initWithFrame:CGRectMake(147, 61, 15, 15)];
//
//    [redBgView addSubview:self.memImageLevelView];
    
//    self.namedesLabel = [[UILabel alloc] initWithFrame:CGRectMake(167, 64, 40, 10)];
//    self.namedesLabel.font = UIFontLightOfSize(10);
//    self.namedesLabel.textColor = [UIColor whiteColor];
//    [redBgView addSubview:self.namedesLabel];
    
//    self.accountValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(94, 90, 114, 14)];
//
//    self.accountValueLabel.font = UIFontRegularOfSize(14);
//    self.accountValueLabel.textColor = [UIColor whiteColor];
//    self.accountValueLabel.textAlignment = NSTextAlignmentLeft;
//    [redBgView addSubview:self.accountValueLabel];
    
//    self.scoresLabel = [[UILabel alloc] initWithFrame:CGRectMake(235.5, 90, 110, 14)];
//    self.scoresLabel.font = UIFontRegularOfSize(14);
//    self.scoresLabel.textColor = [UIColor whiteColor];
//    self.scoresLabel.textAlignment = NSTextAlignmentLeft;
//    [redBgView addSubview:self.scoresLabel];
    redBgView.userInteractionEnabled = YES;
    [redBgView addSubview:self.settingBtn];
    [headbgview addSubview:redBgView];
    [headbgview addSubview:self.incomeView];
    [headbgview addSubview:self.historyView];
    [headbgview addSubview:self.listHeadView];
    [headbgview addSubview:self.moneyView];
    self.listHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, self.historyView.bottom, SCREEN_WIDTH, 42)];
    
    self.listHeadView.backgroundColor = KBGColor;
    headbgview.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.listHeadView.bottom);
    self.listView.tableHeaderView = headbgview;
}

- (void)setTableFooterView{
    UIView *footerView;
    footerView = [[UIView alloc] initWithFrame:CGRectZero];
    footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    footerView.backgroundColor = [UIColor whiteColor];
    UILabel *pullLabel = [[UILabel alloc] initWithFrame:CGRectMake(151, 0, 56, 44)];
    pullLabel.font = UIFontRegularOfSize(14);
    pullLabel.textAlignment = NSTextAlignmentLeft;
    pullLabel.textColor = GrayMagicColor;
    pullLabel.text = @"查看明细";
    [footerView addSubview:pullLabel];
    
    UIImageView *pullArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"huiyuanzhongxin_more"]];
    pullArrowImageView.frame = CGRectMake(pullLabel.right +5, 16.35, 12, 13);
    [footerView addSubview:pullArrowImageView];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = LineGrayColor;
    [footerView addSubview:lineView];
    
    self.listView.tableFooterView = footerView;
}

-(UIView *)incomeView{
    if (_incomeView == nil) {
        _incomeView = [[UIView alloc] initWithFrame:CGRectMake(0, redBgView.bottom, SCREEN_WIDTH, 169.5)];
        _incomeView.backgroundColor = KBGCell;
        
        UIView *lineView= [[UIView alloc] initWithFrame:CGRectMake(0, 88, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = LineGrayColor;
        [_incomeView addSubview:lineView];
        
        UILabel *incomeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 58, SCREEN_WIDTH / 2, 14)];
        incomeTitleLabel.textColor = Gray666Color;
        incomeTitleLabel.textAlignment = NSTextAlignmentLeft;
        incomeTitleLabel.font = UIFontLightOfSize(14);
        [_incomeView addSubview:incomeTitleLabel];
        incomeTitleLabel.text = @"今日总收入";
        
        self.incomeValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 130 - 10, 58, 130, 16)];
        [_incomeView addSubview:self.incomeValueLabel];
        self.incomeValueLabel.textColor = Gray666Color;
        self.incomeValueLabel.textAlignment = NSTextAlignmentRight;
        self.incomeValueLabel.font = UIFontMediumOfSize(16);
        [_incomeView addSubview:self.incomeValueLabel];
       
        
        [self setDelegatetView];
    }
    return _incomeView;
}

-(void)setDelegatetView{
    UIButton *btn;
    UILabel *delegateValueLabel;
    UILabel *titleLabel;
    UIView *verticalLine;
    self.btnViewsArray = [NSMutableArray array];
    self.accountArray = [NSMutableArray array];
    for(int i = 0; i < 2 ;i++){
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        verticalLine = [[UIView alloc] init];
        titleLabel = [[UILabel alloc] init];
        delegateValueLabel = [[UILabel alloc] init];
        btn.frame = CGRectMake(i*(SCREEN_WIDTH  )/2, 88, (SCREEN_WIDTH)/2, 81);
        [self.incomeView addSubview:btn];
        btn.backgroundColor = [UIColor clearColor];
        
        delegateValueLabel.frame = CGRectMake(SCALE_W(0), SCALE_W(20),SCREEN_WIDTH/2,SCALE_W(20));
        [btn addSubview:delegateValueLabel];
        delegateValueLabel.backgroundColor  = [UIColor clearColor];
        delegateValueLabel.textAlignment = NSTextAlignmentCenter;
        delegateValueLabel.font = UIFontRegularOfSize(SCALE_W(16));
        delegateValueLabel.textColor = Gray666Color;
        [self.accountArray addObject:delegateValueLabel];
        
        titleLabel.frame = CGRectMake(SCALE_W(0) , SCALE_W(47), SCREEN_WIDTH/2, SCALE_W(14));
        titleLabel.font = UIFontRegularOfSize(SCALE_W(14));
        titleLabel.textColor = GrayMagicColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:titleLabel];
        if (i == 0) {
            titleLabel.text = @"发卡收入";
        }
        if (i == 1) {
            titleLabel.text = @"互动收入";
        }
//        if (i == 2) {
//            titleLabel.text = @"工分分红";
//        }
//        if (i == 0) {
//            delegateValueLabel.text = @"¥6380";
//        }
//        if (i == 1) {
//            delegateValueLabel.text = @"0";
//        }
//        if (i == 2) {
//            delegateValueLabel.text = @"0";
//        }
        [btn addTarget:self action:@selector(gotoScoresList) forControlEvents:UIControlEventTouchUpInside];
        [self.btnViewsArray addObject:btn];
    }
}

-(UIView *)historyView{
    if (_historyView == nil) {
        _historyView = [[UIView alloc] initWithFrame:CGRectMake(0, self.incomeView.bottom + 10, SCREEN_WIDTH, 44)];
        _historyView.backgroundColor = [UIColor whiteColor];
        UILabel *incomeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH / 2, 44)];
        incomeTitleLabel.textColor = Gray666Color;
        incomeTitleLabel.textAlignment = NSTextAlignmentLeft;
        incomeTitleLabel.font = UIFontLightOfSize(14);
        [_historyView addSubview:incomeTitleLabel];
        incomeTitleLabel.text = @"历史收入汇总";
        
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = LineGrayColor;
        [_historyView addSubview:lineView];
    }
    return _historyView;
}

-(UIView *)listHeadView{
    if (_listHeadView == nil) {
        _listHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, self.historyView.bottom, SCREEN_WIDTH, 42)];
        _listHeadView.backgroundColor = [UIColor whiteColor];
        
        UILabel *clientNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 60, 42)];
        clientNameLabel.textColor = GrayMagicColor;
        clientNameLabel.textAlignment = NSTextAlignmentLeft;
        clientNameLabel.font = UIFontRegularOfSize(14);
        [_listHeadView addSubview:clientNameLabel];
        clientNameLabel.text = @"日期";
        
//        UILabel *getMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(197.5, 0, 28, 42)];
//        getMoneyLabel.textColor = GrayMagicColor;
//        getMoneyLabel.textAlignment = NSTextAlignmentRight;
//        getMoneyLabel.font = UIFontRegularOfSize(14);
//        [_listHeadView addSubview:getMoneyLabel];
//        getMoneyLabel.text = @"收入";
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 28 -20, 0, 28, 42)];
        timeLabel.textColor = GrayMagicColor;
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.font = UIFontRegularOfSize(14);
        [_listHeadView addSubview:timeLabel];
        timeLabel.text = @"收入";
    }
    return _listHeadView;
}

-(UIImageView *)moneyView{
    if (_moneyView == nil) {
        _moneyView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 365)/2, 125, 365 ,76)];
        _moneyView.image = [UIImage imageNamed:@"白底矩形"];
        [_moneyView addSubview:self.moneyLabel];
        [_moneyView addSubview:self.moneyTitleLabel];
        [_moneyView addSubview:self.checkMoneyBtn];
    }
    return _moneyView;
}

-(UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 26, 72 , 24)];
        _moneyLabel.textColor = Gray666Color;
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        _moneyLabel.font = UIFontMediumOfSize(24);
       
    }
    return _moneyLabel;
}

-(UILabel *)moneyTitleLabel{
    if (_moneyTitleLabel == nil) {
        _moneyTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.moneyLabel.right + 10, 35, 48, 12)];
        _moneyTitleLabel.textColor = Gray666Color;
        _moneyTitleLabel.textAlignment = NSTextAlignmentLeft;
        _moneyTitleLabel.font = UIFontRegularOfSize(12);
        _moneyTitleLabel.text = @"账户余额";
    }
    return _moneyTitleLabel;
}

-(UIButton *)checkMoneyBtn{
    if (_checkMoneyBtn == nil) {
        _checkMoneyBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.moneyView.width - 25- 93.5, 22, 93.5, 32)];
        _checkMoneyBtn.titleLabel.font = UIFontRegularOfSize(16);
        [_checkMoneyBtn setTitle:@"提现" forState:UIControlStateNormal];
        [_checkMoneyBtn setBackgroundColor:RedMagicColor];
        [_checkMoneyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _checkMoneyBtn.layer.masksToBounds = YES;
        _checkMoneyBtn.layer.cornerRadius = 4;
    }
    return _checkMoneyBtn;
}


-(UIButton *)settingBtn{
    if (_settingBtn == nil) {
        _settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - SCALE_W(68), SCALE_W(68), SCALE_W(68), SCALE_W(24))];
        [_settingBtn setTitleColor:BHColorWhite forState:UIControlStateNormal];
        [_settingBtn setTitle:@"设置" forState:UIControlStateNormal];
        [_settingBtn addTarget:self action:@selector(gotoSettingClick) forControlEvents:UIControlEventTouchUpInside];
        _settingBtn.titleLabel.font = UIFontRegularOfSize(14);
        _settingBtn.tag = 3001;
    }
    return _settingBtn;
}

@end
