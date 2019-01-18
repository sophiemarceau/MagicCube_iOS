//
//  SendPreviewViewController.m
//  MagicCube
//
//  Created by sophiemarceau_qu on 2018/11/28.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "SendPreviewViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SmallCardView.h"
#import "WXApi.h"
#import "WXApiManager.h"
#import "CaptureScreenView.h"
#import "CLPlayerView.h"
#import "MagicHashCodeShowView.h"
#import "MagicHashCodeShowView.h"

@interface SendPreviewViewController ()<WXApiManagerDelegate>
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *envelopBGView,*envelopView,*headView;
@property(nonatomic,strong)UIButton * playBtn;
@property (strong,nonatomic) CLPlayerView * playerView;

@property(nonatomic,strong)UILabel *identifylLabel;
@property(nonatomic,strong)UILabel *identifySubLabel;

@property(nonatomic,strong)UILabel *proNameTitleLabel;
@property(nonatomic,strong)UILabel *proNameSubLabel;
@property(nonatomic,strong)UIButton *buyBtn,*sendBtn,*actionbBtn;

@property(nonatomic,strong)UILabel *proAddressLabel;
@property(nonatomic,strong)UIButton *proConfirmBtn;

@property(nonatomic,strong)UIImageView *ideitifylImageView;
@property(nonatomic,strong)UIImageView *productImageView;
@property(nonatomic,strong)UIImageView *addressImageView;

@property(nonatomic,strong)UIImageView *bgImageView;

@property (strong,nonatomic) SmallCardView * scardView;
@property (copy,nonatomic) NSString * hashCode;
@end

@implementation SendPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initDatas];
    [self initSubviews];
    [self requestData];
    [self configData];
}

-(void)viewDidAppear:(BOOL)animated{
    [WXApiManager sharedManager].delegate = self;
    [self.playerView pausePlay];
}

-(void)viewDidDisappear:(BOOL)animated{
    [WXApiManager sharedManager].delegate = nil;
    //销毁播放器
    [_playerView pausePlay];
    [_playerView destroyPlayer];
    _playerView = nil;
}

#pragma mark -- 数据请求
-(void)createDistribute{
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:[self.dataDict objectForKey:@"sn"] forKey:@"distributionSn"];
    [params setObject:@"wechat" forKey:@"platform"];
    [params setObject:[self.dataDict objectForKey:@"originalPrice"] forKey:@"price"];
    WS(weakSelf)
    NSLog(@"-----kAppApiDistributionForward--->%@",params);
    NMShowLoadIng;
    
    [BTERequestTools requestWithURLString:kAppApiDistributionForward parameters:params type:HttpRequestTypePost success:^(id responseObject) {
        NMRemovLoadIng;
        NSLog(@"---kAppApiDistributionForward--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            NSDictionary * dataDict = [responseObject objectForKey:@"data"];
            [weakSelf performSelectorOnMainThread:@selector(rewords:) withObject:dataDict waitUntilDone:YES];
        }else{
            NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
            [BHToast showMessage:message];
        }
    } failure:^(NSError *error)  {
        
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
}

-(void)requestData{}

-(void)initDatas{
    self.title = @"发送预览";
}

- (void)configData{
    [self.scardView setUpData:self.dataDict];
    NSLog(@"%@",self.dataDict);
    NSString * videoUrl = [self.dataDict objectForKey:@"video"];
    NSURL * url = [NSURL URLWithString:videoUrl];
//    self.player = [AVPlayer playerWithURL:url];
//    self.playlayer.player = self.player;
    
    WS(weakSelf)
    _playerView.url = url;
    _playerView.playBlock = ^{
        weakSelf.playBtn.hidden = YES;
    };
    //播放
    [_playerView pausePlay];
    //返回按钮点击事件回调
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
        //查询是否是全屏状态
        NSLog(@"%d",_playerView.isFullScreen);
    }];
    //播放完成回调
    [_playerView endPlay:^{
        //销毁播放器
        //        [_playerView destroyPlayer];
        //        _playerView = nil;
        NSLog(@"播放完成");
    }];
    
    NSString * manufacturer = [self.dataDict objectForKey:@"manufacturer"];
    _identifylLabel.text = [NSString stringWithFormat:@"本卡产品认证生产商为%@",manufacturer];
    _identifySubLabel.text = [NSString stringWithFormat:@"由%@数字签名确认",manufacturer];
    
    NSString * supplier = [self.dataDict objectForKey:@"supplier"];
    _proNameTitleLabel.text = [NSString stringWithFormat:@"本卡产品认证发货商为%@",supplier];
    _proNameSubLabel.text = [NSString stringWithFormat:@"由%@数字签名确认",supplier];
    
    self.hashCode = [self.dataDict objectForKey:@"hashCode"];
    
}

