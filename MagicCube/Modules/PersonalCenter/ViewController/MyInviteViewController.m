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
@end

@implementation MyInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initdata];
    [self addSubViews];
    // Do any additional setup after loading the view.
}

- (void)initdata{
    self.title = @"我的邀请";
    self.inviteArray = [NSMutableArray arrayWithCapacity:0];
}

-(void)addSubViews{
    UIImageView * bgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCALE_W(30), SCALE_W(35), SCREEN_WIDTH - SCALE_W(30) * 2, SCREEN_HEIGHT - NAVIGATION_HEIGHT - HOME_INDICATOR_HEIGHT - SCALE_W(35) - SCALE_W(152))];
    bgView.image = [UIImage imageNamed:@"groupInvite"];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    
    MagicLabel * titleLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(0, SCALE_W(35), bgView.width, 14)];
    titleLabel.textColor  = Black626A75Color;
    [bgView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.attributedText = [MagicRichTool initWithString:@"您已成功邀请 2 位好友" substring:@"2" font:UIFontRegularOfSize(20) color:[UIColor colorWithHexString:@"308cdd"]];
    
    
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
    
    
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCALE_W(110 + 34), bgView.width, bgView.height - SCALE_W(110) - SCALE_W(20)) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    tableView.rowHeight = [InviteTableViewCell cellHeight];
    [bgView addSubview:tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;//self.inviteArray.count;
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
