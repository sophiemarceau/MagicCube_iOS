//
//  AdaptDevice.h
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#ifndef AdaptDevice_h
#define AdaptDevice_h

// MARK: 设备设配相关
//判断是否是ipad
#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)
//判断是否是手机
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE4 [[UIScreen mainScreen] bounds].size.height == 480.0
#define IS_IPHONE5 [[UIScreen mainScreen] bounds].size.height == 568.0
#define IS_IPHONE6 [[UIScreen mainScreen] bounds].size.height == 667.0
#define IS_IPHONE6PLUS [[UIScreen mainScreen] bounds].size.height == 736.0
#define IS_IPHONEX (([[UIScreen mainScreen] bounds].size.height-812)?NO:YES)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !IS_PAD : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_PAD : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !IS_PAD : NO)
// MARK: 屏幕尺寸相关
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
// MARK: 导航栏高度
#define NAVIGATION_HEIGHT  ((IS_IPHONEX==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 88.0 : 64.0)
// MARK: Tabbar栏高度
#define TAB_BAR_HEIGHT ((IS_IPHONEX==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 83.0 : 49.0)
// MARK: 手机状态栏高度
#define STATUS_BAR_HEIGHT ((IS_IPHONEX==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 44.0 : 20.0)
//MARK: 底部栏高度 indicator
#define HOME_INDICATOR_HEIGHT (IS_IPHONEX ? 34.f : 0.f)
#define LBMagin (IS_IPHONEX ? 20.f : 10.f)
#define SCALE_W(x) (x*(SCREEN_WIDTH/375.0))
#define SCALE_H(y) (y*(SCREEN_WIDTH/667.0))

#define pageMenuH 42

#define scrollViewHeight SCREEN_HEIGHT - NAVIGATION_HEIGHT - pageMenuH -TAB_BAR_HEIGHT

#endif /* AdaptDevice_h */
