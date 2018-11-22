//
//  ColorOrFontConstants.h
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#ifndef ColorOrFontConstants_h
#define ColorOrFontConstants_h
// MARK: 颜色相关
#define COLOR_RGB(r,g,b) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1]
#define COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:a]
#define BHHexColor(colorString) [BHHexColor hexColor:colorString]
#define BHHexColorAlpha(colorString,a) [BHHexColor hexColor:colorString alpha:a]
#define kColorRgb(r,g,b)               [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1]
#define kColorRgba(r,g,b,a)            [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:a]

// MARK: App中主要常用颜色相关
#define BHColorWhite        [UIColor whiteColor]
/* App导航条颜色*/
#define BHColornavigationBar         [BHHexColor navigationBarColor]
//App中主红色
#define RedMagicColor BHHexColor(@"E02E24")
//App中 字体主黑色
#define BlackMagicColor BHHexColor(@"333333")
//App中 字体主灰色
#define GrayMagicColor BHHexColor(@"999999")
//View 背景色
#define KBGColor BHHexColor(@"F4F4F4")
//View 常用背景色
#define KBGCell BHHexColor(@"FFFFFF")
//分割线 常用色
#define LineGrayColor BHHexColor(@"D6DAE2")
// MARK: App中主要常用字体Font相关 
#define FontName [UIFont systemFontOfSize:[UIFont systemFontSize]].fontName // 系统字体
#define  KfontNormal(a) [UIFont fontWithName:FontName size:(a)]
#define UIFontLightOfSize(fontSize)  (IS_IOS_9 ? [UIFont fontWithName:@"PingFangSC-Light" size:fontSize] : [UIFont systemFontOfSize:fontSize])
#define UIFontRegularOfSize(fontSize)  (IS_IOS_9 ? [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize] : [UIFont systemFontOfSize:fontSize])
#define UIFontMediumOfSize(fontSize)  (IS_IOS_9 ? [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize] : [UIFont systemFontOfSize:fontSize])
#define UIFontSemiboldOfSize(fontSize)  (IS_IOS_9 ? [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize] : [UIFont systemFontOfSize:fontSize])
#define UIFontDINAlternateOfSize(fontSize)  (IS_IOS_9 ? [UIFont fontWithName:@"DINAlternate-Bold" size:fontSize] : [UIFont systemFontOfSize:fontSize])
#define UIFontSemiboldOfSize(fontSize)  (IS_IOS_9 ? [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize] : [UIFont systemFontOfSize:fontSize])

#endif /* ColorOrFontConstants_h */
