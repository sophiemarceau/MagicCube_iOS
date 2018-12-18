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

@interface DistributeDetailViewController (){
    NSDictionary *returnDataDic;
}
@property (strong,nonatomic) AVPlayer * player;
@property (strong,nonatomic) UIImageView * picImageView;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *subLabel;
@property (strong,nonatomic) UILabel *desLabel;
@property (strong,nonatomic) UILabel *numLabel;
@property (strong,nonatomic) UIView *redBgView;
@property (strong,nonatomic) UILabel *redBgLabel;
@end

@implementation DistributeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initdata];
    
    [self requestData];
}

-(void)initdata{
    self.title = @"商品卡详情";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)requestData{
    
//    NSMutableDictionary *pramaDic = @{}.mutableCopy;
//    [pramaDic setObject:self.snStr forKey:@"sn"];
    NSString *url = [NSString stringWithFormat:@"%@/%@",kAppApiGoodsDetail,self.snStr];
    NMShowLoadIng;
    //    [pramaDic setObject:self.tagid forKey:@"pageSize"];
    [BTERequestTools requestWithURLString:url parameters:nil type:HttpRequestTypeGet success:^(id responseObject) {
   
        NMRemovLoadIng;
        NSLog(@"---kAppApiGoodsDetail--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            self->returnDataDic = [responseObject objectForKey:@"data"];
            [self addSubviews];
            
        }
    } failure:^(NSError *error)  {
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
}

- (void)addSubviews{
    UIScrollView * rootView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_HEIGHT - HOME_INDICATOR_HEIGHT - SCALE_W(45))];
    [self.view addSubview:rootView];
    
    UIView *head= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(173.5))];
    head.backgroundColor = KBGCell;
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCALE_W(14.5), SCREEN_WIDTH, SCALE_W(139))];
    [imageView setImage:[UIImage imageNamed:@"homeCellBgIcon"]];
    
    [imageView addSubview:self.picImageView];
    [imageView addSubview:self.titleLabel];
    [imageView addSubview:self.subLabel];
    [imageView addSubview:self.desLabel];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(172.5, 109.65, 162.5, 0.5)];
    lineView.backgroundColor = GrayMagicColor;
    [imageView addSubview:lineView];
    [imageView addSubview:self.numLabel];
    [imageView addSubview:self.redBgView];
    [head addSubview:imageView];
    
    
    self.titleLabel.text = [returnDataDic objectForKey:@"name"];
//    //    @"燕之屋 尼罗河蓝\n孕妇正品燕盏卡";
    self.subLabel.text = [returnDataDic objectForKey:@"subTitle"];
//    //    @"干燕窝原料印尼进口 CAIQ溯源";
//
    self.redBgLabel.text = [NSString stringWithFormat:@"%@元", [returnDataDic objectForKey:@"price"]];
