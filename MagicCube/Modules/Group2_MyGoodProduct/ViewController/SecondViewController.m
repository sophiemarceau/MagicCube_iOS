//
//  SecondViewController.m
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "SecondViewController.h"
#import "MyGoodsTableViewCell.h"
#import "TempImageTableViewCell.h"
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
    self.pageNum = 1;
    [self goodsInit];
    [self createFakeData];
    [self addSubViews];
    [self requestList:self.pageNum];
}

#pragma mark -- 数据
- (void)requestList:(NSInteger)pageNum{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:[NSString stringWithFormat:@"%ld",pageNum] forKey:@"pageNum"];
    [params setObject:@"10" forKey:@"pageSize"];
    WS(weakSelf)
    NSLog(@"-----kAppApiDistributionList--->%@",params);
    NMShowLoadIng;
    
    [BTERequestTools requestWithURLString:kAppApiDistributionList parameters:params type:HttpRequestTypeGet success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        NMRemovLoadIng;
        NSLog(@"---kAppApiDistributionList--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            
        }else{
            NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
            [BHToast showMessage:message];
        }
    } failure:^(NSError *error)  {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
}

- (void)goodsInit{
    _goodsArray = [NSMutableArray arrayWithCapacity:0];
    self.title = @"分销中心";
    self.view.backgroundColor =  [UIColor whiteColor];
}

- (void)createFakeData{
    [_goodsArray addObjectsFromArray:@[@"分销中心_1",@"分销中心_2"]];
}


#pragma mark -- 视图
- (void)addSubViews{
    UITableView * tabelview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_HEIGHT - HOME_INDICATOR_HEIGHT - 49) style:UITableViewStylePlain];
    tabelview.delegate = self;
    tabelview.dataSource = self;
    tabelview.rowHeight = [MyGoodsTableViewCell cellHeight];
    tabelview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabelview.tableFooterView = [UIView new];
    [self.view addSubview:tabelview];
    self.tableView = tabelview;
    
    WS(weakSelf);
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNum = 1;
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
    TempImageTableViewCell * goodsCell = [tableView dequeueReusableCellWithIdentifier:@"myGoods"];
    if (!goodsCell) {
        goodsCell = [[TempImageTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"myGoods"];
    }
    
    [goodsCell configDict:_goodsArray[indexPath.row]];
    return goodsCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    DistributeDetailViewController * goodsDetail = [[DistributeDetailViewController alloc] init];
    DistributionShareViewController * goodsDetail = [[DistributionShareViewController alloc] init];
    [self.navigationController pushViewController:goodsDetail animated:YES];
}

@end
