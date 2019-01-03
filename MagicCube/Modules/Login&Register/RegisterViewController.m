//
//  RegisterViewController.m
//  MagicCube
//
//  Created by sophie on 2018/12/5.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import <VerifyCode/NTESVerifyCodeManager.h>
#import "JPUSHService.h"
#import "WXApiManager.h"
#import "wechatLoginViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate,NTESVerifyCodeManagerDelegate,WXApiManagerDelegate>{
     NSInteger i;
    NSString * sendaccount;
   
}
@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) UITextField *codeTextField;
@property (nonatomic,strong) UIButton *codeMessageBtn,*wechatBtn,*pwdChangeBtn;
@property (nonatomic,strong) UITextField *pwdTextField;
@property (nonatomic,strong) UITextField *inviteTextField;
@property (nonatomic,strong) UIButton *registerBtn;
@property (nonatomic,strong) UILabel *timeLabel;//60秒后重发
@property (nonatomic,strong) UILabel *gotoLabel;//60秒后重发
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIView *lineView1;
@property (nonatomic,strong) UIView *lineView2;
@property (nonatomic,strong) UIView *lineView3;
@property (nonatomic,strong) UIView *lineView4;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *wechatLabel;
@property (nonatomic,strong) NSString *localSessionStr;
@property (nonatomic, strong) NTESVerifyCodeManager *manager;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    i = 60;
    self.localSessionStr = @"";
    
    [self initProtectMessageAttack];
    self.title = @"手机注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
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

-(void)initSubViews{
    self.view.userInteractionEnabled = YES;
    [self.view addSubview:self.iconImageView];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.lineView1];
    
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.codeMessageBtn];
    [self.view addSubview:self.lineView2];
    
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.lineView3];
    
    [self.view addSubview:self.inviteTextField];
    [self.view addSubview:self.lineView4];

    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.gotoLabel];
    
    [self.view addSubview:self.wechatBtn];
    [self.view addSubview:self.wechatLabel];
    
    [self.view addSubview:self.pwdChangeBtn];
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
    sendaccount = self.phoneTextField.text.trimString;
    if (!sendaccount.isValidateMobile) {
        [BHToast showMessage:@"手机号有误，请重新输入"];
        return;
    }else{
        [self checkPhoneNumberWhetherRegister];
    }
    [self.view endEditing:YES];
}

-(void)gotoLogin:(UITapGestureRecognizer *)recognizer{
    UILabel *label=(UILabel*)recognizer.view;
    NSLog(@"%@被点击了",label.text);
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
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
}

-(void)checkPhoneNumberWhetherRegister{
    NSString *url = [NSString stringWithFormat:@"%@/%@",kAppApiCheck,sendaccount];
    NSLog(@"checkPhoneNumberWhetherRegister---->%@",url);
    [BTERequestTools requestWithURLString:url parameters:nil type:HttpRequestTypeGet success:^(id responseObject) {
        NMRemovLoadIng;
        NSLog(@"---kAppApiCheck--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
           Boolean flag = [[responseObject objectForKey:@"data"] boolValue];
            if (!flag) {
                [BHToast showMessage:@"手机号号已注册，请直接去登录"];
                
            }else{
                [self.manager openVerifyCodeView:nil];
            }
        }
        [self.view endEditing:YES];
    } failure:^(NSError *error)  {
        NMRemovLoadIng;
        //        RequestError(error);
        NSLog(@"error-------->%@",error);
    }];
}

