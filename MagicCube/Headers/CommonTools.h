//
//  CommonTools.h
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#ifndef CommonTools_h
#define CommonTools_h

// MARK: 系统相关
#define IS_IOS_7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)
#define IS_IOS_8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO)
#define IS_IOS_9 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? YES : NO)
#define IS_IOS_10 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) ? YES : NO)

/* NSLog */
#if DEBUG
#define NSLog(s,...) NSLog(@"%s LINE:%d < %@ >",__FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define NSLog(...) {}
#endif

/* safe release */
#undef SAFE_RELEASE
#define SAFE_RELEASE(__REF) \
{\
if (nil != (__REF)) \
{\
CFRelease(__REF); \
__REF = nil;\
}\
}

//格式化字符串 如果字符串为@"<null>" 或 NSNull类型 或者nil，会返回 @""
#define stringFormat(string) (string == nil)?@"":[@"<null>" isEqualToString:[NSString stringWithFormat:@"%@",string]]?@"":[NSString stringWithFormat:@"%@",string]
#define BH_StringFormat(object) [NSString stringWithFormat:@"%@",object]

//非空判断 宏
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || [(_ref) isEqual:@"(null)"])
//字符串是否为空
#define STRISEMPTY(str) (str==nil || [str isEqual:[NSNull null]] || [str isEqualToString:@""])
/// block安全使用之宏定义
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

//weakSelf 宏定义
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//数据返回结果是字典
#define IsSafeDictionary(_ref)   [_ref isKindOfClass:[NSDictionary class]]

//数据返回结果是数组
#define IsSafeArray(_ref)        [_ref isKindOfClass:[NSArray class]]
//app版本相关
#define kCurrentVersion [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]
#define kAPPNAME [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleDisplayName"]
//system version
#define kIOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define DOCUMENT_DIRECTORY_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]



/* BHUserDefault*/
#define BHUserDefaults [NSUserDefaults standardUserDefaults]
//加载动画
#define NMShowLoadIng  [Tools imageWithImage]
//删除动画
#define NMRemovLoadIng [Tools removeLoadingView]
#endif /* CommonTools_h */
