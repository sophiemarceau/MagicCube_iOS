
//
//  ProductDetailViewController.m
//  MagicCube
//
//  Created by sophiemarceau_qu on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "MemberView.h"
#import "ProducDetailtHeaderView.h"
#import "ProductInfoView.h"
@interface ProductDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MemberView *memberView;
@property (nonatomic, strong) ProducDetailtHeaderView *headerView;
@property (nonatomic, strong) ProductInfoView *productInfoView;
@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) UIButton *highPullView;
@property (nonatomic, strong) UIButton *bottomBtn;
@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    [self initSubviews];
    [self requestData];
}

-(void)requestData{}

-(void)initDatas{
    self.title = @"产品详情";
}

-(void)initSubviews{
    [self.view addSubview:self.listView];
    [self.view addSubview:self.bottomBtn];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"detailCell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}

#pragma mark  initView
-(UITableView *)listView{
    if (_listView == nil) {
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT  - NAVIGATION_HEIGHT - 45)];
        _listView.dataSource = self;
        _listView.delegate = self;
        _listView.backgroundColor = KBGColor;
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self setTableHeadView];
    }
    return _listView;
}

- (void)setTableHeadView{
    UIView *bgView;
    bgView = [[UIView alloc] initWithFrame:CGRectZero];
    [bgView addSubview:self.headerView];
    [bgView addSubview:self.memberView];
    [bgView addSubview:self.productInfoView];
    [bgView addSubview:self.highPullView];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.highPullView.bottom);
    bgView.backgroundColor = KBGColor;
    self.listView.tableHeaderView = bgView;
}

-(ProducDetailtHeaderView *) headerView{
    if (_headerView == nil ) {
        _headerView = [[ProducDetailtHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT ,175+114)];
    }
    return _headerView;
}

-(MemberView *)memberView{
    if (_memberView == nil) {
        _memberView = [[MemberView alloc] initWithFrame:CGRectMake(0, 299, SCREEN_WIDTH, 110)];
        _memberView.backgroundColor = [UIColor whiteColor];
        [_memberView.updateMemBtn addTarget:self action:@selector(gotoUpdateOnclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _memberView;
}

-(ProductInfoView *)productInfoView{
    if (_productInfoView == nil) {
        _productInfoView = [[ProductInfoView alloc] initWithFrame:CGRectMake(0, 419, SCREEN_WIDTH, 257.5)];
    }
    return _productInfoView;
}

-(UIButton *)highPullView{
    if (_highPullView == nil) {
        _highPullView = [[UIButton alloc] initWithFrame:CGRectMake(0, 686.5, SCREEN_WIDTH, 44)];
        _highPullView.backgroundColor = [UIColor whiteColor];
        UIImageView *pullArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shangla"]];
        pullArrowImageView.frame = CGRectMake(130.5, 16, 13, 12);
        [_highPullView addSubview:pullArrowImageView];
        UILabel *pullLabel = [[UILabel alloc] initWithFrame:CGRectMake(148.5, 0, 96, 44)];
        pullLabel.font = UIFontRegularOfSize(12);
        pullLabel.textAlignment = NSTextAlignmentLeft;
        pullLabel.textColor = Gray666Color;
        pullLabel.text = @"上拉查看产品详情";
         [_highPullView addSubview:pullLabel];
         [_highPullView addTarget:self action:@selector(highPullOnclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _highPullView;
}

-(UIButton *)bottomBtn{
    if (_bottomBtn == nil) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.frame = CGRectMake(0, SCREEN_HEIGHT - NAVIGATION_HEIGHT - 45, SCREEN_WIDTH, 45);
        _bottomBtn.backgroundColor = RedMagicColor;
         [_bottomBtn addTarget:self action:@selector(delegateOnclick:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *btnTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, SCREEN_WIDTH, 16)];
        btnTitleLabel.font = UIFontRegularOfSize(16);
        btnTitleLabel.textAlignment = NSTextAlignmentCenter;
        btnTitleLabel.textColor = [UIColor whiteColor];
        btnTitleLabel.text = @"我要做代理";
        [_bottomBtn addSubview:btnTitleLabel];
        
        UILabel *btnSubLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 29, SCREEN_WIDTH, 10)];
        btnSubLabel.font = UIFontRegularOfSize(10);
        btnSubLabel.textAlignment = NSTextAlignmentCenter;
        btnSubLabel.textColor = [UIColor whiteColor];
        btnSubLabel.text = @"0成本进货，卖出即分成";
        [_bottomBtn addSubview:btnSubLabel];
    }
    return _bottomBtn;
}

-(void)gotoUpdateOnclick:(UIButton *)sender{
    NSLog(@"gotoUpdateOnclick");
}

-(void)highPullOnclick:(UIButton *)sender{
    NSLog(@"highPullOnclick");
}

-(void)delegateOnclick:(UIButton *)sender{
    NSLog(@"delegateOnclick");
    
    NSString *message;
    NSString *messageString = [NSString stringWithFormat:@"代理本产品需要从会员卡扣除1元代理费，是否继续"];
    message = NSLocalizedString(messageString,nil);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];

    NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:message];
    [messageAtt addAttribute:NSFontAttributeName value:UIFontRegularOfSize(16) range:NSMakeRange(0, message.length)];
    [messageAtt addAttribute:NSForegroundColorAttributeName value:Black626A75Color range:NSMakeRange(0, message.length)];
    [alertController setValue:messageAtt forKey:@"attributedMessage"];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消",nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确认",nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        
    }];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
