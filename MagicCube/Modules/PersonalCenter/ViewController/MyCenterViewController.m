
//
//  MyCenterViewController.m
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "MyCenterViewController.h"
#import "UserHeadView.h"
#import "SalerTableViewCell.h"
#import "PrerogativTableViewCell.h"
#import "PrerogativView.h"
#import "TableTitleHeadView.h"
#import "InviteView.h"

@interface MyCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UserHeadView * headView;
@property (assign,nonatomic) BOOL isMemberShip;
@property (strong,nonatomic) UITableView * tableView;
@end

@implementation MyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)addSubView{
    self.headView = [[UserHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(288))];
    WS(weakSelf);
    self.headView.joinMember = ^{
        weakSelf.isMemberShip = !weakSelf.isMemberShip;
        [weakSelf.tableView reloadData];
    };
    [self.headView configWithDict:@{}];
//    [self.view addSubview:self.headView];
    
    UITableView * tabelview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT - 49) style:UITableViewStylePlain];
    tabelview.delegate = self;
    tabelview.dataSource = self;
    tabelview.tableHeaderView = self.headView;
    tabelview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabelview.tableFooterView = [UIView new];
    tabelview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabelview];
    self.tableView = tabelview;
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, TAB_BAR_HEIGHT, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isMemberShip) {
        return 5;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isMemberShip) {
        if (indexPath.section == 0) {
            SalerTableViewCell *teamcell = [tableView dequeueReusableCellWithIdentifier:@"team"];
            if (!teamcell) {
                teamcell = [[SalerTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"team"];
            }
            [teamcell configDict:@{}];
            return teamcell;
        }else{
            PrerogativTableViewCell *prerogativcell = [tableView dequeueReusableCellWithIdentifier:@"prerogativ"];
            if (!prerogativcell) {
                prerogativcell = [[PrerogativTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"prerogativ"];
            }
            [prerogativcell configDict:@{}];
            return prerogativcell;
        }
    }else{
        if (indexPath.section == 0) {
            UITableViewCell *joincell = [tableView dequeueReusableCellWithIdentifier:@"join"];
            if (!joincell) {
                joincell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"join"];
            }
            PrerogativView * perview = [[PrerogativView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 207)];
            [perview configwithDict:@{}];
            [joincell addSubview:perview];
            return joincell;
        }else{
            UITableViewCell *invitecell = [tableView dequeueReusableCellWithIdentifier:@"invite"];
            if (!invitecell) {
                invitecell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"invite"];
            }
            InviteView * invite = [[InviteView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 162)];
            [invitecell addSubview:invite];
            return invitecell;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isMemberShip) {
        if (indexPath.section == 0) {
            return [SalerTableViewCell cellHeight];
        }else{
            return [PrerogativTableViewCell cellHeight];
        }
    }else{
        if (indexPath.section == 0) {
            return 207;
        }else{
            return 162;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_isMemberShip){
        if (section == 0) {
            return 88;
        }else{
            return 44;
        }
    }else{
        return 44;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_isMemberShip){
        if (section == 0) {
            UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44 + 42)];
            headView.backgroundColor = [UIColor whiteColor];
            
            TableTitleHeadView * headtile = [[TableTitleHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            [headtile setUpTitle:@"我的团队"];
            [headView addSubview:headtile];
            
            CGFloat width = (SCREEN_WIDTH - 20) / 3.0;
            NSArray * titles = @[@"名称",@"今日业绩",@"总业绩"];
            int index = 0;
            for (NSString * title in titles) {
                MagicLabel * label = [[MagicLabel alloc] initWithFrame:CGRectMake(10 + index * width, 44, width, 43)];
                [headView addSubview:label];
                label.text = title;
                if (index != 0) {
                    label.textAlignment = NSTextAlignmentRight;
                }
                index ++;
            }
            MagicLineView *lineView2 = [[MagicLineView alloc] initWithFrame:CGRectMake(10, 44 + 43.5, SCREEN_WIDTH - 20, 0.5)];
            [headView addSubview:lineView2];
            return headView;
        }else{
            
            TableTitleHeadView * headview = [[TableTitleHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            [headview setUpTitle:@"会员特权"];
            return headview;
        }
    }else{
        if (section == 0) {
            TableTitleHeadView * headview = [[TableTitleHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            [headview setUpTitle:@"魔方会员专属特权"];
            return headview;
        }else{
            TableTitleHeadView * headview = [[TableTitleHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            [headview setUpTitle:@"我的团队"];
            return headview;
        }
    }
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 0) {
//        return 10;
//    }else{
//        return 0.01;
//    }
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section == 0) {
//        UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
//        footView.backgroundColor = KBGColor;
//        return footView;
//    }else{
//        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
//    }
//}
@end