-(void)initSubviews{
    [self.view addSubview:self.envelopBGView];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.bgImageView];
    //    [self.bgView addSubview:self.ideitifylImageView];
    //    [self.bgView addSubview:self.identifylLabel];
    //    [self.bgView addSubview:self.identifySubLabel];
    //    [self.bgView addSubview:self.proNameTitleLabel];
    //    [self.bgView addSubview:self.proNameSubLabel];
    [self.bgView addSubview:self.buyBtn];
    [self.bgView addSubview:self.actionbBtn];
    [self.bgView addSubview:self.proAddressLabel];
    [self.bgView addSubview:self.proConfirmBtn];
//    [self.bgView addSubview:self.productImageView];
    [self.bgView addSubview:self.addressImageView];
    [self.view addSubview:self.envelopView];
    [self.view addSubview:self.playBtn];
    [self.view addSubview:self.sendBtn];
}

-(void)clickPlay:(UIButton *)sender{
    
    [self.playerView playVideo];
    sender.selected = !sender.selected;
    self.playBtn.hidden = YES;
}

- (void)rewords:(NSDictionary *)dataDict{
    if ([WXApi isWXAppInstalled]) {
        WXMiniProgramObject *wxMiniObject = [WXMiniProgramObject object];
        
        NSString * url = [NSString stringWithFormat:@"pages/card-package/card-package?type=distribution&nickname=%@&sn=%@",User.nickName,[dataDict objectForKey:@"sn"]];
        NSLog(@"url===>%@",url);
        wxMiniObject.webpageUrl = @"";//url;
        wxMiniObject.userName = kWechatMiniAppKey;  //拉起的小程序的username 小程序原始id
        wxMiniObject.path = url;//@"";
        wxMiniObject.hdImageData = nil;
        wxMiniObject.miniProgramType = WXMiniProgramTypePreview;
        // launchMiniProgramReq.path = path;    //拉起小程序页面的可带参路径，不填默认拉起小程序首页
        // WXMiniProgramTypeRelease = 0,       //**< 正式版  */
        // WXMiniProgramTypeTest = 1,        //**< 开发版  */
        // WXMiniProgramTypePreview = 2,         //**< 体验版  */
        // launchMiniProgramReq.miniProgramType = WXMiniProgramTypePreview; //拉起小程序的类型
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = [NSString stringWithFormat:@"%@送您一件福利-%@",User.nickName,[self.dataDict objectForKey:@"name"]];//@"魔方提货卡";
        //        message.description = @"小程序tdesc";
        message.mediaObject = wxMiniObject;
        UIImage *thumbImage = [CaptureScreenView getCapture:self.dataDict]; //[UIImage imageNamed:@"详情页"];
        //        nil;
        NSData *data = UIImageJPEGRepresentation(thumbImage, 0.1);
        message.thumbData = data;
        //        UIImage *resultImage = [UIImage imageWithData:data];
        //imageData;//兼容酒颁布节点图片，小于32k
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.message = message;
        req.scene = WXSceneSession;
        BOOL returnFlag =  [WXApi sendReq:req];
        NSLog(@"returnFlag --->%d",returnFlag);
        
        
        //        [WXApi sendReq:launchMiniProgramReq];
    } else {
        [BHToast showMessage:@"请您先安装微信"];
    }
    NSLog(@"gotoSmallProgrammer");
}

-(void)gotoSmallProgrammer:(id)sender{
    [self createDistribute];
}


- (void)managerDidRecvLaunchMiniProgram:(WXLaunchMiniProgramResp *)response {
    NSString *strMsg = [NSString stringWithFormat:@"errMsg:%@,errcode:%d", response.extMsg, response.errCode];
    NSLog(@"strMsg---->%@",strMsg);
}

-(UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(95/2, 25, SCREEN_WIDTH - 95, 408.5)];
        _bgView.backgroundColor = [UIColor whiteColor];
        //        [_bgView addSubview:self.headView];
        [_bgView addSubview:self.scardView];
//        [_bgView.layer addSublayer:self.playlayer];
        [_bgView addSubview:self.playerView];
        
        _bgView.layer.cornerRadius = 10;
        // 阴影颜色
        _bgView.layer.shadowColor = BHHexColorAlpha(@"000000", 0.4).CGColor;
        // 阴影偏移，默认(0, -3)
        _bgView.layer.shadowOffset = CGSizeMake(0,0);
        // 阴影透明度，默认0
        _bgView.layer.shadowOpacity = 0.5;
        // 阴影半径，默认3
        _bgView.layer.shadowRadius = 5;
        
        
    }
    return _bgView;
}

-(UIImageView *)envelopBGView{
    if(_envelopBGView == nil){
        _envelopBGView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"红包低"]];
        _envelopBGView.frame = CGRectMake(0, SCALE_W(360.5 -120)+15, SCREEN_WIDTH, 285);
    }
    return _envelopBGView;
}

