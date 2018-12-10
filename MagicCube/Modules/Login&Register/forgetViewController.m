//
//  forgetViewController.m
//  MagicCube
//
//  Created by sophie on 2018/12/6.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "forgetViewController.h"

@interface forgetViewController ()
{
    NSInteger i;
}
@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) UITextField *codeTextField;
@property (nonatomic,strong) UIButton *codeMessageBtn,*eyeBtn;
@property (nonatomic,strong) UITextField *pwdTextField;

@property (nonatomic,strong) UIButton *finishBtn;
@property(nonatomic,strong) UILabel *timeLabel;//60秒后重发

@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) UIView *lineView1;
@property(nonatomic,strong) UIView *lineView2;
@property(nonatomic,strong) UIView *lineView3;
@property(nonatomic,strong) UILabel *wechatLabel;
@end

@implementation forgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请设置登录密码";
    
    [self initSubViews];
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

- (void)invalidateRetryTime{
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

- (void)initSubViews {
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.lineView1];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.lineView2];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.eyeBtn];
    [self.view addSubview:self.lineView3];
    [self.view addSubview:self.finishBtn];
}

-(UITextField *)phoneTextField{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, SCALE_W(47.5 -14), SCREEN_WIDTH - 80 - 100 - 10, 14*3)];
        _phoneTextField.placeholder = @"请输入手机号";
        _phoneTextField.textAlignment = NSTextAlignmentLeft;
        _phoneTextField.tintColor = GrayLayerColor;
    }
    return _phoneTextField;
}

-(UIView *)lineView1{
    if (_lineView1 == nil) {
        _lineView1 = [[UIView alloc] initWithFrame:CGRectMake(40, SCALE_W(75.5), SCREEN_WIDTH - 80, 0.5)];
        _lineView1.backgroundColor = LineGrayColor;
    }
    return _lineView1;
}

-(UIButton *)codeMessageBtn{
    if (_codeMessageBtn == nil) {
        _codeMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeMessageBtn.frame = CGRectMake(SCREEN_WIDTH - 40 -99.5, SCALE_W(40), 99.5, 27);
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
        self.timeLabel.frame = CGRectMake(SCREEN_WIDTH - 40 -SCALE_W(46), SCALE_W(40), SCALE_W(46), SCALE_W(27));
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

-(UITextField *)codeTextField{
    if (_codeTextField == nil) {
        _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, self.lineView1.bottom +25-14, SCREEN_WIDTH - 80 , 14*3)];
        _codeTextField.placeholder = @"请输入短信验证码";
        _codeTextField.textAlignment = NSTextAlignmentLeft;
        _codeTextField.tintColor = GrayLayerColor;
    }
    return _codeTextField;
}

-(UIView *)lineView2{
    if (_lineView2 == nil) {
        _lineView2 = [[UIView alloc] initWithFrame:CGRectMake(40, SCALE_W(129.5), SCREEN_WIDTH - 80, 0.5)];
        _lineView2.backgroundColor = LineGrayColor;
    }
    return _lineView2;
}

-(UITextField *)pwdTextField{
    if (_pwdTextField == nil) {
        _pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, self.lineView2.bottom +25-14, SCREEN_WIDTH - 80 , 14*3)];
        _pwdTextField.placeholder = @"请设置6～20位密码";
        _pwdTextField.textAlignment = NSTextAlignmentLeft;
        _pwdTextField.tintColor = GrayLayerColor;
    }
    return _pwdTextField;
}

-(UIView *)lineView3{
    if (_lineView3 == nil) {
        _lineView3 = [[UIView alloc] initWithFrame:CGRectMake(40, SCALE_W(183.5), SCREEN_WIDTH - 80, 0.5)];
        _lineView3.backgroundColor = LineGrayColor;
    }
    return _lineView3;
}


-(UIButton *)finishBtn{
    if (_finishBtn == nil) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishBtn.frame = CGRectMake(40, SCALE_W(234), SCREEN_WIDTH - 80, 45);
        _finishBtn.titleLabel.font = UIFontMediumOfSize(18);
        _finishBtn.layer.masksToBounds = YES;
        _finishBtn.layer.cornerRadius = 45/2;
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _finishBtn.backgroundColor = RedMagicColor;
        [_finishBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}
@end