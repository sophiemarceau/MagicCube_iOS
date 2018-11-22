//
//  MagicRichTool.h
//  MagicCube
//
//  Created by wanmeizty on 22/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *const substrKey = @"substrKey";
static NSString *const subDictKey = @"subDictKey";
NS_ASSUME_NONNULL_BEGIN

@interface MagicRichTool : NSObject
+ (NSAttributedString *)initWithString:(NSString *)string substring:(NSString *)subString font:(UIFont *)font color:(UIColor *)color;

+ (NSAttributedString *)initWithString:(NSString *)str dict:(NSDictionary *)dict subString:(NSString *)subString;

+ (NSAttributedString *)initWithString:(NSString *)str attrbutes:(NSArray *)attributes;
@end

NS_ASSUME_NONNULL_END
