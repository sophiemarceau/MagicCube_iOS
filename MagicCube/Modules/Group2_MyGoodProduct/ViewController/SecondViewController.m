//
//  SecondViewController.m
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "SecondViewController.h"
#import "MagicCardTableViewCell.h"
#import "DistributionShareViewController.h"
#import "DistributeDetailViewController.h"
#import "MagicNODataView.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSMutableArray * goodsArray;
@property (strong,nonatomic) UITableView * tableView;
@property (assign,nonatomic) NSInteger pageNum;
@property (strong,nonatomic) MagicNODataView * nodataView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self goodsInit];
    [self addSubViews];
//    [self requestList:self.pageNum];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDistibuteList) name:NotificationUpdateDistributionList object:nil];
}

- (void)updateDistibuteList{
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
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
            NSDictionary * dataDict = [responseObject objectForKey:@"data"];
            if (dataDict) {
                if (pageNum == [[dataDict objectForKey:@"pageNum"] integerValue]) {
                    NSArray * list = [dataDict objectForKey:@"list"];
                    [weakSelf.goodsArray addObjectsFromArray:list];
                    [weakSelf.tableView reloadData];
                }
                if (pageNum == [[dataDict objectForKey:@"lastPage"] integerValue]) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                
                if (self.goodsArray.count == 0) {
                    self.nodataView.hidden = NO;
                }else{
                    self.nodataView.hidden = YES;
                }
            }
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


- (void)requestDelete:(NSString *)sn sucess:(void(^)(void))success{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
   
    [params setObject:sn forKey:@"pageSize"];
    NSString * url = [NSString stringWithFormat:@"%@%@/del",kAppApiDistribution,sn];
    WS(weakSelf)
    //    NSLog(@"-----kAppApiDistributionList--->%@",params);
    NMShowLoadIng;
    
    [BTERequestTools requestWithURLString:url parameters:params type:HttpRequestTypeGet success:^(id responseObject) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        NMRemovLoadIng;
        NSLog(@"---kAppApiDistributionList--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            success();
        }else{
            
        }
        NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
        [BHToast showMessage:message];
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
//    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(14.5))];
//    tabelview.tableHeaderView = headView;
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
        weakSelf.pageNum ++;
        [self requestList:weakSelf.pageNum];
    }];
    tabelview.mj_footer = footer;
    
    
    self.nodataView = [[MagicNODataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_HEIGHT - HOME_INDICATOR_HEIGHT - 49)];
    self.nodataView.hidden = YES;
    [self.nodataView setUpImageName:@"sendnodata" title:@"还没有可发放的卡片" addShow:YES];
    [self.view addSubview:self.nodataView];
    
    
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
    
    NSDictionary * goodsDict = _goodsArray[indexPath.row];
    DistributionShareViewController * goodsDetail = [[DistributionShareViewController alloc] init];
    goodsDetail.goodsdict = goodsDict;
    [self.navigationController pushViewController:goodsDetail animated:YES];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:@"您确认要结束分销？" message:@"结束分销后押金将在3个工作日内退还到您的原支付账户" preferredStyle:UIAlertControllerStyleAlert];
        WS(weakSelf)
        UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"结束分销" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSDictionary * goodsDict = weakSelf.goodsArray[indexPath.row];
            [weakSelf requestDelete:[goodsDict objectForKey:@"sn"] sucess:^{
                // 1.删除数据
                [weakSelf.goodsArray removeObject:goodsDict];
                // 2.更新UITableView UI界面
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                if (weakSelf.goodsArray.count == 0) {
                    self.nodataView.hidden = NO;
                }else{
                    self.nodataView.hidden = YES;
                }
            }];
        }];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"继续分销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVc addAction:cancle];
        [alertVc addAction:sure];
        [self presentViewController:alertVc animated:YES completion:nil];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationUpdateDistributionList object:nil];
}

@end
