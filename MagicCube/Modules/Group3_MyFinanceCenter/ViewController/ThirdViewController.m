//
//  ThirdViewController.m
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "ThirdViewController.h"
#import "HisstoryTableViewCell.h"
@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int current_page,total_count;
    UIImageView *redBgView;
}

@property (nonatomic, strong) NSMutableArray *listArray,*btnViewsArray,*accountArray;
@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *accountValueLabel;
@property (nonatomic, strong) UILabel *scoresLabel;
@property (nonatomic, strong) UIView *incomeView;
@property (nonatomic, strong) UIView *historyView;
@property (nonatomic, strong) UIView *listHeadView;
@property (nonatomic, strong) UIImageView *moneyView;
@property (nonatomic, strong) UILabel *moneyLabel,*moneyTitleLabel;
@property (nonatomic, strong) UIButton *checkMoneyBtn;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    [self initSubviews];
    [self requestData];
}

-(void)requestData{}

-(void)initDatas{
    self.title = @"产品详情";
    self.listArray = [NSMutableArray array];
    [self.listArray addObject:@{@"name":@"代理收入",@"price":@"¥588",@"time":@"11/12"}];
    [self.listArray addObject:@{@"name":@"团队分红",@"price":@"¥2088",@"time":@"11/12"}];
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
    self.headerImageView.image = [UIImage imageNamed:@"Bitmap"];
    [redBgView addSubview:self.headerImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(94, 61, SCREEN_WIDTH / 2, 16)];
    self.nameLabel.text = @"用户名";
    self.nameLabel.font = UIFontMediumOfSize(16);
    self.nameLabel.textColor = [UIColor whiteColor];
    [redBgView addSubview:self.nameLabel];
    
    UIImageView  *memImageLevelView = [[UIImageView alloc] initWithFrame:CGRectMake(147, 61, 15, 15)];
    memImageLevelView.image = [UIImage imageNamed:@"用户等级_shuijing"];
    [redBgView addSubview:memImageLevelView];
    
    self.accountValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(94, 90, 114, 14)];
    self.accountValueLabel.text = @"会员卡余额：¥28";
    self.accountValueLabel.font = UIFontRegularOfSize(14);
    self.accountValueLabel.textColor = [UIColor whiteColor];
    self.accountValueLabel.textAlignment = NSTextAlignmentLeft;
    [redBgView addSubview:self.accountValueLabel];
    
    self.scoresLabel = [[UILabel alloc] initWithFrame:CGRectMake(235.5, 90, 110, 14)];
    self.scoresLabel.text = @"魔方工分：456";
    self.scoresLabel.font = UIFontRegularOfSize(14);
    self.scoresLabel.textColor = [UIColor whiteColor];
    self.scoresLabel.textAlignment = NSTextAlignmentLeft;
    [redBgView addSubview:self.scoresLabel];
    
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
    
    UIImageView *pullArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"huiyuanzhongxin_more"]];
    pullArrowImageView.frame = CGRectMake(149.85, 16, 13, 12);
    [footerView addSubview:pullArrowImageView];
    
    UILabel *pullLabel = [[UILabel alloc] initWithFrame:CGRectMake(170.5, 0, 56, 44)];
    pullLabel.font = UIFontRegularOfSize(12);
    pullLabel.textAlignment = NSTextAlignmentLeft;
    pullLabel.textColor = GrayMagicColor;
    pullLabel.text = @"查看更多";
    [footerView addSubview:pullLabel];
    
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
        
        UILabel *incomeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 58, SCREEN_WIDTH / 2, 16)];
        incomeTitleLabel.textColor = BlackMagicColor;
        incomeTitleLabel.textAlignment = NSTextAlignmentLeft;
        incomeTitleLabel.font = UIFontRegularOfSize(16);
        [_incomeView addSubview:incomeTitleLabel];
        incomeTitleLabel.text = @"今日总收入";
        
        UILabel *incomeValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 130 - 10, 58, 130, 16)];
        [_incomeView addSubview:incomeValueLabel];
        incomeValueLabel.textColor = Gray666Color;
        incomeValueLabel.textAlignment = NSTextAlignmentRight;
        incomeValueLabel.font = UIFontRegularOfSize(16);
        [_incomeView addSubview:incomeValueLabel];
        incomeValueLabel.text = @"¥6380";
        
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
    for(int i = 0; i < 3 ;i++){
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        verticalLine = [[UIView alloc] init];
        titleLabel = [[UILabel alloc] init];
        delegateValueLabel = [[UILabel alloc] init];
        btn.frame = CGRectMake(i*(SCREEN_WIDTH  )/3, 88, (SCREEN_WIDTH)/3, 81);
        [self.incomeView addSubview:btn];
        btn.backgroundColor = [UIColor clearColor];
        
        delegateValueLabel.frame = CGRectMake(SCALE_W(0), SCALE_W(20),SCREEN_WIDTH/3,SCALE_W(20));
        [btn addSubview:delegateValueLabel];
        delegateValueLabel.backgroundColor  = [UIColor clearColor];
        delegateValueLabel.textAlignment = NSTextAlignmentCenter;
        delegateValueLabel.font = UIFontSemiboldOfSize(SCALE_W(16));
        delegateValueLabel.textColor = Gray666Color;
        [self.accountArray addObject:delegateValueLabel];
        
        titleLabel.frame = CGRectMake(SCALE_W(0) , SCALE_W(47), SCREEN_WIDTH/3, SCALE_W(14));
        titleLabel.font = UIFontRegularOfSize(SCALE_W(14));
        titleLabel.textColor = GrayMagicColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:titleLabel];
        if (i == 0) {
            titleLabel.text = @"代理收入";
        }
        if (i == 1) {
            titleLabel.text = @"团队分红";
        }
        if (i == 2) {
            titleLabel.text = @"工分分红";
        }
        if (i == 0) {
            delegateValueLabel.text = @"¥6380";
        }
        if (i == 1) {
            delegateValueLabel.text = @"0";
        }
        if (i == 2) {
            delegateValueLabel.text = @"0";
        }
        [btn addTarget:self action:@selector(gotoScoresList) forControlEvents:UIControlEventTouchUpInside];
        [self.btnViewsArray addObject:btn];
    }
}