-(void)registernclick:(UIButton *)sender{
    NSMutableDictionary * pramaDic = @{}.mutableCopy;
    NSString *invite = self.inviteTextField.text.trimString;
    NSString *code = self.codeTextField.text.trimString;
    NSString *pwd = self.pwdTextField.text.trimString;
    if (!sendaccount.isValidateMobile) {
        [BHToast showMessage:@"手机号有误，请重新输入"];
        return;
    }
    if (code.length < 4) {
        [BHToast showMessage:@"请输入正确的验证码"];
        return;
    }
    if (pwd.length < 6) {
        [BHToast showMessage:@"请输入6-12位正确密码"];
        return;
    }
    if (![pwd isValidatePassword]) {
        [BHToast showMessage:@"密码格式有误，请重新输入"];
        return;
    }
    NSString *idString = [[UUID getUUID] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [pramaDic setObject:invite forKey:@"inviteCode"];
//    [pramaDic setObject:@"REG" forKey:@"operationCode"];
    [pramaDic setObject:pwd forKey:@"password"];
    [pramaDic setObject:code forKey:@"smsCode"];
    [pramaDic setObject:sendaccount forKey:@"tel"];
    [pramaDic setObject:@"IOS" forKey:@"terminal"];
    [pramaDic setObject:idString forKey:@"terminalIdentifier"];
    if(![self.localSessionStr isEqualToString:@""]){
         [pramaDic setObject:self.localSessionStr forKey:@"localSession"];
    }
    WS(weakSelf)
    
    
    NSLog(@"-----%@--->%@",kAppApiReg,pramaDic);
    
    NMShowLoadIng;
    [BTERequestTools requestWithURLString:kAppApiReg parameters:pramaDic type:HttpRequestTypePost success:^(id responseObject) {
        NMRemovLoadIng;
        NSLog(@"---kAppApiReg--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            [JPUSHService setAlias:idString completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                NSLog(@"isrescode=%ld",iResCode);
            } seq:1];
//            UserObject * yy = [UserObject yy_modelWithDictionary:responseObject];
            UserObject * yy =  [UserObject shareInstance];
            yy.token = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"data"]];
            [yy save];
            
            
            
            [BHToast showMessage:@"注册成功"];
            
            [weakSelf performSelector:@selector(successLogin) withObject:nil afterDelay:1.0f];
          
          
        }
        [self.view endEditing:YES];
    } failure:^(NSError *error)  {
        NMRemovLoadIng;
        //        RequestError(error);
        NSLog(@"error-------->%@",error);
    }];
}

-(void)successLogin{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME_LOGINStatusChange object:nil userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
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
    [pramaDic setObject:@"REG" forKey:@"type"];
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
        NSLog(@"-----kAppApiWXogin--->%@",pramaDic);
        NMShowLoadIng;
        [BTERequestTools requestWithURLString:kAppApiWXLogin parameters:pramaDic type:HttpRequestTypeGet success:^(id responseObject) {
            NMRemovLoadIng;
            NSLog(@"kAppApiWXogin-----responseObject--->%@",responseObject);
            if (IsSucess(responseObject)) {
                UserObject * yy =  [UserObject shareInstance];
                yy.token = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"data"]];
                [yy save];

                [BHToast showMessage:@"注册成功"];
                
                [weakSelf performSelector:@selector(successLogin) withObject:nil afterDelay:1.0f];
            }else{
                if( [[responseObject objectForKey:@"code"] isEqualToString:@"USER000"]){
                    [BHToast showMessage:@"已微信登录 请您注册绑定手机"];
                    self.wechatBtn.enabled = NO;
                    [self performSelector:@selector(hidden) withObject:nil afterDelay:1.0f];
                    self.localSessionStr = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"data"]];
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

-(void)hidden{
    self.wechatBtn.hidden = YES;
    self.wechatLabel.hidden = YES;
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.wechatBtn.enabled = YES;
    self.wechatBtn.hidden = NO;
    self.wechatLabel.hidden = NO;
  
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
     [WXApiManager sharedManager].delegate = self;
}

-(void)viewDidDisappear:(BOOL)animated{
    [WXApiManager sharedManager].delegate = nil;
}

-(UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"图标"]];
        _iconImageView.frame = CGRectMake((SCREEN_WIDTH - 79)/2, SCALE_W(40), SCALE_W(79), SCALE_W(79));
    }
    return _iconImageView;
}

-(UITextField *)phoneTextField{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, SCALE_W(194.5)-SCALE_W(14*3), SCREEN_WIDTH - 80 - 100 - 10,SCALE_W(14*3) )];
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
        _lineView1 = [[UIView alloc] initWithFrame:CGRectMake(40, SCALE_W(194.5), SCREEN_WIDTH - 80, 0.5)];
        _lineView1.backgroundColor = LineGrayColor;
    }
    return _lineView1;
}

-(UIButton *)codeMessageBtn{
    if (_codeMessageBtn == nil) {
        _codeMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeMessageBtn.frame = CGRectMake(SCREEN_WIDTH - 40 -99.5, SCALE_W(159),SCALE_W(99.5) , SCALE_W(27));
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
        self.timeLabel.frame = CGRectMake(SCREEN_WIDTH - 40 -SCALE_W(46), SCALE_W(159), SCALE_W(46), SCALE_W(27));
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
        _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, self.lineView1.bottom +SCALE_W(25-14), SCREEN_WIDTH - 80 , SCALE_W(14*3))];
        _codeTextField.placeholder = @"请输入短信验证码";
        _codeTextField.keyboardType = UIKeyboardTypePhonePad;
        _codeTextField.textAlignment = NSTextAlignmentLeft;
        _codeTextField.tintColor = GrayMagicColor;
        _codeTextField.font = UIFontRegularOfSize(14);
        _codeTextField.textColor = GrayMagicColor;
        _codeTextField.returnKeyType = UIReturnKeyDone;
    }
    return _codeTextField;
}

