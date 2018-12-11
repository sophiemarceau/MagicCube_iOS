//
//  ChangeDeviceViewController.m
//  MagicCube
//
//  Created by sophie on 2018/12/11.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "ChangeDeviceViewController.h"
#import "forgetViewController.h"

@interface ChangeDeviceViewController (){
    NSInteger i;
}
@property(nonatomic,strong)UILabel *attentionView,*forgetPwdLabel;
@property (nonatomic,strong) UITextField *codeTextField,*phoneTextField;
@property (nonatomic,strong) UIButton *pwdChangeBtn,*loginBtn,*codeMessageBtn;
@property (nonatomic,strong) UIView *lineView,*lineView2;
@property (nonatomic,strong) UILabel *timeLabel;//60秒后重发
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation ChangeDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     i = 60;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"请输入密码";
    [self.view addSubview:self.attentionView];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.pwdChangeBtn];
    [self.view addSubview:self.loginBtn];
    
    if (self.changeDeviceStyle == changeByCodeMessage) {
        [self.view addSubview:self.phoneTextField];
        [self.view addSubview:self.codeMessageBtn];
        [self.view addSubview:self.lineView2];
        self.title = @"请输入短信验证码";
        self.codeTextField.placeholder = @"请输入短信验证码";
        self.codeTextField.frame = CGRectMake(40, self.lineView.bottom +25 -14, SCREEN_WIDTH - 80, 45);
        self.loginBtn.frame = CGRectMake(40, SCALE_W(220.5), SCREEN_WIDTH - 80, 45);
        self.pwdChangeBtn.hidden = YES;
        self.codeTextField.secureTextEntry = NO;
    }
    
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
-(void)onClickforgetBtn:(UIButton *)sender{
    forgetViewController *vc = [[forgetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loginOnclick:(UIButton *)sender{}

- (void)pwdTextSwitch:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) { // 按下去了就是明文
        NSString *tempPwdStr = self.codeTextField.text;
        self.codeTextField.text = @""; // 这句代码可以防止切换的时候光标偏移
        self.codeTextField.secureTextEntry = NO;
        self.codeTextField.text = tempPwdStr;
    } else { // 暗文
        NSString *tempPwdStr = self.codeTextField.text;
        self.codeTextField.text = @"";
        self.codeTextField.secureTextEntry = YES;
        self.codeTextField.text = tempPwdStr;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES]; //实现该方法是需要注意view需要是继承UIControl而来的
}

//实现UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];//取消第一响应者
    return YES;
}

-(UILabel *)attentionView{
    if (_attentionView == nil) {
        _attentionView = [[UILabel alloc] init];
        _attentionView.frame = CGRectMake(0, 0, SCREEN_WIDTH,  SCALE_W(40));
        _attentionView.backgroundColor = BHHexColorAlpha(@"FF8E28", 0.08);
        _attentionView.font = UIFontRegularOfSize(14);
        _attentionView.textAlignment = NSTextAlignmentCenter;
        _attentionView.textColor =  BHHexColor(@"FF8E28");
        _attentionView.text = @"系统检测到您已更换设备，请输入登陆密码";
    }
    return _attentionView;
}

-(UITextField *)codeTextField{
    if (_codeTextField == nil) {
        _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, SCALE_W(87.25-14), SCREEN_WIDTH - 80 - 15 - 45 - 10, 14*3)];
        _codeTextField.placeholder = @"请输入您的登录密码";
        //请输入您的登录密码
        _codeTextField.textAlignment = NSTextAlignmentLeft;
        _codeTextField.tintColor = GrayLayerColor;
        _codeTextField.secureTextEntry = YES;
    }
    return _codeTextField;
}

-(UIButton *)loginBtn{
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(40, SCALE_W(166.5), SCREEN_WIDTH - 80,  SCALE_W(45));
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

-(UILabel *)forgetPwdLabel{
    if (_forgetPwdLabel == nil) {
        _forgetPwdLabel  = [[UILabel alloc]init];
        _forgetPwdLabel.textColor = Gray666Color;
        _forgetPwdLabel.frame = CGRectMake(SCREEN_WIDTH - 40 -SCALE_W(70), SCALE_W(126.5), SCALE_W(70), SCALE_W(14));
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

-(UIButton *)pwdChangeBtn{
    if (_pwdChangeBtn == nil) {
        _pwdChangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pwdChangeBtn.frame = CGRectMake(SCREEN_WIDTH - 45 -15, 91, SCALE_W(15), SCALE_W(7));
        [_pwdChangeBtn setImage:[UIImage imageNamed:@"鼻炎"] forState:UIControlStateNormal];
        [_pwdChangeBtn setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateSelected];
        [_pwdChangeBtn addTarget:self action:@selector(pwdTextSwitch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pwdChangeBtn;
}

-(UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(40, SCALE_W(115.5), SCREEN_WIDTH - 80, 0.5)];
        _lineView.backgroundColor = LineGrayColor;
    }
    return _lineView;
}


-(UITextField *)phoneTextField{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, SCALE_W(87.5 -14), SCREEN_WIDTH - 80 - 100 - 10, 14*3)];
        _phoneTextField.placeholder = @"请输入手机号";
        _phoneTextField.textAlignment = NSTextAlignmentLeft;
        _phoneTextField.tintColor = GrayLayerColor;
    }
    return _phoneTextField;
}



-(UIButton *)codeMessageBtn{
    if (_codeMessageBtn == nil) {
        _codeMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeMessageBtn.frame = CGRectMake(SCREEN_WIDTH - 40 -99.5, SCALE_W(80), 99.5, 27);
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

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.textColor = GrayMagicColor;
        self.timeLabel.frame = CGRectMake(SCREEN_WIDTH - 40 -SCALE_W(46), SCALE_W(80), SCALE_W(46), SCALE_W(27));
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


-(UIView *)lineView2{
    if (_lineView2 == nil) {
        _lineView2 = [[UIView alloc] initWithFrame:CGRectMake(40, SCALE_W(169.5), SCREEN_WIDTH - 80, 0.5)];
        _lineView2.backgroundColor = LineGrayColor;
    }
    return _lineView2;
}
@end
