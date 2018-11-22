//
//  MemberView.h
//  MagicCube
//
//  Created by sophie on 2018/11/22.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemberView : UIView
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *updateMemBtn;
@property(nonatomic,strong)UILabel *normalLabel;
@property(nonatomic,strong)UILabel *goldLabel;
@property(nonatomic,strong)UILabel *siverLabel;
@property(nonatomic,strong)UILabel *diamondLabel;
@property(nonatomic,strong)UIImageView *normalImageView;
@property(nonatomic,strong)UIImageView *goldImageView;
@property(nonatomic,strong)UIImageView *siverImageView;
@property(nonatomic,strong)UIImageView *diamondImageView;
@end

NS_ASSUME_NONNULL_END
