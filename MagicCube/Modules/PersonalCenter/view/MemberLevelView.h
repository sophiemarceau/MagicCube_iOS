//
//  MemberLevelView.h
//  MagicCube
//
//  Created by wanmeizty on 28/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger , LineLRPosition) {
    LinePositionShowNone = 0, //没有竖线
    LinePositionShowLeft,  //只有左竖线
    LinePositionShowRight,//只有右竖线
    LinePositionShowLeftRight,  //有左右竖线
};
NS_ASSUME_NONNULL_BEGIN

@interface MemberLevelView : UIView
- (instancetype)initWithFrame:(CGRect)frame imgW:(CGFloat)width;
- (void)configView:(NSString *)imgName levelText:(NSString *)levelStr LineLRPosition:(LineLRPosition)pos;
@end

NS_ASSUME_NONNULL_END
