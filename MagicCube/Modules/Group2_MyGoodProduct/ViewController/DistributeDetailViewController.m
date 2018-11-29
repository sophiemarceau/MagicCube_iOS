//
//  DistributeDetailViewController.m
//  MagicCube
//
//  Created by wanmeizty on 28/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "DistributeDetailViewController.h"
#import "DistributeLevelView.h"
#import <AVFoundation/AVFoundation.h>
#import "DistributeGoodsViewController.h"

@interface DistributeDetailViewController ()
@property (strong,nonatomic) AVPlayer * player;
@end

@implementation DistributeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initdata];
    [self createfakeData];
    [self addSubviews];
    // Do any additional setup after loading the view.
}

-(void)initdata{
    self.title = @"商品卡详情";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)createfakeData{
}

- (void)addSubviews{
    
    UIScrollView * rootView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_HEIGHT - HOME_INDICATOR_HEIGHT - SCALE_W(45))];
    [self.view addSubview:rootView];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(173.5))];
    [imageView setImage:[UIImage imageNamed:@"分销中心_详情"]];
    [rootView addSubview:imageView];
    
    UIView * distributePriceBGview = [[UIView alloc] initWithFrame:CGRectMake(0, SCALE_W(173.5), SCREEN_WIDTH, SCALE_W(195.5))];
    [rootView addSubview:distributePriceBGview];
    
    MagicLabel * distributeTitlelabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10, SCALE_W(16), SCREEN_WIDTH - 20, SCALE_W(14))];
    distributeTitlelabel.text = @"分销提货价";
    distributeTitlelabel.textColor = Gray666Color;
    [distributePriceBGview addSubview:distributeTitlelabel];
    
    CGFloat top = SCALE_W(35);
    CGFloat levelheight = SCALE_W((185.5 - 40))/4.0;
    DistributeLevelView * levelView = [[DistributeLevelView alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, levelheight)];
    [levelView configTextRed:NO level:@"普通会员" price:1088 discount:@"9" grade:YES gradeText:@"升级黄金会员" line:LinePositionShowDown];
    [distributePriceBGview addSubview:levelView];
    
    DistributeLevelView * levelView2 = [[DistributeLevelView alloc] initWithFrame:CGRectMake(0, SCALE_W(top + levelheight * 1), SCREEN_WIDTH, levelheight)];
    [levelView2 configTextRed:YES level:@"黄金会员" price:888 discount:@"8.5" grade:YES gradeText:@"升级白金会员" line:LinePositionShowUpDown];
    [distributePriceBGview addSubview:levelView2];
    
    DistributeLevelView * levelView3 = [[DistributeLevelView alloc] initWithFrame:CGRectMake(0, SCALE_W(top + levelheight * 2), SCREEN_WIDTH, levelheight)];
    [levelView3 configTextRed:NO level:@"白金会员" price:688 discount:@"7" grade:NO gradeText:@"升级白金会员" line:LinePositionShowUpDown];
    [distributePriceBGview addSubview:levelView3];
    
    DistributeLevelView * levelView4 = [[DistributeLevelView alloc] initWithFrame:CGRectMake(0, SCALE_W(top + levelheight * 3), SCREEN_WIDTH, levelheight)];
    [levelView4 configTextRed:NO level:@"砖石会员" price:488 discount:@"5" grade:NO gradeText:@"升级砖石会员" line:LinePositionShowUp];
    [distributePriceBGview addSubview:levelView4];
    
    MagicLineView * line = [[MagicLineView alloc] initWithFrame:CGRectMake(0, SCALE_W(185.5), SCREEN_WIDTH, SCALE_W(10))];
    [distributePriceBGview addSubview:line];
    
    UIView * introduceBGView = [[UIView alloc] initWithFrame:CGRectMake(0, SCALE_W(369), SCREEN_WIDTH, SCALE_W(266.5))];
    [rootView addSubview:introduceBGView];
    
    MagicLabel * introduceLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, SCALE_W(46))];
    introduceLabel.text = @"产品介绍";
    introduceLabel.textColor = Gray666Color;
    [introduceBGView addSubview:introduceLabel];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"localvideo" ofType:@"mp4"];
    NSURL * url = [NSURL fileURLWithPath:path];

    AVPlayer * player = [AVPlayer playerWithURL:url];

    AVPlayerLayer * playlayer = [AVPlayerLayer playerLayerWithPlayer:player];

    playlayer.frame = CGRectMake(0, SCALE_W(46), SCREEN_WIDTH, SCALE_W(210.5));
    
    [introduceBGView.layer addSublayer:playlayer];
    self.player = player;
