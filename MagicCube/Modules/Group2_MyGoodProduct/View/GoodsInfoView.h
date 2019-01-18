//
//  GoodsInfoView.h
//  MagicCube
//
//  Created by wanmeizty on 20/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LookCodeDelegate <NSObject>

-(void)lookCode;

@end
@interface GoodsInfoView : UIView
@property (weak,nonatomic) id <LookCodeDelegate>delegate;
- (void)setUPdata:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
