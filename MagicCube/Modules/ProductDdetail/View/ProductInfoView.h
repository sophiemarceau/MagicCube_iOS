//
//  ProductInfoView.h
//  MagicCube
//
//  Created by sophie on 2018/11/22.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductInfoView : UIView
@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *identifylLabel;
@property(nonatomic,strong)UILabel *identifySubLabel;
@property(nonatomic,strong)UILabel *proNameTitleLabel;
@property(nonatomic,strong)UILabel *proNameSubLabel;
@property(nonatomic,strong)UILabel *proAddressLabel;
@property(nonatomic,strong)UILabel *proConfirmLabel;
@property(nonatomic,strong)UIImageView *ideitifylImageView;
@property(nonatomic,strong)UIImageView *productImageView;
@property(nonatomic,strong)UIImageView *addressImageView;
@property(nonatomic,strong)UIImageView *bgImageView;

@end

NS_ASSUME_NONNULL_END
