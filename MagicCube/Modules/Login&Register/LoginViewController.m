//
//  LoginViewController.m
//  MagicCube
//
//  Created by sophie on 2018/12/5.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "LoginViewController.h"
#import "forgetViewController.h"
#import <VerifyCode/NTESVerifyCodeManager.h>
#import "WXApiManager.h"
#import "ChangeDeviceViewController.h"
#import "wechatLoginViewController.h"
@interface LoginViewController ()<UITextFieldDelegate,NTESVerifyCodeManagerDelegate,WXApiManagerDelegate>{
    UIView *lineView1,*lineView2;
    NSInteger i;
    NSString * sendaccount;
    
}
@property (nonatomic,strong) UIButton *wechatBtn;
@property (nonatomic,strong) UILabel *wechatLabel;
@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) UITextField *codeTextField;
@property (nonatomic,strong) UIButton *codeMessageBtn,*pwdChangeBtn;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UILabel *timeLabel;//60秒后重发
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UILabel *forgetPwdLabel;
@property (nonatomic,strong) UILabel *gotoCodeLabel;
@property (nonatomic, strong) NTESVerifyCodeManager *manager;
@property (nonatomic,strong) NSString *localSessionStr;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.authFlag) {
        self.phoneTextField.text = self.phoneStr;
    }
    self.localSessionStr = @"";
    i = 60;
    [WXApiManager sharedManager].delegate = self;
    [self initProtectMessageAttack];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"图标"]];
    iconImageView.frame = CGRectMake((SCREEN_WIDTH - 79)/2, 39.5, 79, 79);
    [self.view addSubview:iconImageView];
    
    [self.view addSubview:self.phoneTextField ];
    
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
    [self.view addSubview:self.pwdChangeBtn];
    [self.view addSubview:self.wechatBtn];
    
   
    if (self.loginStyle == pwdLogin) {
        self.title = @"账号密码登录";
        self.wechatLabel.hidden = NO;
        self.wechatBtn.hidden = NO;
        self.gotoCodeLabel.hidden = NO;
        self.forgetPwdLabel.hidden = NO;
        self.pwdChangeBtn.hidden = NO;
        self.codeTextField.secureTextEntry = YES;
        self.codeMessageBtn.hidden = YES;
    }else if (self.loginStyle == codeMessageLogin) {
        self.title = @"登录魔方好物";
        self.codeTextField.placeholder = @"请输入短信验证码";
        self.wechatLabel.hidden = YES;
        self.wechatBtn.hidden = YES;
        self.gotoCodeLabel.hidden = YES;
        self.forgetPwdLabel.hidden = YES;
        self.pwdChangeBtn.hidden = YES;
        self.codeTextField.secureTextEntry = NO;
        self.codeMessageBtn.hidden = NO;
    }
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

-(void)loginOnclick:(UIButton *)sender{
    NSMutableDictionary * pramaDic = @{}.mutableCopy;
    [self.view endEditing:YES];
    NSString *code = self.codeTextField.text.trimString;
    NSString *phoneStr = self.phoneTextField.text.trimString;
    if (self.loginStyle == pwdLogin) {
        if (code.length < 6) {
            [BHToast showMessage:@"请输入6-12位正确密码"];
            return;
        }
        if (![code isValidatePassword]) {
            [BHToast showMessage:@"密码格式有误，请重新输入"];
            return;
        }
        [pramaDic setObject:code forKey:@"password"];
    }else if (self.loginStyle == codeMessageLogin) {
        if (code.length < 4) {
            [BHToast showMessage:@"请输入正确的验证码"];
            return;
        }
        [pramaDic setObject:code forKey:@"smsCode"];
    }
    if (!phoneStr.isValidateMobile) {
        [BHToast showMessage:@"手机号有误，请重新输入"];
        return;
    }
    
    NSString *idString = [[UUID getUUID] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    [pramaDic setObject:phoneStr forKey:@"tel"];
    [pramaDic setObject:@"IOS" forKey:@"terminal"];
    [pramaDic setObject:idString forKey:@"terminalIdentifier"];
    WS(weakSelf)
    
    NSString *url;
    if (self.authFlag) {
        url = kAppApiAuth;
        [pramaDic setObject:self.operationCodeStr forKey:@"operationCode"];
    }else{
        url = kAppApiLogin;
    }
    if(![self.localSessionStr isEqualToString:@""]){
        [pramaDic setObject:self.localSessionStr forKey:@"localSession"];
    }
    NSLog(@"-----%@--->%@",url,pramaDic);
    NMShowLoadIng;
    [BTERequestTools requestWithURLString:url parameters:pramaDic type:HttpRequestTypePost success:^(id responseObject) {
        NMRemovLoadIng;
        NSLog(@"---%@--responseObject--->%@",url,responseObject);
        if (IsSucess(responseObject)) {
            //            UserObject * yy = [UserObject yy_modelWithDictionary:responseObject];
            UserObject * yy =  [UserObject shareInstance];
            yy.token = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"data"]];
            [yy save];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME_LOGINStatusChange object:nil userInfo:nil];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
            NSString *codeStr = [NSString stringWithFormat:@"%@",[responseObject  objectForKey:@"code"]];
            if ([codeStr isEqualToString:@"4000"]) {
                NSString *operationCodeStr = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"operationCode"]];
//                LoginViewController *vc = [[LoginViewController alloc] init];
                ChangeDeviceViewController *vc= [[ChangeDeviceViewController alloc] init];
                
                if (weakSelf.loginStyle == pwdLogin) {
                     vc.changeDeviceStyle = changeByCodeMessage;
//                     vc.loginStyle = codeMessageLogin;
                }else if (weakSelf.loginStyle == codeMessageLogin) {
//                     vc.loginStyle = pwdLogin;
                     vc.changeDeviceStyle = changeByPwd;
                }
//                vc.authFlag = YES;
                vc.phoneStr = phoneStr;
                vc.operationCodeStr = operationCodeStr;
                [weakSelf.navigationController pushViewController:vc animated:YES];
                return ;
            }
            NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
            [BHToast showMessage:message];
        }
    } failure:^(NSError *error)  {
        NMRemovLoadIng;
        //        RequestError(error);
        NSLog(@"error-------->%@",error);
    }];
}

