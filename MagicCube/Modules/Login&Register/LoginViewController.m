//
//  LoginViewController.m
//  MagicCube
//
//  Created by sophie on 2018/12/5.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController (){
    UIView *lineView1,*lineView2;
    NSInteger i;
}
@property (nonatomic,strong) UIButton *wechatBtn;
@property(nonatomic,strong) UILabel *wechatLabel;
@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) UITextField *codeTextField;
@property (nonatomic,strong) UIButton *codeMessageBtn,*eyeBtn;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UILabel *timeLabel;//60秒后重发
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UILabel *forgetPwdLabel;
@property (nonatomic,strong) UILabel *gotoCodeLabel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     i = 60;
    self.title = @"登录魔方好物";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"图标"]];
    iconImageView.frame = CGRectMake((SCREEN_WIDTH - 79)/2, 39.5, 79, 79);
                           [self.view addSubview:iconImageView];
    
    [ self.view addSubview:self.phoneTextField ];
    lineView1 = [[UIView alloc] initWithFrame:CGRectMake(40, SCALE_W(214.5), SCREEN_WIDTH - 80, 0.5)];
    lineView1.backgroundColor = LineGrayColor;
                                [self.view addSubview:lineView1];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.codeMessageBtn];
    lineView2 = [[UIView alloc] initWithFrame:CGRectMake(40, SCALE_W(268.5), SCREEN_WIDTH - 80, 0.5)];
    lineView2.backgroundColor = LineGrayColor;
    [self.view addSubview:lineView2];
    [self.view addSubview:self.codeMessageBtn];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.gotoCodeLabel];
    [self.view addSubview:self.forgetPwdLabel];
    [self.view addSubview:self.wechatLabel];
    [self.view addSubview:self.eyeBtn];
    [self.view addSubview:self.wechatBtn];
}

-(void)runClock{
    self.timeLabel.text = [NSString stringWithFormat:@"%ldS",i];
    [self.view addSubview:self.timeLabel];
    i--;
    if (i<0) {
        [self.timer invalidate];
        [self.timeLabel removeFromSuperview];
        [self.view addSubview:self.codeMessageBtn];
       
        i=60;
    }
}

-  (void)invalidateRetryTime{
    [self.timer invalidate];
    [self.timeLabel removeFromSuperview];
    self.timer = nil;
    i=60;
}


-(void)sendRequest:(UIButton *)sender{
    [self.codeMessageBtn removeFromSuperview];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runClock) userInfo:nil repeats:YES];
    [self.timer fire];
}

-(void)loginOnclick:(UIButton *)sender{
    
}


-(UITextField *)phoneTextField{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, SCALE_W(186.5 -14), SCREEN_WIDTH - 80 - 100 - 10, 14*3)];
        _phoneTextField.placeholder = @"请输入手机号";
        _phoneTextField.textAlignment = NSTextAlignmentLeft;
        _phoneTextField.tintColor = GrayLayerColor;
        
        
    }
    return _phoneTextField;
}

-(UITextField *)codeTextField{
    if (_codeTextField == nil) {
        _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, lineView1.bottom +25-14, SCREEN_WIDTH - 80 - 100 - 10, 14*3)];
        _codeTextField.placeholder = @"请输入短信验证码";
        _codeTextField.textAlignment = NSTextAlignmentLeft;
        _codeTextField.tintColor = GrayLayerColor;
        
        
    }
    return _codeTextField;
}


