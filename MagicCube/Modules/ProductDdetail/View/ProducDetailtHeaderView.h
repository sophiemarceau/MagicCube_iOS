//
//  ProducDetailtHeaderView.h
//  MagicCube
//
//  Created by sophie on 2018/11/22.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProducDetailtHeaderView : UIView
@property (strong,nonatomic) UIView * bgView,*redBgView;
@property (strong,nonatomic) UIImageView * picImageView;
@property (strong,nonatomic) UILabel* titleLabel;
@property (strong,nonatomic) UILabel * priceLabel;
@property (strong,nonatomic) UILabel * numLabel;
@property (strong,nonatomic) UILabel * redBgLabel;

- (void)configwidth:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
