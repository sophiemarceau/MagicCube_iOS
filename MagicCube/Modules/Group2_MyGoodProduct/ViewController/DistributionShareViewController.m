//
//  DistributionShareViewController.m
//  MagicCube
//
//  Created by wanmeizty on 29/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "DistributionShareViewController.h"
#import "UIButton+ImageTitleAlign.h"
#import "SendPreviewViewController.h"
#import "SalerTableViewCell.h"
#import "MagicCardView.h"
#import "MagicNODataView.h"

@interface DistributionShareViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UIButton * distributeShareBtn;
@property (strong,nonatomic) UIButton * distributeRecordBtn;
@property (strong,nonatomic) NSMutableArray * recordsArray;
@property (strong,nonatomic) UITableView * recordsTableView;
@property (strong,nonatomic) UIScrollView * bottomScrollview;
@property (strong,nonatomic) MagicCardView * cardView;
@property (assign,nonatomic) NSInteger pageNum;
@property (strong,nonatomic) MagicNODataView * nodataView;
@end

@implementation DistributionShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initdata];
    [self addSubViews];
    [self requestInfo];
    [self requestRecords:1];
    // Do any additional setup after loading the view.
}

#pragma mark -- 数据
- (void)requestInfo{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString * sn = [self.goodsdict objectForKey:@"sn"];
    
    [params setObject:sn forKey:@"sn"];
    WS(weakSelf)
    NSLog(@"-----kAppApiDistribution--->%@",params);
    NMShowLoadIng;
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kAppApiDistribution,sn];
    [BTERequestTools requestWithURLString:urlStr parameters:params type:HttpRequestTypeGet success:^(id responseObject) {
        
        NMRemovLoadIng;
        NSLog(@"---kAppApiDistribution--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            
            if ([responseObject objectForKey:@"data"]) {
                [weakSelf.cardView setUpDistributeDict:[responseObject objectForKey:@"data"]];
            }
            
        }else{
            NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
            [BHToast showMessage:message];
        }
    } failure:^(NSError *error)  {
       
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
}

- (void)requestRecords:(NSInteger)pageNum{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"10" forKey:@"pageSize"];
    [params setObject:[NSString stringWithFormat:@"%ld",pageNum] forKey:@"pageNum"];
    WS(weakSelf)
    NSLog(@"-----requestRecords--->%@",params);
    NMShowLoadIng;
    NSString * goodsSn = [self.goodsdict objectForKey:@"sn"];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@/records",kAppApiDistribution,goodsSn];
    [BTERequestTools requestWithURLString:urlStr parameters:params type:HttpRequestTypeGet success:^(id responseObject) {
        [weakSelf.recordsTableView.mj_header endRefreshing];
        [weakSelf.recordsTableView.mj_footer endRefreshing];
        NMRemovLoadIng;
        NSLog(@"---requestRecords--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            NSDictionary * dataDict = [responseObject objectForKey:@"data"];
            if(dataDict){
                if ([[dataDict objectForKey:@"pageNum"] integerValue] == pageNum) {
                    NSString * recordBtnTitle = [NSString stringWithFormat:@"分销记录 (%ld条)",[[dataDict objectForKey:@"total"] integerValue]];
                    [weakSelf.distributeRecordBtn setTitle:recordBtnTitle forState:UIControlStateNormal];
                    
                    NSArray *list = [dataDict objectForKey:@"list"];
                    [weakSelf.recordsArray addObjectsFromArray:list];
                    [weakSelf.recordsTableView reloadData];
                    
                }
                
                if (pageNum == [[dataDict objectForKey:@"lastPage"] integerValue]) {
                    [self.recordsTableView.mj_footer endRefreshingWithNoMoreData];
                }
                
                if (self.recordsArray.count == 0) {
                    self.nodataView.hidden = NO;
                }else{
                    self.nodataView.hidden = YES;
                }
            }else{
                
                NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
                [BHToast showMessage:message];
            }
            }
    } failure:^(NSError *error)  {
        [weakSelf.recordsTableView.mj_header endRefreshing];
        [weakSelf.recordsTableView.mj_footer endRefreshing];
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
}

- (void)initdata{
    self.title = @"分销中心";
    self.recordsArray = [NSMutableArray arrayWithCapacity:0];
    self.pageNum = 1;
}

#pragma mark -- 视图
- (void)addSubViews{
    
    UIScrollView * rootView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_HEIGHT - HOME_INDICATOR_HEIGHT)];
    rootView.backgroundColor = BHColorWhite;
    [self.view addSubview:rootView];
    
    CGFloat top = 0;
   
    
    self.cardView = [[MagicCardView alloc] initWithFrame:CGRectMake(0, SCALE_W(14), SCREEN_WIDTH, SCALE_W(152))];
    [self.cardView setUpDistributeDict:self.goodsdict];
    [rootView addSubview:self.cardView];
    
    top += SCALE_W(168);
    
    UIView * selectBgView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - SCALE_W(266)) * 0.5, SCALE_W(15) + top, SCALE_W(266), SCALE_W(30))];
    selectBgView.layer.cornerRadius = 4;
    selectBgView.layer.masksToBounds = YES;
    selectBgView.layer.borderColor = RedMagicColor.CGColor;
    selectBgView.layer.borderWidth = 0.5;
    [rootView addSubview:selectBgView];
    top += SCALE_W(30 + 20);
    
    NSArray * selectTitles = @[@"分销到",@"分销记录"];
    int index = 0;
    for (NSString * selectTitle in selectTitles) {
        UIButton * selectBtn = [self createSelectBtn:CGRectMake(index *SCALE_W(133), 0, SCALE_W(133), SCALE_W(30))];
        [selectBtn setTitle:selectTitle forState:UIControlStateNormal];
//        [selectBtn setTitle:selectTitle forState:UIControlStateSelected];
        [selectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [selectBgView addSubview:selectBtn];
        if (index == 0) {
            selectBtn.selected = YES;
            self.distributeShareBtn = selectBtn;
        }else{
            selectBtn.selected = NO;
            self.distributeRecordBtn = selectBtn;
        }
        index ++;
        
    }
    
    UIScrollView * selectBottomView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, SCREEN_HEIGHT - top - NAVIGATION_HEIGHT - HOME_INDICATOR_HEIGHT)];
    selectBottomView.backgroundColor = KBGColor;
    [rootView addSubview:selectBottomView];
    self.bottomScrollview = selectBottomView;
    
    UIView * shareBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(115))];
    shareBgView.backgroundColor = [UIColor whiteColor];
    [selectBottomView addSubview:shareBgView];
    
    NSArray * array = @[@"微信",@"朋友圈",@"微博",@"抖音",@"QQ",@"支付宝",@"今日头条"];
    NSArray * imgarray = @[@"weixin",@"pengyouquan",@"weibo",@"douyin",@"qq",@"zhifubao",@"jinritoutiao"];
    CGFloat intevalw = SCALE_W(10);
    CGFloat btnw = (SCREEN_WIDTH - 5 * intevalw) / 4.0;
    CGFloat btnh = SCALE_W(30);
    int i = 0;
    for (NSString * sharetitle in array) {
         UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(intevalw + (intevalw + btnw) * (i % 4), SCALE_W(10)+SCALE_W(15) + (SCALE_W(15) + btnh) * (i / 4), btnw, btnh)];
        btn.tag = i + 600;
        [btn setTitleColor:Gray666Color forState:UIControlStateNormal];
        [btn setTitle:sharetitle forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imgarray[i]] forState:UIControlStateNormal];
        btn.titleLabel.font = UIFontRegularOfSize(12);
        [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = GrayMagicColor.CGColor;
        btn.layer.borderWidth = 0.5;
        [btn centerAlignmentImgLeftTitleRight:YES space:5];
        [shareBgView addSubview:btn];

        if (i != 0) {
            btn.enabled = NO;
        }
        i ++;
    }
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 62, SCREEN_WIDTH, SCREEN_HEIGHT - top - NAVIGATION_HEIGHT - HOME_INDICATOR_HEIGHT - 62) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = [SalerTableViewCell cellHeight];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [UIView new];
    [selectBottomView addSubview:tableView];
    self.recordsTableView = tableView;
    
    
    
    WS(weakSelf);
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNum = 1;
        [weakSelf.recordsArray removeAllObjects];
        [weakSelf requestRecords:weakSelf.pageNum];
    }];
    tableView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNum ++;
        [weakSelf requestRecords:weakSelf.pageNum];
    }];
    tableView.mj_footer = footer;
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH,62)];
    headView.backgroundColor = [UIColor whiteColor];
   

    CGFloat width = (SCREEN_WIDTH - 20) / 3.0;
    NSArray * titles = @[@"客户名称",@"销售时间",@"销售价格"];
    index = 0;
    for (NSString * title in titles) {
        MagicLabel * label = [[MagicLabel alloc] initWithFrame:CGRectMake(10 + index * width, 20, width, 41.5)];
        label.textColor = Gray666Color;
        [headView addSubview:label];
        label.text = title;
        if (index != 0) {
            label.textAlignment = NSTextAlignmentRight;
        }
        index ++;
    }
    MagicLineView *lineView2 = [[MagicLineView alloc] initWithFrame:CGRectMake(0, 61.5, SCREEN_WIDTH, 0.5)];
    [headView addSubview:lineView2];
    [selectBottomView addSubview:headView];
    
    self.nodataView = [[MagicNODataView alloc] initWithFrame:tableView.frame];
    [self.nodataView setUpImageName:@"recordnodta" title:@"还没有分销记录，快去分销吧" addShow:NO];
    [selectBottomView addSubview:self.nodataView];
