//
//  DistributeLevelView.h
//  MagicCube
//
//  Created by wanmeizty on 28/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , LinePosition) {
    LinePositionShowNone = 0, //没有竖线
    LinePositionShowUp,  //只有上竖线
    LinePositionShowDown,//只有下竖线
    LinePositionShowUpDown,  //有上下竖线
};
NS_ASSUME_NONNULL_BEGIN

@protocol gradeUpDelegate <NSObject>

- (void)gradeUp;
- (void)gradeUpLevel:(NSInteger)level;

@end

@interface DistributeLevelView : UIView
@property (weak,nonatomic) id<gradeUpDelegate>delegate;
- (void)configTextRed:(BOOL)isred
                level:(NSString *)level
                price:(CGFloat)price
             discount:(NSString *)discount
                grade:(BOOL)isgreaded
            gradeText:(NSString *)gradetext
                 line:(LinePosition)posision;
@end

NS_ASSUME_NONNULL_END