-(UIImageView *)envelopView{
    if(_envelopView == nil){
        _envelopView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"红包"]];
        _envelopView.frame = CGRectMake(0, SCALE_W(360.5) + 15, SCREEN_WIDTH, 165);
    }
    return _envelopView;
}

-(SmallCardView *)scardView{
    if (!_scardView) {
        _scardView = [[SmallCardView alloc] initWithFrame:CGRectMake(0, 0, self.bgView.width, 119.5)];
        [_scardView setUpData:@{}];
    }
    return _scardView;
}
-(UIImageView *)headView{
    if(_headView == nil){
        _headView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"头部卡片"]];
        _headView.frame = CGRectMake(0, 0, self.bgView.width, 110);
    }
    return _headView;
}

//-(AVPlayerLayer *)playlayer{
//    if (!_playlayer) {
//        //        NSString *path = [[NSBundle mainBundle] pathForResource:@"localvideo" ofType:@"mp4"];
//        //        NSURL * url = [NSURL fileURLWithPath:path];
//        //        self.player = [AVPlayer playerWithURL:url];
//        _playlayer = [[AVPlayerLayer alloc] init];//[AVPlayerLayer playerLayerWithPlayer:self.player];
//        _playlayer.frame = CGRectMake(15, self.headView.bottom + 11.5, self.bgView.width - 30, SCALE_W(140.5));
//        _playlayer.backgroundColor = [[UIColor clearColor] CGColor];
//    }
//    return _playlayer;
//}

- (CLPlayerView *)playerView{
    if (!_playerView) {
        _playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(15, self.headView.bottom + 11.5, self.bgView.width - 30, SCALE_W(140.5))];
        
    }
    return _playerView;
}

-(UIButton *)playBtn{
    if (_playBtn == nil) {
        _playBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - SCALE_W(31)) * 0.5,
                                                              SCALE_W(186.8),
                                                              SCALE_W(31),
                                                              SCALE_W(31))];
        [_playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(clickPlay:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

-(UILabel *)identifylLabel{
    if (_identifylLabel == nil) {
        _identifylLabel = [self createlabel1frame:CGRectMake(61.5, 110+167, 203.5, 35)];
        _identifylLabel.numberOfLines = 2;
        _identifylLabel.text = @"本卡产品认证生产商为厦门燕之屋生物工程发展有限公司";
    }
    return _identifylLabel;
}

-(UILabel *)identifySubLabel{
    if (_identifySubLabel == nil) {
        _identifySubLabel = [self createlabel2frame:CGRectMake(24.5, self.identifylLabel.bottom +7, 218.5, 9)];
        _identifySubLabel.text = @"由厦门燕之屋生物工程发展有限公司数字签名确认";
    }
    return _identifySubLabel;
}

-(UILabel *)proNameTitleLabel{
    if (_proNameTitleLabel == nil) {
        _proNameTitleLabel = [self createlabel1frame:CGRectMake(61.5, 228+110, 203.5, 35)];
        _proNameTitleLabel.text = @"本卡产品认证发货商为厦门燕之屋生物工程发展有限公司";
        _proNameTitleLabel.numberOfLines = 2;
    }
    return _proNameTitleLabel;
}

-(UILabel *)proNameSubLabel{
    if (_proNameSubLabel == nil) {
        _proNameSubLabel = [self createlabel2frame:CGRectMake(24.5, self.proNameTitleLabel.bottom +7, 218.5, 9)];
        _proNameSubLabel.text = @"由厦门燕之屋生物工程发展有限公司数字签名确认";
    }
    return _proNameSubLabel;
}

-(UIButton *)buyBtn{
    if (_buyBtn == nil) {
        CGFloat buyWidth = (self.bgView.width - 45) * 0.5;
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyBtn.frame = CGRectMake(15, 287, buyWidth, 30);
        _buyBtn.titleLabel.font = UIFontLightOfSize(16);
        _buyBtn.titleLabel.textColor = [UIColor whiteColor];
        [_buyBtn setTitle:@"付款" forState:UIControlStateNormal];
        _buyBtn.backgroundColor = lightRedColor;
        _buyBtn.layer.cornerRadius = 3.5;
        _buyBtn.layer.masksToBounds = YES;
    }
    return _buyBtn;
}

-(UIButton *)actionbBtn{
    if (_actionbBtn == nil) {
        CGFloat buyWidth = (self.bgView.width - 45) * 0.5;
        _actionbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionbBtn.frame = CGRectMake(30 + buyWidth, 287, buyWidth, 30);
        _actionbBtn.titleLabel.font = UIFontLightOfSize(16);
        _actionbBtn.titleLabel.textColor = [UIColor whiteColor];
        [_actionbBtn setTitle:@"试试手气免费拿" forState:UIControlStateNormal];
        _actionbBtn.backgroundColor = lightRedColor;
        _actionbBtn.layer.cornerRadius = 3.5;
        _actionbBtn.layer.masksToBounds = YES;
    }
    return _actionbBtn;
}

-(UIButton *)sendBtn{
    if (_sendBtn == nil) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.frame = CGRectMake((SCREEN_WIDTH - self.bgView.width) * 0.5, 494, self.bgView.width, 18);
        _sendBtn.titleLabel.font = UIFontLightOfSize(20);
        _sendBtn.titleLabel.textColor = [UIColor whiteColor];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        _sendBtn.backgroundColor = [UIColor clearColor];
        _sendBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_sendBtn addTarget:self
                     action:@selector(gotoSmallProgrammer:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}
-(UILabel *)proAddressLabel{
    if (_proAddressLabel == nil) {
        _proAddressLabel = [self createlabel1frame:CGRectMake(0, 346,  self.bgView.width, 12)];
        _proAddressLabel.text = @"本卡信息已在蚂蚁金服区块链存证备查";
        _proAddressLabel.font = UIFontRegularOfSize(10);
        _proAddressLabel.textColor = GrayMagicColor;
        _proAddressLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _proAddressLabel;
}

-(UIButton *)proConfirmBtn{
    if (_proConfirmBtn == nil) {
        _proConfirmBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.bgView.width - SCALE_W(79.5)) * 0.5, 368,  SCALE_W(79.5), 16)];
        [_proConfirmBtn setTitle:@"查看数字签名" forState:UIControlStateNormal];
        [_proConfirmBtn setTitleColor:GrayMagicColor forState:UIControlStateNormal];
        _proConfirmBtn.titleLabel.font = UIFontRegularOfSize(10);
        [_proConfirmBtn addTarget:self action:@selector(lookHashCode) forControlEvents:UIControlEventTouchUpInside];
        _proConfirmBtn.layer.masksToBounds = YES;
        _proConfirmBtn.layer.borderWidth = 0.5;
        _proConfirmBtn.layer.borderColor = GrayMagicColor.CGColor;
        _proConfirmBtn.layer.cornerRadius = 2;
        
    }
    return _proConfirmBtn;
}

-(UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [self createImageViewframe:CGRectMake((self.bgView.width  -117)/2, 272, 117, 117) WithImageName:@"sendseal"];
    }
    return _bgImageView;
}