-(void)changeLoginType:(UIButton *)sender{
    LoginViewController *vc = [[LoginViewController alloc] init];
    vc.loginStyle = codeMessageLogin;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)onClickWechatBtn:(UIButton *)sender{
    if ([WXApi isWXAppInstalled]) {
        //构造SendAuthReq结构体
        SendAuthReq* req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = kWechatStatueStr;
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendReq:req];
    }
//    wechatLoginViewController *vc= [[wechatLoginViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void)onClickforgetBtn:(UIButton *)sender{
    forgetViewController *vc = [[forgetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pwdTextSwitch:(UIButton *)sender {
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

-(void)startClick{
    [BHToast showMessage:@"验证码已发送"];
    [self.codeMessageBtn removeFromSuperview];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runClock) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
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

-(void)invalidateRetryTime{
    [self.timer invalidate];
    [self.timeLabel removeFromSuperview];
    self.timer = nil;
    i=60;
}

#pragma mark - server
- (void)requestCheckApi:(NSString *)sessionId{
    NSMutableDictionary * pramaDic = @{}.mutableCopy;
    [pramaDic setObject:sessionId forKey:@"validate"];
    [pramaDic setObject:@"LOGIN" forKey:@"type"];
    [pramaDic setObject:sendaccount forKey:@"mobile"];
    WS(weakSelf)
    NSLog(@"-----requestCheckApi--->%@",pramaDic);
    NMShowLoadIng;
    [BTERequestTools requestWithURLString:kAppSendMs parameters:pramaDic type:HttpRequestTypePost success:^(id responseObject) {
        NMRemovLoadIng;
        NSLog(@"-----responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            [weakSelf startClick];
        }else{
            NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
            [BHToast showMessage:message];
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

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
    NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", response.code, response.state, response.errCode];
    NSLog(@"strMsg-------->%@",strMsg);
    if([response.state isEqualToString:kWechatStatueStr]){
        NSMutableDictionary * pramaDic = @{}.mutableCopy;
        [pramaDic setObject:response.code forKey:@"code"];
        WS(weakSelf)
        NSLog(@"-----requestCheckApi--->%@",pramaDic);
        NMShowLoadIng;
        [BTERequestTools requestWithURLString:kAppApiWXogin parameters:pramaDic type:HttpRequestTypeGet success:^(id responseObject) {
            NMRemovLoadIng;
            NSLog(@"kAppApiWXogin-----responseObject--->%@",responseObject);
            if (IsSucess(responseObject)) {
                UserObject * yy =  [UserObject shareInstance];
                yy.token = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"data"]];
                [yy save];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME_LOGINStatusChange object:nil userInfo:nil];
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }else{
                if( [[responseObject objectForKey:@"code"] isEqualToString:@"USER000"]){
                    self.wechatBtn.hidden = YES;
                    self.localSessionStr = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"localSession"]];
                }
            }
            [self.view endEditing:YES];
        } failure:^(NSError *error)  {
            NMRemovLoadIng;
            //        RequestError(error);
            NSLog(@"error-------->%@",error);
        }];
        
    }
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
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, SCALE_W(186.5)-SCALE_W(14), SCREEN_WIDTH - 80 - 100 - 10, SCALE_W(14*3))];
        _phoneTextField.placeholder = @"请输入手机号";
        _phoneTextField.textAlignment = NSTextAlignmentLeft;
        _phoneTextField.tintColor = GrayMagicColor;
        _phoneTextField.font =  UIFontRegularOfSize(14);
        _phoneTextField.textColor = GrayMagicColor;
    }
    return _phoneTextField;
}

-(UITextField *)codeTextField{
    if (_codeTextField == nil) {
        _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, lineView1.bottom +SCALE_W(25-14), SCREEN_WIDTH - 80 - 100 - 10, SCALE_W(14*3))];
        _codeTextField.placeholder = @"请输入您的登录密码";
        //请输入您的登录密码
        _codeTextField.textAlignment = NSTextAlignmentLeft;
        _codeTextField.tintColor = GrayMagicColor;
        _codeTextField.font =  UIFontRegularOfSize(14);
        _codeTextField.textColor = GrayMagicColor;
    }
    return _codeTextField;
}

-(UIButton *)codeMessageBtn{
    if (_codeMessageBtn == nil) {
        _codeMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeMessageBtn.frame = CGRectMake(SCREEN_WIDTH - 40 -99.5, SCALE_W(179), SCALE_W(99.5), SCALE_W(27));
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
        _loginBtn.frame = CGRectMake(40, SCALE_W(317), SCREEN_WIDTH - 80, SCALE_W(45));
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

-(UIButton *)pwdChangeBtn{
    if (_pwdChangeBtn == nil) {
        _pwdChangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pwdChangeBtn.frame = CGRectMake(SCREEN_WIDTH - 45 - 15, SCALE_W(244), SCALE_W(15), SCALE_W(7));
        [_pwdChangeBtn setImage:[UIImage imageNamed:@"鼻炎"] forState:UIControlStateNormal];
        [_pwdChangeBtn setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateSelected];
        [_pwdChangeBtn addTarget:self action:@selector(pwdTextSwitch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pwdChangeBtn;
}
@end
