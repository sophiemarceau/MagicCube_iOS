//
//  MagicRichTool.m
//  MagicCube
//
//  Created by wanmeizty on 22/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "MagicRichTool.h"

@implementation MagicRichTool
+ (NSAttributedString *)initWithString:(NSString *)string substring:(NSString *)subString font:(UIFont *)font color:(UIColor *)color{
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [string rangeOfString:subString];
    [attributeString addAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:RedMagicColor} range:range];
    return attributeString;
}

+ (NSAttributedString *)initWithString:(NSString *)str dict:(NSDictionary *)dict subString:(NSString *)subString{
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = [str rangeOfString:subString];
    [attributeString addAttributes:dict range:range];
    return attributeString;
}

+ (NSAttributedString *)initWithString:(NSString *)str attrbutes:(NSArray *)attributes{
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc] initWithString:str];
    for (NSDictionary * dict in attributes) {
        NSString * subString = [dict objectForKey:substrKey];
        NSDictionary * subDict = [dict objectForKey:subDictKey];
        NSRange range = [str rangeOfString:subString];
        [attributeString addAttributes:subDict range:range];
    }
    return attributeString;
}


+ (NSAttributedString *)initWithString:(NSString *)str dict:(NSDictionary *)dict subStringArray:(NSArray *)subStringArray{
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc] initWithString:str];
    for (NSString *subString in subStringArray) {
        NSRange range = [str rangeOfString:subString];
        [attributeString addAttributes:dict range:range];
        str = [self replaceStr:str subString:subString];
    }
    return attributeString;
}

+(NSString *)replaceStr:(NSString *)string subString:(NSString *)subString{
    NSRange range = [string rangeOfString:subString];
    NSMutableString * mutString = [NSMutableString stringWithString:string];
    for (NSInteger i = range.location; i <range.length; i++) {
        [mutString replaceCharactersInRange:NSMakeRange(i, 1) withString:@"#"];
    }
    return mutString;
}
@end
