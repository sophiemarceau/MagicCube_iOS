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
}
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) UITableView *listView;
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
    UIView *bgView;
    bgView = [[UIView alloc] initWithFrame:CGRectZero];
//    [bgView addSubview:self.headerView];
//    [bgView addSubview:self.memberView];
//    [bgView addSubview:self.productInfoView];
//    [bgView addSubview:self.highPullView];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 162);
    bgView.backgroundColor = RedMagicColor;
    self.listView.tableHeaderView = bgView;
}

- (void)setTableFooterView{
    UIView *footerView;
    footerView = [[UIView alloc] initWithFrame:CGRectZero];
    footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *pullArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shangla"]];
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
@end