-(UIButton *)codeMessageBtn{
    if (_codeMessageBtn == nil) {
        _codeMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeMessageBtn.frame = CGRectMake(SCREEN_WIDTH - 40 -99.5, SCALE_W(179), 99.5, 27);
        _codeMessageBtn.titleLabel.font = UIFontRegularOfSize(14);
        _codeMessageBtn.titleLabel.textColor = Gray666Color;
        _codeMessageBtn.layer.masksToBounds = YES;
        _codeMessageBtn.layer.cornerRadius = 27/2;
        [_codeMessageBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_codeMessageBtn setTitleColor:Gray666Color forState:UIControlStateNormal];
        _codeMessageBtn.layer.borderColor = RedMagicColor.CGColor;
        _codeMessageBtn.layer.borderWidth = 0.5f;
        _codeMessageBtn.backgroundColor = BHHexColorAlpha(@"B5262F", 0.06);
        [_codeMessageBtn addTarget:self action:@selector(sendRequest:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeMessageBtn;
}

-(UIButton *)loginBtn{
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(40, SCALE_W(317), SCREEN_WIDTH - 80, 45);
        _loginBtn.titleLabel.font = UIFontMediumOfSize(18);
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 45/2;
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.backgroundColor = RedMagicColor;
        [_loginBtn addTarget:self action:@selector(loginOnclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}


- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.textColor = GrayMagicColor;
        self.timeLabel.frame = CGRectMake(SCREEN_WIDTH - 40 -SCALE_W(46), SCALE_W(179), SCALE_W(46), SCALE_W(27));
        self.timeLabel.backgroundColor = [UIColor whiteColor];
        self.timeLabel.font = UIFontRegularOfSize(14);
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.layer.masksToBounds = YES;
        self.timeLabel.layer.cornerRadius =13.5;
        self.timeLabel.layer.borderColor = GrayLayerColor.CGColor;
        self.timeLabel.layer.borderWidth = 0.5;
    }
    return _timeLabel;
}

-(UILabel *)forgetPwdLabel{
    if (_forgetPwdLabel == nil) {
        _forgetPwdLabel  = [[UILabel alloc]init];
        _forgetPwdLabel.textColor = Gray666Color;
        _forgetPwdLabel.frame = CGRectMake(SCREEN_WIDTH - 40 -SCALE_W(70), SCALE_W(279.5), SCALE_W(70), SCALE_W(14));
        _forgetPwdLabel.backgroundColor = [UIColor whiteColor];
        _forgetPwdLabel.font = UIFontRegularOfSize(14);
        _forgetPwdLabel.textAlignment = NSTextAlignmentRight;
        _forgetPwdLabel.text = @"忘记密码?";
        _forgetPwdLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *gotoLoginGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickforgetBtn:)];
        [_forgetPwdLabel addGestureRecognizer:gotoLoginGesture];
    }
    return _forgetPwdLabel;
}


-(UILabel *)gotoCodeLabel{
    if (_gotoCodeLabel == nil) {
        _gotoCodeLabel = [[UILabel alloc]init];
        _gotoCodeLabel.textColor = RedMagicColor;
        _gotoCodeLabel.frame = CGRectMake( 0, SCALE_W(382),SCREEN_WIDTH , SCALE_W(14));
        _gotoCodeLabel.backgroundColor = [UIColor clearColor];
        _gotoCodeLabel.font = UIFontRegularOfSize(14);
        _gotoCodeLabel.textAlignment = NSTextAlignmentCenter;
        _gotoCodeLabel.text = @"短信验证码登录";
        _gotoCodeLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *gotoLoginGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeLoginType:)];
        [_gotoCodeLabel addGestureRecognizer:gotoLoginGesture];
    }
    return _gotoCodeLabel;
}

-(UIButton *)wechatBtn{
    if (_wechatBtn == nil) {
        _wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _wechatBtn.frame = CGRectMake((SCREEN_WIDTH - SCALE_W(36))/2 , SCALE_W(519), SCALE_W(36), SCALE_W(36));
        [_wechatBtn setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
        [_wechatBtn addTarget:self action:@selector(onClickWechatBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wechatBtn;
}

- (UILabel *)wechatLabel{
    if (_wechatLabel == nil) {
        _wechatLabel = [[UILabel alloc]init];
        _wechatLabel.textColor = Gray666Color;
        _wechatLabel.frame = CGRectMake(0, SCALE_W(569), SCREEN_WIDTH, SCALE_W(14));
        _wechatLabel.backgroundColor = [UIColor clearColor];
        _wechatLabel.font = UIFontRegularOfSize(14);
        _wechatLabel.textAlignment = NSTextAlignmentCenter;
        _wechatLabel.text = @"微信授权登录";
    }
    return _wechatLabel;
}
@end