-(UIView *)historyView{
    if (_historyView == nil) {
        _historyView = [[UIView alloc] initWithFrame:CGRectMake(0, self.incomeView.bottom + 10, SCREEN_WIDTH, 44)];
        _historyView.backgroundColor = [UIColor whiteColor];
        UILabel *incomeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH / 2, 44)];
        incomeTitleLabel.textColor = BlackMagicColor;
        incomeTitleLabel.textAlignment = NSTextAlignmentLeft;
        incomeTitleLabel.font = UIFontRegularOfSize(16);
        [_historyView addSubview:incomeTitleLabel];
        incomeTitleLabel.text = @"历史收入明细";
        
        
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
        clientNameLabel.text = @"客户名称";
        
        UILabel *getMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(197.5, 0, 28, 42)];
        getMoneyLabel.textColor = GrayMagicColor;
        getMoneyLabel.textAlignment = NSTextAlignmentRight;
        getMoneyLabel.font = UIFontRegularOfSize(14);
        [_listHeadView addSubview:getMoneyLabel];
        getMoneyLabel.text = @"收入";
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 28 -20, 0, 28, 42)];
        timeLabel.textColor = GrayMagicColor;
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.font = UIFontRegularOfSize(14);
        [_listHeadView addSubview:timeLabel];
        timeLabel.text = @"时间";
    }
    return _listHeadView;
}

-(UIImageView *)moneyView{
    if (_moneyView == nil) {
        _moneyView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 365)/2, 125, 365 ,76)];
        _moneyView.image = [UIImage imageNamed:@"矩形"];
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
        _moneyLabel.font = UIFontRegularOfSize(24);
        _moneyLabel.text = @"¥6380";
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


@end
