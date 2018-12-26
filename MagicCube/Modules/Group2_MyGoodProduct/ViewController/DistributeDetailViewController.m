//
//  DistributeDetailViewController.m
//  MagicCube
//
//  Created by wanmeizty on 28/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "DistributeDetailViewController.h"
#import "DetailMemberView.h"
#import "GoodsInfoView.h"
#import <AVFoundation/AVFoundation.h>
#import "DistributeGoodsViewController.h"
#import "MagicCardView.h"
#import "AppDelegate.h"
#import "WXApi.h"

@interface DistributeDetailViewController ()<gradeUpDelegate>{
    NSDictionary *returnDataDic;
    float distributionDeposit;
}
@property (strong,nonatomic) AVPlayer * player;
@property (strong,nonatomic) AVPlayerLayer * playerLayer;
@property (strong,nonatomic) DetailMemberView * memberView;
@property (strong,nonatomic) GoodsInfoView * goodsInfoView;
@property (strong,nonatomic) MagicCardView * cardView;
@property (strong,nonatomic) MagicLabel * distributeDescLabel;


@end

@implementation DistributeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initdata];
    [self addSubviews];
    [self requestDetail];
}

#pragma mark -- 数据
- (void)requestDetail{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    WS(weakSelf)
    NSLog(@"-----kAppApiGoodsDetail--->%@",params);
    NMShowLoadIng;
    NSString * requestUrl = [NSString stringWithFormat:@"%@/%@",kAppApiGoodsDetail,self.snStr];
    [BTERequestTools requestWithURLString:requestUrl parameters:params type:HttpRequestTypeGet success:^(id responseObject) {
        
        NMRemovLoadIng;
        NSLog(@"---kAppApiGoodsDetail--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            [weakSelf performSelectorOnMainThread:@selector(dealDetailData:) withObject:responseObject waitUntilDone:YES];
        }else{
            NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
            [BHToast showMessage:message];
        }
    } failure:^(NSError *error)  {
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
}

- (void)dealDetailData:(NSDictionary *)dict{
    NSDictionary * dataDict = [dict objectForKey:@"data"];
    
    NSString * videoUrl = [dataDict objectForKey:@"video"];
    NSURL * url = [NSURL URLWithString:videoUrl];
    self.player = [AVPlayer playerWithURL:url];
    self.playerLayer.player = self.player;
    
    [self.goodsInfoView setUPdata:dataDict];
    
    [self.cardView setUpDistributeDetailDict:dataDict];
    
    NSInteger currentUserMemberLevel = [[dataDict objectForKey:@"currentUserMemberLevel"] integerValue];
    NSArray * memberRuleRes = [dataDict objectForKey:@"memberRuleRes"];
    [self.memberView setUpdata:memberRuleRes currentUserMemberLevel:currentUserMemberLevel];
     self.distributeDescLabel.text = [NSString stringWithFormat:@"%@", [dataDict objectForKey:@"distributionButtonText"]];
    distributionDeposit =  [[dataDict objectForKey:@"distributionDeposit"] floatValue];
}

- (void)requestCreateDistribution{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:self.snStr forKey:@"sn"];
    WS(weakSelf)
    NSLog(@"-----CreateDistribution--->%@",params);
    NMShowLoadIng;
    NSString * requestUrl = [NSString stringWithFormat:@"%@/%@/distribution",kAppApiGoodsDetail,self.snStr];
    [BTERequestTools requestWithURLString:requestUrl parameters:params type:HttpRequestTypePost success:^(id responseObject) {
        NMRemovLoadIng;
        NSLog(@"---CreateDistribution--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            [weakSelf.navigationController popToRootViewControllerAnimated:NO];
            AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            [appDelegate.mainVc setSelectedIndex:1];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUpdateDistributionList object:nil];
        }else{
            NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
            [BHToast showMessage:message];
        }
    } failure:^(NSError *error)  {
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
}

-(void)initdata{
    self.title = @"商品卡详情";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)addSubviews{
    UIScrollView * rootView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_HEIGHT - HOME_INDICATOR_HEIGHT - SCALE_W(45))];
    [self.view addSubview:rootView];
    
    UIView * cardBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(173.5))];
    [rootView addSubview:cardBGView];
    
    self.cardView = [[MagicCardView alloc] initWithFrame:CGRectMake(0, SCALE_W(14.5), SCREEN_WIDTH, SCALE_W(139))];
    [cardBGView addSubview:self.cardView];
    
    DetailMemberView * memberView = [[DetailMemberView alloc] initWithFrame:CGRectMake(0, SCALE_W(173.5), SCREEN_WIDTH, SCALE_W(195.5))];
    memberView.gradeDelegate = self;
    self.memberView = memberView;
    [rootView addSubview:memberView];
    
    MagicLineView * line = [[MagicLineView alloc] initWithFrame:CGRectMake(0, SCALE_W(185.5), SCREEN_WIDTH, SCALE_W(10))];
    [memberView addSubview:line];
    
    UIView * introduceBGView = [[UIView alloc] initWithFrame:CGRectMake(0, SCALE_W(369), SCREEN_WIDTH, SCALE_W(266.5))];
    [rootView addSubview:introduceBGView];
    
    MagicLabel * introduceLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, SCALE_W(46))];
    introduceLabel.text = @"产品介绍";
    introduceLabel.textColor = Gray666Color;
    [introduceBGView addSubview:introduceLabel];
    
    AVPlayerLayer * playlayer = [[AVPlayerLayer alloc] init];
    playlayer.frame = CGRectMake(0, SCALE_W(46), SCREEN_WIDTH, SCALE_W(210.5));
    self.playerLayer = playlayer;
    
    [introduceBGView.layer addSublayer:playlayer];
    UIButton * playBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - SCALE_W(62)) * 0.5, SCALE_W(210.5 - 62) * 0.5 + SCALE_W(46), SCALE_W(62), SCALE_W(62))];
    [playBtn setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
    playBtn.selected = NO;
    [playBtn addTarget:self action:@selector(clickPlay:) forControlEvents:UIControlEventTouchUpInside];
    [introduceBGView addSubview:playBtn];
    MagicLineView * line2 = [[MagicLineView alloc] initWithFrame:CGRectMake(0, SCALE_W(256.5), SCREEN_WIDTH, SCALE_W(10))];
    [introduceBGView addSubview:line2];
    
    GoodsInfoView * goodsInfoView = [[GoodsInfoView alloc] initWithFrame:CGRectMake(0, SCALE_W(635.5), SCREEN_WIDTH, SCALE_W(182.5))];
    [rootView addSubview:goodsInfoView];
    self.goodsInfoView = goodsInfoView;
    
    MagicLineView * line3 = [[MagicLineView alloc] initWithFrame:CGRectMake(0, SCALE_W(172.5), SCREEN_WIDTH, SCALE_W(10))];
    [goodsInfoView addSubview:line3];
    
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
    
    self.distributeDescLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(0, SCALE_W(29), SCREEN_WIDTH, SCALE_W(10))];
    self.distributeDescLabel.userInteractionEnabled = NO;
    self.distributeDescLabel.textAlignment = NSTextAlignmentCenter;
    self.distributeDescLabel.text = @"无需付款进货，卖出立得分成";
    self.distributeDescLabel.textColor = BHColorWhite;
    self.distributeDescLabel.font  =UIFontRegularOfSize(10);
    [distributeBtn addSubview:self.distributeDescLabel];
    [distributeBtn addTarget:self action:@selector(distriute:) forControlEvents:UIControlEventTouchUpInside];
    rootView.contentSize = CGSizeMake(0, SCALE_W(818));
}


