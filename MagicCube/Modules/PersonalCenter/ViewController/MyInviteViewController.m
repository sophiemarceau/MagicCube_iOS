//
//  MyInviteViewController.m
//  MagicCube
//
//  Created by wanmeizty on 21/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "MyInviteViewController.h"
#import "InviteTableViewCell.h"

@interface MyInviteViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSMutableArray * inviteArray;
@property (strong,nonatomic) UITableView * tableView;
@property (assign,nonatomic) NSInteger pageNum;
@property (strong,nonatomic) MagicLabel * titleLabel;
@end

@implementation MyInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initdata];
    [self addSubViews];
    // Do any additional setup after loading the view.
}

- (void)requestInvites:(NSInteger)pageNum{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    self.titleLabel.attributedText = [MagicRichTool initWithString:@"您已成功邀请 0 位好友" substring:@"0" font:UIFontRegularOfSize(20) color:[UIColor colorWithHexString:@"308cdd"]];

//    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
//    WS(weakSelf)
//    NSLog(@"-----requestRecords--->%@",params);
//    NMShowLoadIng;
//    [BTERequestTools requestWithURLString:kAppApiDistribution parameters:params type:HttpRequestTypeGet success:^(id responseObject) {
//        [weakSelf.tableView.mj_header endRefreshing];
//        [weakSelf.tableView.mj_footer endRefreshing];
//        NMRemovLoadIng;
//        NSLog(@"---requestRecords--responseObject--->%@",responseObject);
//        if (IsSucess(responseObject)) {
//            NSDictionary * dataDict = [responseObject objectForKey:@"data"];
//            if (dataDict) {
//                if ([[dataDict objectForKey:@"pageNum"] integerValue] == pageNum) {
//
//                    [weakSelf.tableView reloadData];
//                }
//
//                if (pageNum == [[dataDict objectForKey:@"lastPage"] integerValue]) {
//                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
//                }
//            }
//        }else{
//
//            NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
//            [BHToast showMessage:message];
//        }
//    } failure:^(NSError *error)  {
//        [weakSelf.tableView.mj_header endRefreshing];
//        [weakSelf.tableView.mj_footer endRefreshing];
//        NMRemovLoadIng;
//        NSLog(@"error-------->%@",error);
//    }];
}

- (void)initdata{
    self.title = @"我的邀请";
    self.inviteArray = [NSMutableArray arrayWithCapacity:0];
}

-(void)addSubViews{
    UIImageView * bgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCALE_W(30), SCALE_W(35), SCREEN_WIDTH - SCALE_W(30) * 2, SCREEN_HEIGHT - NAVIGATION_HEIGHT - HOME_INDICATOR_HEIGHT - SCALE_W(35) - SCALE_W(132))];
    bgView.image = [UIImage imageNamed:@"groupInvite"];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    
    MagicLabel * titleLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(0, SCALE_W(35), bgView.width, 14)];
    titleLabel.textColor  = Black626A75Color;
    [bgView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.attributedText = [MagicRichTool initWithString:@"您已成功邀请 0 位好友" substring:@"0" font:UIFontRegularOfSize(20) color:[UIColor colorWithHexString:@"308cdd"]];
    self.titleLabel = titleLabel;
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, SCALE_W(110), bgView.width, SCALE_W(34))];
    [bgView addSubview:headView];
    
    MagicLabel * leftLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(0, 0, bgView.width * 0.5, SCALE_W(34))];
    leftLabel.text = @"用户";
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.textColor = Black626A75Color;
    [headView addSubview:leftLabel];
    
    MagicLabel * rightLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(bgView.width * 0.5, 0, bgView.width * 0.5, SCALE_W(34))];
    rightLabel.text = @"注册时间";
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.textColor = Black626A75Color;
    [headView addSubview:rightLabel];
    
    
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCALE_W(110 + 34), bgView.width, bgView.height - SCALE_W(110) - SCALE_W(20) - SCALE_W(34)) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    tableView.rowHeight = [InviteTableViewCell cellHeight];
    self.tableView = tableView;
    [bgView addSubview:tableView];
    
    WS(weakSelf);
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNum = 1;
        [weakSelf.inviteArray removeAllObjects];
        [weakSelf requestInvites:weakSelf.pageNum];
    }];
    tableView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNum ++;
        [weakSelf requestInvites:weakSelf.pageNum];
    }];
    tableView.mj_footer = footer;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.inviteArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InviteTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"invite"];
    if (!cell) {
        cell = [[InviteTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"invite"];
    }
    [cell configDict:@{}];
    return cell;
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