//    //    @"低至6折";

    NSDictionary * attubtrDict = @{NSFontAttributeName:UIFontMediumOfSize(8.5),NSForegroundColorAttributeName:RedMagicColor};
    NSString *deliveryPrice =@"6666位会员分销了这张卡,已售出9986件";
    NSString *price1 = @"6666";
    NSString *price2 = @"9986";
    NSArray *attrArray = @[price1,price2];
    NSAttributedString * attributestring = [MagicRichTool initWithString:deliveryPrice dict:attubtrDict subStringArray:attrArray];

    self.numLabel.attributedText = attributestring;
    
    
    
    UIView *linehead = [[UIView alloc] initWithFrame:CGRectMake(0, head.height -2, SCREEN_WIDTH, 0.5)];
    linehead.backgroundColor = BHHexColor(@"D9D9D9");
    [head addSubview:linehead];
    [rootView addSubview:head];
    
    UIView * distributePriceBGview = [[UIView alloc] initWithFrame:CGRectMake(0, SCALE_W(173.5), SCREEN_WIDTH, SCALE_W(195.5))];
    [rootView addSubview:distributePriceBGview];
    
    MagicLabel * distributeTitlelabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10, SCALE_W(16), SCREEN_WIDTH - 20, SCALE_W(14))];
    distributeTitlelabel.text = @"分销提货价";
    distributeTitlelabel.textColor = Gray666Color;
    [distributePriceBGview addSubview:distributeTitlelabel];
    
    CGFloat top = SCALE_W(35);
    CGFloat levelheight = SCALE_W((185.5 - 40))/4.0;

    NSArray *memberArray = [returnDataDic objectForKey:@"memberRuleRes"];
    if(memberArray && memberArray.count >0){
        for (int i = 0; i < memberArray.count; i++) {
            DistributeLevelView *levelView = [[DistributeLevelView alloc] initWithFrame:CGRectMake(0, top+levelheight * i, SCREEN_WIDTH, levelheight)];
            NSDictionary *tmpDic = [memberArray objectAtIndex:i];
            NSString *nameStr = [tmpDic objectForKey:@"name"];
            NSString *levelStr = [NSString stringWithFormat:@"%@",[tmpDic objectForKey:@"level"]];
            NSString *discountStr = [NSString stringWithFormat:@"%@",[tmpDic objectForKey:@"discount"]];
             CGFloat priceStr = [[tmpDic objectForKey:@"price"] floatValue];
            if ([levelStr isEqualToString:@"1"] ) {
                 [levelView configTextRed:NO level:nameStr price:priceStr discount:discountStr grade:YES gradeText:[NSString stringWithFormat:@"升级%@",nameStr] line:LinePositionShowDown];
            }
            if ([levelStr isEqualToString:@"2"]) {
                [levelView configTextRed:YES level:nameStr price:priceStr discount:discountStr grade:YES gradeText:[NSString stringWithFormat:@"升级%@",nameStr] line:LinePositionShowUpDown];
            }
            if ([levelStr isEqualToString:@"3"]) {
                [levelView configTextRed:NO level:nameStr price:priceStr discount:discountStr grade:NO gradeText:[NSString stringWithFormat:@"升级%@",nameStr] line:LinePositionShowUpDown];
            }
            if ([levelStr isEqualToString:@"4"]) {
                 [levelView configTextRed:NO level:nameStr price:priceStr discount:discountStr grade:NO gradeText:[NSString stringWithFormat:@"升级%@",nameStr] line:LinePositionShowUp];
            }
            [distributePriceBGview addSubview:levelView];
        }
    }
    
    MagicLineView * line = [[MagicLineView alloc] initWithFrame:CGRectMake(0, SCALE_W(185.5), SCREEN_WIDTH, SCALE_W(10))];
    [distributePriceBGview addSubview:line];
    
    UIView * introduceBGView = [[UIView alloc] initWithFrame:CGRectMake(0, SCALE_W(369), SCREEN_WIDTH, SCALE_W(266.5))];
    [rootView addSubview:introduceBGView];
    
    MagicLabel * introduceLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, SCALE_W(46))];
    introduceLabel.text = @"产品介绍";
    introduceLabel.textColor = Gray666Color;
    [introduceBGView addSubview:introduceLabel];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"localvideo" ofType:@"mp4"];
    NSURL * url = [NSURL URLWithString:[returnDataDic objectForKey:@"video"]];

    AVPlayer *player = [AVPlayer playerWithURL:url];

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
    
    UIImageView * goodsInfoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCALE_W(56), SCREEN_WIDTH, SCALE_W(182.5 - 76))];
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
    
    MagicLineView * line4 = [[MagicLineView alloc] initWithFrame:CGRectMake(0, SCALE_W(45.5), SCREEN_WIDTH, 0.5)];
    [goodsInfoBGView addSubview:line4];
    
    MagicLineView * line3 = [[MagicLineView alloc] initWithFrame:CGRectMake(0, SCALE_W(172.5), SCREEN_WIDTH, SCALE_W(10))];
    [goodsInfoBGView addSubview:line3];
    
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


-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(172.5, 13,SCALE_W(110 +72.5), 40)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = Black1Color;
        _titleLabel.font = UIFontMediumOfSize(14);
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

-(UILabel *)subLabel{
    if (_subLabel == nil) {
        _subLabel = [[UILabel alloc] initWithFrame:CGRectMake(172.5, self.titleLabel.bottom + 1.9, SCALE_W(110 +72.5), 14)];
        _subLabel.textColor = Gray858Color;
        _subLabel.font = UIFontRegularOfSize(12);
        _subLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _subLabel;
}

-(UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel= [[UILabel alloc] initWithFrame:CGRectMake(172.5, 84, 60, 12)];
        _desLabel.textAlignment= NSTextAlignmentLeft;
        _desLabel.textColor = RedMagicColor;
        _desLabel.font = UIFontLightOfSize(12);
        _desLabel.text = @"会员分销价";
    }
    return _desLabel;
}

-(UILabel *)numLabel{
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(172.5, 117.5, SCALE_W(110 + 72.5),8.5)];
        _numLabel.backgroundColor = [UIColor clearColor];
        _numLabel.textColor = BlackMagicColor;
        _numLabel.font = UIFontRegularOfSize(8.5);
        _numLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _numLabel;
}

-(UILabel *)redBgLabel{
    if (_redBgLabel == nil) {
        _redBgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , self.redBgView.width, self.redBgView.height)];
        _redBgLabel.backgroundColor = [UIColor clearColor];
        _redBgLabel.textColor = [UIColor whiteColor];
        _redBgLabel.textAlignment = NSTextAlignmentCenter;
        _redBgLabel.font = UIFontRegularOfSize(14);
    }
    return _redBgLabel;
}

-(UIView *)redBgView{
    if (_redBgView == nil) {
        _redBgView = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - 90 - 20, 78 , SCALE_W(90), SCALE_W(23))];
        _redBgView.backgroundColor = RedMagicColor;
        _redBgView.layer.masksToBounds = YES;
        _redBgView.layer.cornerRadius = 11.5;
        [_redBgView addSubview:self.redBgLabel];
    }
    return _redBgView;
}
@end