-(void)gradeUpLevel:(NSInteger)level{
    NSLog(@"%ld",level);
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
    if(distributionDeposit != 0){
        [self payAttention];
    }else{
        [self requestCreateDistribution];
    }
   
}


-(void)payAttention{
    NSString *message;
    NSString *messageString = [NSString stringWithFormat:@"代理本产品需要预付%.2f元押金，取消代理后押金可退。",distributionDeposit];
    message = NSLocalizedString(messageString,nil);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:message];
    [messageAtt addAttribute:NSFontAttributeName value:UIFontRegularOfSize(16) range:NSMakeRange(0, message.length)];
    [messageAtt addAttribute:NSForegroundColorAttributeName value:Black626A75Color range:NSMakeRange(0, message.length)];
    [alertController setValue:messageAtt forKey:@"attributedMessage"];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消",nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"支付",nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self requestCreateDistribution];
        
        
        
        //商户服务器生成支付订单，先调用【统一下单API】生成预付单，获取到prepay_id后将参数再次签名传输给APP发起支付。以下是调起微信支付的关键代码：
        
       // 为了安全性，以下字段最好从服务器去获取

//        // 调起微信支付
//        PayReq *request = [[PayReq alloc] init];
//        /** 微信分配的公众账号ID -> APPID */
//        request.partnerId = APPID;
//        /** 预支付订单 从服务器获取 */
//        request.prepayId = @"1101000000140415649af9fc314aa427";
//        /** 商家根据财付通文档填写的数据和签名 <暂填写固定值Sign=WXPay>*/
//        request.package = @"Sign=WXPay";
//        /** 随机串，防重发 */
//        request.nonceStr= @"a462b76e7436e98e0ed6e13c64b4fd1c";
//        /** 时间戳，防重发 */
//        request.timeStamp= @“1397527777";
//        /** 商家根据微信开放平台文档对数据做的签名, 可从服务器获取，也可本地生成*/
//        request.sign= @"582282D72DD2B03AD892830965F428CB16E7A256";
        /* 调起支付 */
//        [WXApi sendReq:request];
    }];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
