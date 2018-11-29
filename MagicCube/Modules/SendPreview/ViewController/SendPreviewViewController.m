
//
//  SendPreviewViewController.m
//  MagicCube
//
//  Created by sophiemarceau_qu on 2018/11/28.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "SendPreviewViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface SendPreviewViewController ()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *envelopBGView,*envelopView,*headView;
@property(nonatomic,strong)AVPlayerLayer *playlayer;
@property(nonatomic,strong)UIButton * playBtn;
@property(nonatomic,strong) AVPlayer *player;

@property(nonatomic,strong)UILabel *identifylLabel;
@property(nonatomic,strong)UILabel *identifySubLabel;

@property(nonatomic,strong)UILabel *proNameTitleLabel;
@property(nonatomic,strong)UILabel *proNameSubLabel;
@property(nonatomic,strong)UIButton *buyBtn,*sendBtn;

@property(nonatomic,strong)UILabel *proAddressLabel;
@property(nonatomic,strong)UILabel *proConfirmLabel;

@property(nonatomic,strong)UIImageView *ideitifylImageView;
@property(nonatomic,strong)UIImageView *productImageView;
@property(nonatomic,strong)UIImageView *addressImageView;

@property(nonatomic,strong)UIImageView *bgImageView;
@end

@implementation SendPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initDatas];
    [self initSubviews];
    [self requestData];
}

-(void)requestData{}

-(void)initDatas{
    self.title = @"发送预览";
}

-(void)initSubviews{
    [self.view addSubview:self.envelopBGView];
    [self.view addSubview:self.bgView];
    
    [self.bgView addSubview:self.bgImageView];
    
    [self.bgView addSubview:self.ideitifylImageView];
    [self.bgView addSubview:self.identifylLabel];
    [self.bgView addSubview:self.identifySubLabel];
    
    [self.bgView addSubview:self.proNameTitleLabel];
    [self.bgView addSubview:self.proNameSubLabel];
    [self.bgView addSubview:self.buyBtn];
    
    [self.bgView addSubview:self.proAddressLabel];
    [self.bgView addSubview:self.proConfirmLabel];
    
    [self.bgView addSubview:self.productImageView];
    [self.bgView addSubview:self.addressImageView];
    
    [self.view addSubview:self.envelopView];
    [self.view addSubview:self.playBtn];
    
    
    [self.view addSubview:self.sendBtn];
}

-(void)clickPlay:(UIButton *)sender{
    if (sender.selected) {
        [self.player pause];
    }else{
        [self.player play];
    }
    sender.selected = !sender.selected;
}

-(UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(85/2, 10.5, SCREEN_WIDTH - 85, 485)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView addSubview:self.headView];
        [_bgView.layer addSublayer:self.playlayer];
    }
    return _bgView;
}

-(UIImageView *)envelopBGView{
    if(_envelopBGView == nil){
        _envelopBGView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"红包低"]];
        _envelopBGView.frame = CGRectMake(0, SCALE_W(437 -120), SCREEN_WIDTH, 285);
    }
    return _envelopBGView;
}

-(UIImageView *)envelopView{
    if(_envelopView == nil){
        _envelopView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"红包"]];
        _envelopView.frame = CGRectMake(0, SCALE_W(437), SCREEN_WIDTH, 165);
    }
    return _envelopView;
}

-(UIImageView *)headView{
    if(_headView == nil){
        _headView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"头部卡片"]];
        _headView.frame = CGRectMake(0, 0, self.bgView.width, 110);
    }
    return _headView;
}

-(AVPlayerLayer *)playlayer{
    if (_playlayer == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"localvideo" ofType:@"mp4"];
        NSURL * url = [NSURL fileURLWithPath:path];
        self.player = [AVPlayer playerWithURL:url];
        _playlayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playlayer.frame = CGRectMake(15, self.headView.bottom + 11.5, self.bgView.width - 30, SCALE_W(140.5));
        _playlayer.backgroundColor = [[UIColor clearColor] CGColor];
    }
    return _playlayer;
}

-(UIButton *)playBtn{
    if (_playBtn == nil) {
        _playBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - SCALE_W(31)) * 0.5,
                                                                        SCALE_W(186.8),
                                                                        SCALE_W(31),
                                                                        SCALE_W(31))];
        [_playBtn setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
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
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyBtn.frame = CGRectMake((self.bgView.width - SCALE_W(125)) * 0.5, 287+110, 125, 30);
        _buyBtn.titleLabel.font = UIFontLightOfSize(16);
        _buyBtn.titleLabel.textColor = [UIColor whiteColor];
        [_buyBtn setTitle:@"付款" forState:UIControlStateNormal];
        _buyBtn.backgroundColor = RedMagicColor;
        _buyBtn.layer.cornerRadius = 3.5;
        _buyBtn.layer.masksToBounds = YES;
    }
    return _buyBtn;
}

-(UIButton *)sendBtn{
    if (_sendBtn == nil) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.frame = CGRectMake((SCREEN_WIDTH - self.bgView.width) * 0.5, 554, self.bgView.width, 18);
        _sendBtn.titleLabel.font = UIFontLightOfSize(20);
        _sendBtn.titleLabel.textColor = [UIColor whiteColor];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        _sendBtn.backgroundColor = [UIColor clearColor];
        _sendBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _sendBtn;
}
-(UILabel *)proAddressLabel{
    if (_proAddressLabel == nil) {
        _proAddressLabel = [self createlabel1frame:CGRectMake(0, 325+110,  self.bgView.width, 12)];
        _proAddressLabel.text = @"本卡信息已在蚂蚁金服区块链存证备查";
        _proAddressLabel.font = UIFontRegularOfSize(10);
        _proAddressLabel.textColor = GrayMagicColor;
        _proAddressLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _proAddressLabel;
}

-(UILabel *)proConfirmLabel{
    if (_proConfirmLabel == nil) {
        _proConfirmLabel = [self createlabel2frame:CGRectMake((self.bgView.width - SCALE_W(79.5)) * 0.5, 349+110,  SCALE_W(79.5), 16)];
        _proConfirmLabel.text = @"查看数字签名";
        _proConfirmLabel.font = UIFontRegularOfSize(10);
        _proConfirmLabel.textColor = GrayMagicColor;
        _proConfirmLabel.textAlignment = NSTextAlignmentCenter;
        _proConfirmLabel.layer.masksToBounds = YES;
        _proConfirmLabel.layer.borderWidth = 0.5;
        _proConfirmLabel.layer.borderColor = GrayMagicColor.CGColor;
        _proConfirmLabel.layer.cornerRadius = 2;
    }
    return _proConfirmLabel;
}

-(UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [self createImageViewframe:CGRectMake((self.bgView.width  -157)/2, 169+110, 157, 157) WithImageName:@"shuiyin"];
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
        _addressImageView = [self createImageViewframe:CGRectMake(32, 323+110,19, 19) WithImageName:@"防伪"];
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
@end