
//
//  BHAppConfig.h
//  BitcoinHeadlines
//
//  Created by zhangyuanzhe on 2017/12/22.
//  Copyright © 2017年 zhangyuanzhe. All rights reserved.
//

#ifndef BHAppConfig_h
#define BHAppConfig_h

//友盟
#define UMENGKEY @"5a9615c5a40fa30df400000c"
//腾讯Bugly
#define BuglyAppId @"02d2f32836"
//微信开放平台开发
#define kWechatAppKey @"wx1e92fb8d6ea75ac2" //wechat appkey
//微信小程序ID
#define kWechatMiniAppKey @"gh_a262152021db"
//微信开放平台开发AppSecret
#define kWechatAppSecret @"c5b6fc7cc21fbfb5feee9361fbf03798"
/*公众号原始ID*/
#define kWechatPublicBTEID @"gh_969a4152b4a9"

#define knetEaseID @"9040bdc428034e98ae5fd0661ca03014"
#endif /* BHAppConfig_h */

#define AppStore
#ifdef AppStore
// App Store 极光推送
#define JPushKEY @"df5f3b4d318c6a14f532e45c"
#else
// 内侧应用的极光推送
//#define JPushKEY @"1239f0697204bba1e425abdb"
#endif
