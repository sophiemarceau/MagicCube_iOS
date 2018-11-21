//
//  LineTabbarView.h
//  MagicCube
//
//  Created by sophiemarceau_qu on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LineTabbarSelectDelegate <NSObject>
-(void)tabbarDidSelect:(NSInteger)number;
@end
@interface LineTabbarView : UIView
@property (weak, nonatomic) id<LineTabbarSelectDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame WithNameArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
