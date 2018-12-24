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
static NSString * const kDomain =
@"http://172.16.24.185:8090/";
//@"http://47.94.217.12:8090/";
static NSString * const kHeader = @"https://l.bte.top/";
#define TimeString 7
#endif

// h5入口地址 合伙人
#define kAppPartnerAddress [NSString stringWithFormat:@"%@%@",kHeader,@"ad/partner"]
/*************************************************************/
//发送短信验证码
#define kAppSendMs [NSString stringWithFormat:@"%@%@",kDomain,@"api/sms"]
//获取用户账户信息
#define kAppApiGetAccount [NSString stringWithFormat:@"%@%@",kDomain,@"api/account"]
//获取收益信息
#define kAppApiGetIncome [NSString stringWithFormat:@"%@%@",kDomain,@"api/account/income"]
//登录用户信息获取
#define kAppApiGetUser [NSString stringWithFormat:@"%@%@",kDomain,@"api/user"]
//app端用户密码重置功能接口
#define kAppApiFP [NSString stringWithFormat:@"%@%@",kDomain,@"api/user/app/fp"]
//app端用户登录接口,需上送终端和终端识别信息，如果与上次登录不符，则会触发二次校验
#define kAppApiLogin [NSString stringWithFormat:@"%@%@",kDomain,@"api/user/app/login"]
//app端用户登录二次校验接口,需上送登录信息、终端、终端识别信息和授权操作码
#define kAppApiAuth [NSString stringWithFormat:@"%@%@",kDomain,@"api/user/app/login/auth"]
//app端用户注册接口,需上送终端和终端识别信息
#define kAppApiReg [NSString stringWithFormat:@"%@%@",kDomain,@"api/user/app/reg"]
//判断手机号是否注册,true为可用 false为不可用
#define kAppApiCheck [NSString stringWithFormat:@"%@%@",kDomain,@"api/user/check"]
//app端用退出登录
#define kAppApiLogout [NSString stringWithFormat:@"%@%@",kDomain,@"api/user/app/logout"]
//app端用户微信授权登录接口
#define kAppApiWXogin [NSString stringWithFormat:@"%@%@",kDomain,@"api/user/app/wx/login"]

/*************************************************************/
//好物中心 商品模块菜单
#define kAppApiHomePageModuleMenu [NSString stringWithFormat:@"%@%@",kDomain,@"api/goods/module"]
//好物中心 商品列表
#define kAppApiHomePageList [NSString stringWithFormat:@"%@%@",kDomain,@"api/goods/list"]
//好物中心 商品详情
#define kAppApiGoodsDetail [NSString stringWithFormat:@"%@%@",kDomain,@"api/goods"]
//好物中心 最近的分销信息
#define kAppApiHomePageDistriRecent [NSString stringWithFormat:@"%@%@",kDomain,@"api/statistics/distribution/recent"]
//好物中心 统计平台整体信息
#define kAppApiHomePagePlatform [NSString stringWithFormat:@"%@%@",kDomain,@"api/statistics/platform"]
//好物中心 最近的使用用户列表接口
#define kAppApiiHomePageUserRecentList [NSString stringWithFormat:@"%@%@",kDomain,@"api/statistics/user/recent"]

/*************************************************************/
/**
 * 分销中心接口
 */
//分销商品列表
#define kAppApiDistributionList [NSString stringWithFormat:@"%@%@",kDomain,@"api/goods/distribution/list"]

//创建代销信息转发记录,返回代销信息
#define kAppApiDistributionForward [NSString stringWithFormat:@"%@%@",kDomain,@"api/goods/distribution/forward"]

//通过代销转发明细SN获取商品信息
#define kAppApiDistributionDetails [NSString stringWithFormat:@"%@%@",kDomain,@"api/goods/distribution/details/sn-sn"]

//某个分销商品的销售记录
#define kAppApiDistributionrecords [NSString stringWithFormat:@"%@%@",kDomain,@"api/goods/distribution/sn-sn/records"]

//通过代销记录SN获取商品信息
#define kAppApiDistribution [NSString stringWithFormat:@"%@%@",kDomain,@"api/goods/distribution/"]


#endif /* BHHttpConstant_h */