-(UIImageView *)ideitifylImageView{
    if (_ideitifylImageView == nil) {
        _ideitifylImageView = [self createImageViewframe:CGRectMake(24.5, 169+110, 28, 28) WithImageName:@"厂商"];
    }
    return _ideitifylImageView;
}

-(UIImageView *)productImageView{
    if (_productImageView == nil) {
        _productImageView = [self createImageViewframe:CGRectMake(24.5, 230+110, 28, 28) WithImageName:@"货源"];
    }
    return _productImageView;
}

-(UIImageView *)addressImageView{
    if (_addressImageView == nil) {
        _addressImageView = [self createImageViewframe:CGRectMake(31.5, 341,21, 22) WithImageName:@"sendfangwei"];
    }
    return _addressImageView;
}

- (UILabel *)createlabel1frame:(CGRect)frame{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = Gray7F7Color;
    label.font = UIFontRegularOfSize(12);
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

- (UILabel *)createlabel2frame:(CGRect)frame{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = BHHexColorAlpha(@"948B7F", 0.6);
    label.font = UIFontRegularOfSize(9);
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

- (UIImageView *)createImageViewframe:(CGRect)frame WithImageName:(NSString *)imageNameStr{
    UIImageView * tempImageView = [[UIImageView alloc] initWithFrame:frame];
    tempImageView.image = [UIImage imageNamed:imageNameStr];
    return tempImageView;
}


-(UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    return resultImage;
}




- (UIImage *)zipImageWithUrl:(id)imageUrl
{
    //    NSData * imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    NSData *imageData = UIImagePNGRepresentation(imageUrl);
    //    imageData = UIImagePNGRepresentation(imageUrl);
    CGFloat maxFileSize = 32*1024;
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    UIImage *image = [UIImage imageWithData:imageData];
    NSData *compressedData = UIImageJPEGRepresentation(image, compression);
    while ([compressedData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        compressedData = UIImageJPEGRepresentation(image, compression);
    }
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}

// 查看数字签名 按钮事件
- (void)lookHashCode{
    MagicHashCodeShowView * codeView = [[MagicHashCodeShowView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_HEIGHT - HOME_INDICATOR_HEIGHT) code:self.hashCode];
    [self.view addSubview:codeView];
}

@end

