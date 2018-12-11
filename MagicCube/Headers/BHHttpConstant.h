//
//  BHHttpConstant.h
//  BitcoinHeadlines
//
//  Created by zhangyuanzhe on 2017/12/22.
//  Copyright © 2017年 zhangyuanzhe. All rights reserved.
//

#ifndef BHHttpConstant_h
#define BHHttpConstant_h
//1表示:正式 生产环境
//0表示:测试 开发环境
#define ONLION 0
//生产环境
#if ONLION
static NSString * const kDomain = @"https://m.bte.top/";
static NSString * const kHeader = @"https://m.bte.top/";
#define TimeString 7 * 24 * 3600
#else
//测试环境
static NSString * const kDomain = @"https://m.bte.top/";
static NSString * const kHeader = @"https://l.bte.top/";
#define TimeString 7
#endif

// h5入口地址 合伙人
#define kAppPartnerAddress [NSString stringWithFormat:@"%@%@",kHeader,@"ad/partner"]
/*************************************************************/

//获取用户账户信息
#define kAppApiGetAccount [NSString stringWithFormat:@"%@%@",kDomain,@"api/account"]
//获取收益信息
#define kAppApiGetIncome [NSString stringWithFormat:@"%@%@",kDomain,@"api/account/income"]
//登录用户信息获取
#define kAppApiGetUser [NSString stringWithFormat:@"%@%@",kDomain,@"api/user"]
//app端用户密码重置功能接口
#define kAppApiFP [NSString stringWithFormFat:@"%@%@",kDomain,@"api/user/app/fp"]
//app端用户登录接口,需上送终端和终端识别信息，如果与上次登录不符，则会触发二次校验
#define kAppApiLogin [NSString stringWithFormat:@"%@%@",kDomain,@"api/user/app/login"]
//app端用户登录二次校验接口,需上送登录信息、终端、终端识别信息和授权操作码
#define kAppApiAuth [NSString stringWithFormat:@"%@%@",kDomain,@"api/user/app/auth"]
//app端用户注册接口,需上送终端和终端识别信息
#define kAppApiReg [NSString stringWithFormat:@"%@%@",kDomain,@"api/user/app/reg"]
//判断手机号是否注册,true为可用 false为不可用
#define kAppApiCheck [NSString stringWithFormat:@"%@%@",kDomain,@"api/user/check"]
#endif /* BHHttpConstant_h */