//    [player play];
    UIButton * playBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - SCALE_W(62)) * 0.5, SCALE_W(210.5 - 62) * 0.5 + SCALE_W(46), SCALE_W(62), SCALE_W(62))];
    [playBtn setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
    playBtn.selected = NO;
    [playBtn addTarget:self action:@selector(clickPlay:) forControlEvents:UIControlEventTouchUpInside];
    [introduceBGView addSubview:playBtn];
    MagicLineView * line2 = [[MagicLineView alloc] initWithFrame:CGRectMake(0, SCALE_W(256.5), SCREEN_WIDTH, SCALE_W(10))];
    [introduceBGView addSubview:line2];
    
    UIView * goodsInfoBGView = [[UIView alloc] initWithFrame:CGRectMake(0, SCALE_W(635.5), SCREEN_WIDTH, SCALE_W(182.5))];
    [rootView addSubview:goodsInfoBGView];
    
    UIImageView * goodsInfoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCALE_W(46), SCREEN_WIDTH, SCALE_W(182.5 - 46))];
    goodsInfoView.image = [UIImage imageNamed:@"fangweituan"];
    goodsInfoView.contentMode = UIViewContentModeScaleAspectFit;
    [goodsInfoBGView addSubview:goodsInfoView];
    
    
    
    MagicLabel * infoLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, SCALE_W(46))];
    infoLabel.text = @"商品信息";
    infoLabel.textColor = Gray666Color;
    [goodsInfoBGView addSubview:infoLabel];
    
    NSArray * titles = @[@"本卡产品认证生产商为厦门燕之屋生物工程发展有限公司",@"本卡产品认证发货商为厦门燕之屋生物工程发展有限公司",@"本卡信息已在蚂蚁金服区块链存证备查"];
    NSArray * imgs = @[@"changshang",@"huoyuan",@"fangwei"];
    int index = 0;
    for (NSString * title in titles) {
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCALE_W(22), SCALE_W(11) + SCALE_W(42) + SCALE_W(45.5) * index, SCALE_W(21), SCALE_W(21))];
        imgView.image = [UIImage imageNamed:imgs[index]];
        [goodsInfoBGView addSubview:imgView];
        
        MagicLabel * label = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(50), SCALE_W(16.5) + SCALE_W(42)+ SCALE_W(45.5) * index, SCREEN_WIDTH - 10 - SCALE_W(50), 12)];
        label.textColor = [UIColor colorWithHexString:@"7F7569"];
        label.text = title;
        label.font = UIFontRegularOfSize(SCALE_W(12));
        [goodsInfoBGView addSubview:label];
        
        if (index < 2) {
            MagicLabel *descLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(15), SCALE_W(38)  + SCALE_W(42) + SCALE_W(45.5) * index, SCREEN_WIDTH - SCALE_W(30), 9)];
            descLabel.font  = UIFontRegularOfSize(SCALE_W(9));
            descLabel.text = @"由厦门燕之屋生物工程发展有限公司数字签名确认";
            descLabel.textColor = [UIColor colorWithHexString:@"948B7F" alpha:0.6];
            [goodsInfoBGView addSubview:descLabel];
        }else{
            UIButton * lookbtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - SCALE_W(112), SCALE_W(12.5) + SCALE_W(42)+ SCALE_W(45.5) * index, SCALE_W(80), 16)];
            lookbtn.layer.cornerRadius = 2;
            lookbtn.titleLabel.font = UIFontRegularOfSize(10);
            lookbtn.layer.borderColor = Gray666Color.CGColor;
            lookbtn.layer.borderWidth = 0.5;
            lookbtn.layer.masksToBounds = YES;
            [lookbtn setTitleColor:Gray666Color forState:UIControlStateNormal];
            [lookbtn setTitle:@"查看数字签名" forState:UIControlStateNormal];
            [goodsInfoBGView addSubview:lookbtn];
            
        }
        index++;
    }
    
    MagicLineView * line3 = [[MagicLineView alloc] initWithFrame:CGRectMake(0, SCALE_W(172.5), SCREEN_WIDTH, SCALE_W(10))];
    [goodsInfoBGView addSubview:line3];
    rootView.contentSize = CGSizeMake(0, SCREEN_HEIGHT * 2);
    
    UIButton * distributeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SCALE_W(45) - HOME_INDICATOR_HEIGHT - NAVIGATION_HEIGHT, SCREEN_WIDTH, SCALE_W(45))];
    distributeBtn.backgroundColor = RedMagicColor;
    [self.view addSubview:distributeBtn];
    
    
    MagicLabel * distributeLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(0, SCALE_W(8), SCREEN_WIDTH, SCALE_W(16))];
    distributeLabel.userInteractionEnabled = NO;
    distributeLabel.textAlignment = NSTextAlignmentCenter;
    distributeLabel.text = @"我要分销";
    distributeLabel.font  =UIFontRegularOfSize(16);
    distributeLabel.textColor = BHColorWhite;
    [distributeBtn addSubview:distributeLabel];
    
    MagicLabel * distributeDescLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(0, SCALE_W(29), SCREEN_WIDTH, SCALE_W(10))];
    distributeDescLabel.userInteractionEnabled = NO;
    distributeDescLabel.textAlignment = NSTextAlignmentCenter;
    distributeDescLabel.text = @"无需付款进货，卖出立得分成";
    distributeDescLabel.textColor = BHColorWhite;
    distributeDescLabel.font  =UIFontRegularOfSize(10);
    [distributeBtn addSubview:distributeDescLabel];
    [distributeBtn addTarget:self action:@selector(distriute:) forControlEvents:UIControlEventTouchUpInside];
    rootView.contentSize = CGSizeMake(0, SCALE_W(818));
}



#pragma mark -- btn
-(void)clickPlay:(UIButton *)btn{
    if (btn.selected) {
        [self.player pause];
        
    }else{
        [self.player play];
    }
    btn.selected = !btn.selected;
}

-(void)distriute:(UIButton *)btn{
    DistributeGoodsViewController * distributeVC = [[DistributeGoodsViewController alloc] init];
    [self.navigationController pushViewController:distributeVC animated:YES];
}


@end
