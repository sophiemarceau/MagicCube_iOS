//
//  Profit.h
//  MagicCube
//
//  Created by wanmeizty on 3/1/19.
//  Copyright © 2019年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger , LineDirection) {
    LineDirectionShowNone = 0, //没有竖线
    LineDirectionShowUp,  //只有上竖线
    LineDirectionShowDown,//只有下竖线
    LineDirectionShowUpDown,  //有上下竖线
};

NS_ASSUME_NONNULL_BEGIN

@interface Profit : UIView
- (void)configRedtexts:(NSArray *)redtexts
                  text:(NSString *)text
                  line:(LineDirection)posision;
@end

NS_ASSUME_NONNULL_END
