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
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self goodsInit];
    [self createFakeData];
    [self addSubViews];
    
}

- (void)goodsInit{
    _goodsArray = [NSMutableArray arrayWithCapacity:0];
    self.title = @"分销中心";
    self.view.backgroundColor =  [UIColor whiteColor];
}

- (void)createFakeData{
    [_goodsArray addObjectsFromArray:@[@"分销中心_1",@"分销中心_2"]];
}

- (void)addSubViews{
    UITableView * tabelview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_HEIGHT - HOME_INDICATOR_HEIGHT - 49) style:UITableViewStylePlain];
    tabelview.delegate = self;
    tabelview.dataSource = self;
    tabelview.rowHeight = [MyGoodsTableViewCell cellHeight];
    tabelview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabelview.tableFooterView = [UIView new];
    [self.view addSubview:tabelview];
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
