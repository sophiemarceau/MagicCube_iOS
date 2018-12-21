//
//  SecondViewController.m
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "SecondViewController.h"
//#import "MyGoodsTableViewCell.h"
#import "MagicCardTableViewCell.h"
#import "DistributionShareViewController.h"
#import "DistributeDetailViewController.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSMutableArray * goodsArray;
@property (strong,nonatomic) UITableView * tableView;
@property (assign,nonatomic) NSInteger pageNum;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self goodsInit];
    [self addSubViews];
    [self requestList:self.pageNum];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
#pragma mark -- 数据
- (void)requestList:(NSInteger)pageNum{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:[NSString stringWithFormat:@"%ld",pageNum] forKey:@"pageNum"];
    [params setObject:@"10" forKey:@"pageSize"];
    WS(weakSelf)
//    NSLog(@"-----kAppApiDistributionList--->%@",params);
    NMShowLoadIng;
    
    [BTERequestTools requestWithURLString:kAppApiDistributionList parameters:params type:HttpRequestTypeGet success:^(id responseObject) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        NMRemovLoadIng;
        NSLog(@"---kAppApiDistributionList--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            NSArray * list = [[responseObject objectForKey:@"data"] objectForKey:@"list"];
            [weakSelf.goodsArray addObjectsFromArray:list];
            [weakSelf.tableView reloadData];
        }else{
//            NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
//            [BHToast showMessage:message];
        }
    } failure:^(NSError *error)  {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
}

- (void)goodsInit{
    _goodsArray = [NSMutableArray arrayWithCapacity:0];
    self.pageNum = 1;
    self.title = @"分销中心";
    self.view.backgroundColor =  [UIColor whiteColor];
}

#pragma mark -- 视图
- (void)addSubViews{
    UITableView * tabelview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_HEIGHT - HOME_INDICATOR_HEIGHT - 49) style:UITableViewStylePlain];
    tabelview.delegate = self;
    tabelview.dataSource = self;
    tabelview.rowHeight = [MagicCardTableViewCell cellHeight];
    tabelview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabelview.tableFooterView = [UIView new];
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(14.5))];
    tabelview.tableHeaderView = headView;
    [self.view addSubview:tabelview];
    self.tableView = tabelview;
    
    WS(weakSelf);
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNum = 1;
        [weakSelf.goodsArray removeAllObjects];
        [self requestList:weakSelf.pageNum];
    }];
    tabelview.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestList:weakSelf.pageNum];
    }];
    tabelview.mj_footer = footer;
    
}

#pragma mark -- tableview 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MagicCardTableViewCell * goodsCell = [tableView dequeueReusableCellWithIdentifier:@"myGoods"];
    if (!goodsCell) {
        goodsCell = [[MagicCardTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"myGoods"];
    }
    
    [goodsCell configDataDict:_goodsArray[indexPath.row]];
    return goodsCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    DistributeDetailViewController * goodsDetail = [[DistributeDetailViewController alloc] init];
    DistributionShareViewController * goodsDetail = [[DistributionShareViewController alloc] init];
    [self.navigationController pushViewController:goodsDetail animated:YES];
}

@end