-(UIView *)lineView2{
    if (_lineView2 == nil) {
        _lineView2 = [[UIView alloc] initWithFrame:CGRectMake(40, SCALE_W(248.5), SCREEN_WIDTH - 80, 0.5)];
        _lineView2.backgroundColor = LineGrayColor;
    }
    return _lineView2;
}

-(UITextField *)pwdTextField{
    if (_pwdTextField == nil) {
        _pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, self.lineView2.bottom +SCALE_W(25-14), SCREEN_WIDTH - 80 , SCALE_W(14*3))];
        _pwdTextField.placeholder = @"请设置6～20位密码";
        _pwdTextField.textAlignment = NSTextAlignmentLeft;
        _pwdTextField.tintColor = GrayMagicColor;
        _pwdTextField.font = UIFontRegularOfSize(14);
        _pwdTextField.textColor = GrayMagicColor;
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.returnKeyType = UIReturnKeyDone;
        _pwdTextField.delegate = self;
    }
    return _pwdTextField;
}

-(UIView *)lineView3{
    if (_lineView3 == nil) {
        _lineView3 = [[UIView alloc] initWithFrame:CGRectMake(40, SCALE_W(302.5), SCREEN_WIDTH - 80, 0.5)];
        _lineView3.backgroundColor = LineGrayColor;
    }
    return _lineView3;
}

-(UITextField *)inviteTextField{
    if (_inviteTextField == nil) {
        _inviteTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, self.lineView3.bottom +SCALE_W(25-14), SCREEN_WIDTH - 80 , SCALE_W(14*3))];
        _inviteTextField.placeholder = @"请输入邀请码（选填）";
        _inviteTextField.textAlignment = NSTextAlignmentLeft;
        _inviteTextField.tintColor = GrayMagicColor;
        _inviteTextField.font = UIFontRegularOfSize(14);
        _inviteTextField.textColor = GrayMagicColor;
        _inviteTextField.returnKeyType = UIReturnKeyDone;
        _inviteTextField.delegate = self;
    }
    return _inviteTextField;
}

-(UIView *)lineView4{
    if (_lineView4 == nil) {
        _lineView4 = [[UIView alloc] initWithFrame:CGRectMake(40, SCALE_W(356.5), SCREEN_WIDTH - 80, 0.5)];
        _lineView4.backgroundColor = LineGrayColor;
    }
    return _lineView4;
}

-(UIButton *)registerBtn{
    if (_registerBtn == nil) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerBtn.frame = CGRectMake(40, SCALE_W(387.5), SCREEN_WIDTH - 80, SCALE_W(45));
        _registerBtn.titleLabel.font = UIFontMediumOfSize(18);
        _registerBtn.layer.masksToBounds = YES;
        _registerBtn.layer.cornerRadius = 45/2;
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _registerBtn.backgroundColor = RedMagicColor;
        [_registerBtn addTarget:self action:@selector(registernclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (UILabel *)gotoLabel {
    if (_gotoLabel == nil) {
        _gotoLabel = [[UILabel alloc]init];
        _gotoLabel.textColor = Gray666Color;
        _gotoLabel.frame = CGRectMake(0, SCALE_W(452.5), SCREEN_WIDTH, SCALE_W(14));
        _gotoLabel.backgroundColor = [UIColor clearColor];
        _gotoLabel.font = UIFontRegularOfSize(14);
        _gotoLabel.textAlignment = NSTextAlignmentCenter;
        UIFont *font =  UIFontRegularOfSize(14);
        NSDictionary * attubtrDict = @{NSFontAttributeName:font,NSForegroundColorAttributeName:RedMagicColor};
        NSString *deliveryPrice =@"已有账户，去登录";
        NSString *price = @"登录";
        NSAttributedString * attributestring = [MagicRichTool initWithString:deliveryPrice dict:attubtrDict subString:price];
        _gotoLabel.attributedText = attributestring;
        _gotoLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *gotoLoginGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoLogin:)];
        [_gotoLabel addGestureRecognizer:gotoLoginGesture];
        
    }
    return _gotoLabel;
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
        _pwdChangeBtn.frame = CGRectMake(SCREEN_WIDTH - 45 -15, SCALE_W(278), SCALE_W(15), SCALE_W(7));
        [_pwdChangeBtn setImage:[UIImage imageNamed:@"鼻炎"] forState:UIControlStateNormal];
        [_pwdChangeBtn setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateSelected];
        [_pwdChangeBtn addTarget:self action:@selector(pwdTextSwitch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pwdChangeBtn;
}
@end
