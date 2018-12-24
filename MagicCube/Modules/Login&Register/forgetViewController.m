//
//  forgetViewController.m
//  MagicCube
//
//  Created by sophie on 2018/12/6.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "forgetViewController.h"
#import <VerifyCode/NTESVerifyCodeManager.h>

@interface forgetViewController ()<UITextFieldDelegate,NTESVerifyCodeManagerDelegate>{
    NSInteger i;
    NSString * sendaccount;
}
@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) UITextField *codeTextField;
@property (nonatomic,strong) UIButton *codeMessageBtn,*pwdChangeBtn;
@property (nonatomic,strong) UITextField *pwdTextField;
@property (nonatomic,strong) UIButton *finishBtn;
@property (nonatomic,strong) UILabel *timeLabel;//60秒后重发
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIView *lineView1;
@property (nonatomic,strong) UIView *lineView2;
@property (nonatomic,strong) UIView *lineView3;
@property (nonatomic,strong) UILabel *wechatLabel;
@property (nonatomic,strong) NTESVerifyCodeManager *manager;
@end

@implementation forgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    i = 60;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"请设置登录密码";
    [self initProtectMessageAttack];
    [self initSubViews];
}

- (void)initSubViews {
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.lineView1];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.lineView2];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.pwdChangeBtn];
    [self.view addSubview:self.lineView3];
    [self.view addSubview:self.finishBtn];
    [self.view addSubview:self.codeMessageBtn];
}

-(void)initProtectMessageAttack{
    // sdk调用
    self.manager = [NTESVerifyCodeManager sharedInstance];
    self.manager.delegate = self;
    // 设置透明度
    self.manager.alpha = 0.7;
    // 设置frame
    self.manager.frame = CGRectNull;
    // captchaId从网易申请，比如@"a05f036b70ab447b87cc788af9a60974"
    NSString *captchaId = knetEaseID;
    [self.manager configureVerifyCode:captchaId timeout:5];
}

-(void)sendRequest:(UIButton *)sender{
    sendaccount = self.phoneTextField.text.trimString;
    if (!sendaccount.isValidateMobile) {
        [BHToast showMessage:@"手机号有误，请重新输入"];
        return;
    }
    [self.manager openVerifyCodeView:nil];
     [self.view endEditing:YES];
}

