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
static NSString * const kHeader = @"https://m.bte.top/";
#define TimeString 7 * 24 * 3600
#else
//测试环境
static NSString * const kHeader = @"https://l.bte.top/";
#define TimeString 7
#endif

// h5入口地址 合伙人
#define kAppPartnerAddress [NSString stringWithFormat:@"%@%@",kHeader,@"ad/partner"]






#endif /* BHHttpConstant_h */