//    tableView.tableHeaderView = headView;
}

#pragma --mark tableview 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.recordsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SalerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"record"];
    if (!cell) {
        cell = [[SalerTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"record"];
    }
    NSDictionary * cellDict = self.recordsArray[indexPath.row];
    [cell configDict:cellDict];
    return cell;
}

#pragma --mark 按钮事件
-(void)selectClick:(UIButton *)btn{
    
    if (btn == self.distributeShareBtn) {
        self.distributeShareBtn.selected = YES;
        self.distributeRecordBtn.selected = NO;
        
        CGPoint contentOffset = self.bottomScrollview.contentOffset;
        contentOffset.x = 0 * SCREEN_WIDTH;
        [self.bottomScrollview setContentOffset:contentOffset animated:YES];
    }else{
        self.distributeShareBtn.selected = NO;
        self.distributeRecordBtn.selected = YES;
        
        CGPoint contentOffset = self.bottomScrollview.contentOffset;
        contentOffset.x = 1 * SCREEN_WIDTH;
        [self.bottomScrollview setContentOffset:contentOffset animated:YES];

        if (self.recordsArray.count == 0) {
            [self requestRecords:1];
        }
    }
}

- (void)shareClick:(UIButton *)btn{
    
    if (btn.tag == 600) {
        SendPreviewViewController * sendVC = [[SendPreviewViewController alloc] init];
        sendVC.dataDict = self.goodsdict;
        [self.navigationController pushViewController:sendVC animated:YES];
    }else{
        [BHToast showMessage:@"暂未开放"];
    }
}

-(UIButton *)createSelectBtn:(CGRect)frame{
    UIButton * btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitleColor:GrayMagicColor forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:BHColorWhite] forState:UIControlStateNormal];
    [btn setTitleColor:BHColorWhite forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageWithColor:RedMagicColor] forState:UIControlStateSelected];
    btn.titleLabel.font = UIFontRegularOfSize(14);
    return btn;
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
