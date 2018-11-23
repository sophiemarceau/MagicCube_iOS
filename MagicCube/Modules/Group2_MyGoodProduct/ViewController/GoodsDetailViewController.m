//
//  GoodsDetailViewController.m
//  MagicCube
//
//  Created by wanmeizty on 22/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "MyGoodsTableViewCell.h"
#import "SalerTableViewCell.h"
#import "TableTitleHeadView.h"

@interface GoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSMutableArray * dataArray;
@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initdata];
    [self createfakeData];
    [self addSubviews];
    // Do any additional setup after loading the view.
}

-(void)initdata{
    self.title = @"我的好物";
    _dataArray = [NSMutableArray arrayWithCapacity:0];
}

- (void)createfakeData{
    for (int i = 0; i < 20; i ++) {
        [_dataArray addObject:@""];
    }
}

- (void)addSubviews{
    UITableView * tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT - NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.tableFooterView = [UIView new];
    [self.view addSubview:tableview];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return _dataArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MyGoodsTableViewCell * goodscell = [tableView dequeueReusableCellWithIdentifier:@"goodsCell"];
        if (!goodscell) {
            goodscell = [[MyGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"goodsCell"];
        }
        [goodscell configDict:@{}];
        return goodscell;
    }else{
        SalerTableViewCell * saleCell = [tableView dequeueReusableCellWithIdentifier:@"salecell"];
        if (!saleCell) {
            saleCell = [[SalerTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"salecell"];
        }
        [saleCell configDict:@{}];
        return saleCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 42 + 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [MyGoodsTableViewCell cellHeight];
    }else{
        return [SalerTableViewCell cellHeight];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
    }else{
        UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44 + 42)];
        headView.backgroundColor = [UIColor whiteColor];
        TableTitleHeadView * headtile = [[TableTitleHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [headtile setUpTitle:@"销售记录"];
        [headView addSubview:headtile];
        
        CGFloat width = (SCREEN_WIDTH - 20) / 3.0;
        NSArray * titles = @[@"客户名称",@"销售价格",@"销售时间"];
        int index = 0;
        for (NSString * title in titles) {
            MagicLabel * label = [[MagicLabel alloc] initWithFrame:CGRectMake(10 + index * width, 44, width, 41.5)];
            label.textColor = Gray666Color;
            [headView addSubview:label];
            label.text = title;
            if (index != 0) {
                label.textAlignment = NSTextAlignmentRight;
            }
            index ++;
        }
        MagicLineView *lineView2 = [[MagicLineView alloc] initWithFrame:CGRectMake(0, 42 + 43.5, SCREEN_WIDTH, 0.5)];
        [headView addSubview:lineView2];
        return headView;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
