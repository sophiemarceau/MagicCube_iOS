//
//  SecondViewController.m
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "SecondViewController.h"
#import "MyGoodsTableViewCell.h"
#import "GoodsDetailViewController.h"

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
    self.title = @"我的好物";
}

- (void)createFakeData{
    for (int i = 0; i < 20; i ++) {
        [_goodsArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
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
    MyGoodsTableViewCell * goodsCell = [tableView dequeueReusableCellWithIdentifier:@"myGoods"];
    if (!goodsCell) {
        goodsCell = [[MyGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"myGoods"];
    }
    [goodsCell configDict:@{}];
    return goodsCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsDetailViewController * goodsDetail = [[GoodsDetailViewController alloc] init];
    [self.navigationController pushViewController:goodsDetail animated:YES];
}

@end