- (void)submit:(UIButton *)sender{
    NSMutableDictionary * pramaDic = @{}.mutableCopy;
    [self.view endEditing:YES];
    NSString *code = self.codeTextField.text.trimString;
    NSString *pwdStr = self.pwdTextField.text.trimString;
    NSString *phoneStr = self.phoneTextField.text.trimString;
    if (!phoneStr.isValidateMobile) {
        [BHToast showMessage:@"手机号有误，请重新输入"];
        return;
    }
    if (code.length < 4) {
        [BHToast showMessage:@"请输入正确的验证码"];
        return;
    }
    if (pwdStr.length < 6) {
        [BHToast showMessage:@"请输入6-12位正确密码"];
        return;
    }
    if (![pwdStr isValidatePassword]) {
        [BHToast showMessage:@"密码格式有误，请重新输入"];
        return;
    }
    NSString *idString = [[UUID getUUID] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    [pramaDic setObject:pwdStr forKey:@"password"];
    [pramaDic setObject:code forKey:@"smsCode"];
    //    [pramaDic setObject:@"REG" forKey:@"operationCode"];
    [pramaDic setObject:phoneStr forKey:@"tel"];
    [pramaDic setObject:@"IOS" forKey:@"terminal"];
    [pramaDic setObject:idString forKey:@"terminalIdentifier"];
    WS(weakSelf)
    NSLog(@"-----kAppApiLogin--->%@",pramaDic);
    NMShowLoadIng;
    [BTERequestTools requestWithURLString:kAppApiFP parameters:pramaDic type:HttpRequestTypePost success:^(id responseObject) {
        NMRemovLoadIng;
        NSLog(@"---kAppApiFP--responseObject--->%@",responseObject);
        if(IsSucess(responseObject)) {
            [BHToast showMessage:@"修改成功 请去登录"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
            [BHToast showMessage:message];
        }
    } failure:^(NSError *error)  {
        NMRemovLoadIng;
        //        RequestError(error);
        NSLog(@"error-------->%@",error);
    }];
}

- (void)pwdTextSwitch:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) { // 按下去了就是明文
        NSString *tempPwdStr = self.pwdTextField.text;
        self.pwdTextField.text = @""; // 这句代码可以防止切换的时候光标偏移
        self.pwdTextField.secureTextEntry = NO;
        self.pwdTextField.text = tempPwdStr;
    } else { // 暗文
        NSString *tempPwdStr = self.pwdTextField.text;
        self.pwdTextField.text = @"";
        self.pwdTextField.secureTextEntry = YES;
        self.pwdTextField.text = tempPwdStr;
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

- (void)invalidateRetryTime{
    [self.timer invalidate];
    [self.timeLabel removeFromSuperview];
    self.timer = nil;
    i=60;
}

-(void)startClick{
    [BHToast showMessage:@"验证码已发送"];
    [self.codeMessageBtn removeFromSuperview];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runClock) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
}

#pragma mark - message server
- (void)requestCheckApi:(NSString *)sessionId{
    NSMutableDictionary * pramaDic = @{}.mutableCopy;
    [pramaDic setObject:sessionId forKey:@"validate"];
    [pramaDic setObject:@"FP" forKey:@"type"];
    [pramaDic setObject:sendaccount forKey:@"mobile"];
    WS(weakSelf)
    NSLog(@"-----requestCheckApi--->%@",pramaDic);
    NMShowLoadIng;
    [BTERequestTools requestWithURLString:kAppSendMs parameters:pramaDic type:HttpRequestTypePost success:^(id responseObject) {
        NMRemovLoadIng;
        NSLog(@"-----responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            [weakSelf startClick];
        }
        [self.view endEditing:YES];
    } failure:^(NSError *error)  {
        NMRemovLoadIng;
        //        RequestError(error);
        NSLog(@"error-------->%@",error);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES]; //实现该方法是需要注意view需要是继承UIControl而来的
}

//实现UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];//取消第一响应者
    return YES;
}
#pragma mark - NTESVerifyCodeManagerDelegate
/**
 * 验证码组件初始化完成
 */
- (void)verifyCodeInitFinish{
    NSLog(@"收到初始化完成的回调");
}

/**
 * 验证码组件初始化出错
 *
 * @param message 错误信息
 */
- (void)verifyCodeInitFailed:(NSString *)message{
    NSLog(@"收到初始化失败的回调:%@",message);
}

/**
 * 完成验证之后的回调
 *
 * @param result 验证结果 BOOL:YES/NO
 * @param validate 二次校验数据，如果验证结果为false，validate返回空
 * @param message 结果描述信息
 *
 */
- (void)verifyCodeValidateFinish:(BOOL)result validate:(NSString *)validate message:(NSString *)message{
    NSLog(@"%@",validate);
    if (result) {
        [self requestCheckApi:validate];
    }else{
        NSLog(@"收到验证结果的回调:(%d,%@,%@)", result, validate, message);
    }
}

/**
 * 关闭验证码窗口后的回调
 */
- (void)verifyCodeCloseWindow{
    //用户关闭验证后执行的方法
    NSLog(@"收到关闭验证码视图的回调");
}

/**
 * 网络错误
 *
 * @param error 网络错误信息
 */
- (void)verifyCodeNetError:(NSError *)error{
    //用户关闭验证后执行的方法
    NSLog(@"收到网络错误的回调:%@(%ld)", [error localizedDescription], (long)error.code);
}

-(UITextField *)phoneTextField{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, SCALE_W(47.5 -14), SCREEN_WIDTH - 80 - 100 - 10,  SCALE_W(14*3))];
        _phoneTextField.placeholder = @"请输入手机号";
        _phoneTextField.textAlignment = NSTextAlignmentLeft;
        _phoneTextField.tintColor = GrayMagicColor;
        _phoneTextField.font = UIFontRegularOfSize(14);
        _phoneTextField.textColor = GrayMagicColor;
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.returnKeyType = UIReturnKeyDone;
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
        _codeMessageBtn.frame = CGRectMake(SCREEN_WIDTH - 40 -99.5, SCALE_W(40),  SCALE_W(99.5),  SCALE_W(27));
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
        self.timeLabel.layer.borderColor = GrayMagicColor.CGColor;
        self.timeLabel.layer.borderWidth = 0.5;
    }
    return _timeLabel;
}

-(UITextField *)codeTextField{
    if (_codeTextField == nil) {
        _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, self.lineView1.bottom + SCALE_W(25-14), SCREEN_WIDTH - 80 ,  SCALE_W(14*3))];
        _codeTextField.placeholder = @"请输入短信验证码";
        _codeTextField.textAlignment = NSTextAlignmentLeft;
        _codeTextField.tintColor = GrayMagicColor;
        _codeTextField.font = UIFontRegularOfSize(14);
        _codeTextField.textColor = GrayMagicColor;
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
        _pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, self.lineView2.bottom + SCALE_W(25-14), SCREEN_WIDTH - 80 , SCALE_W( 14*3))];
        _pwdTextField.placeholder = @"请设置6～20位密码";
        _pwdTextField.textAlignment = NSTextAlignmentLeft;
        _pwdTextField.tintColor = GrayMagicColor;
        _pwdTextField.font = UIFontRegularOfSize(14);
        _pwdTextField.textColor = GrayMagicColor;
        _pwdTextField.secureTextEntry = YES;
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
        _finishBtn.frame = CGRectMake(40, SCALE_W(234), SCREEN_WIDTH - 80,  SCALE_W(45));
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

-(UIButton *)pwdChangeBtn{
    if (_pwdChangeBtn == nil) {
        _pwdChangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pwdChangeBtn.frame = CGRectMake(SCREEN_WIDTH - 45 -15,  SCALE_W(159), SCALE_W(15), SCALE_W(7));
        [_pwdChangeBtn setImage:[UIImage imageNamed:@"鼻炎"] forState:UIControlStateNormal];
        [_pwdChangeBtn setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateSelected];
        [_pwdChangeBtn addTarget:self action:@selector(pwdTextSwitch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pwdChangeBtn;
}
@end
