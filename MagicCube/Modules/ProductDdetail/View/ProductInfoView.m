//
//  ProductInfoView.m
//  MagicCube
//
//  Created by sophie on 2018/11/22.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "ProductInfoView.h"

@implementation ProductInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = KBGCell;
        [self addSubview:self.titleLabel];
        [self addSubview:self.bgImageView];
        
        [self addSubview:self.ideitifylImageView];
        [self addSubview:self.identifylLabel];
        [self addSubview:self.identifySubLabel];
        
        [self addSubview:self.productImageView];
        [self addSubview:self.proNameTitleLabel];
        [self addSubview:self.proNameSubLabel];
        
        [self addSubview:self.addressImageView];
        [self addSubview:self.proAddressLabel];
        [self addSubview:self.proConfirmLabel];
    }
    return self;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 18.5, SCREEN_WIDTH - 20, 16)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = BlackMagicColor;
        _titleLabel.font = UIFontRegularOfSize(16);
        _titleLabel.text = @"该产品信息已在蚂蚁金服区块链存证备查";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

-(UILabel *)identifylLabel{
    if (_identifylLabel == nil) {
        _identifylLabel = [self createlabel1frame:CGRectMake(116, 63.5, 259-10, 14)];
        _identifylLabel.text = @"本产品已通过防伪认证";
    }
    return _identifylLabel;
}

-(UILabel *)identifySubLabel{
    if (_identifySubLabel == nil) {
        _identifySubLabel = [self createlabel2frame:CGRectMake(116, 83.5, 259-10, 9)];
         _identifySubLabel.text = @"由魔方区块链数字签名确认";
    }
    return _identifySubLabel;
}

-(UILabel *)proNameTitleLabel{
    if (_proNameTitleLabel == nil) {
        _proNameTitleLabel = [self createlabel1frame:CGRectMake(116, 109.5, 259-10, 32)];
        _proNameTitleLabel.numberOfLines = 2;
        _proNameTitleLabel.text = @"本产品生产商为\nMoet Hennessy Louis Vuitton";
    }
    return _proNameTitleLabel;
}

-(UILabel *)proNameSubLabel{
    if (_proNameSubLabel == nil) {
        _proNameSubLabel = [self createlabel2frame:CGRectMake(116, 146.5, 259-10, 30)];
        _proNameSubLabel.numberOfLines = 2;
        _proNameSubLabel.text = @"由路易威登（中国）商业销售有限公司数字签名确认";
    }
    return _proNameSubLabel;
}

-(UILabel *)proAddressLabel{
    if (_proAddressLabel == nil) {
        _proAddressLabel = [self createlabel1frame:CGRectMake(116, 194.5, 259-10, 14)];
         _proAddressLabel.text = @"本产品产地为法国";
    }
    return _proAddressLabel;
}

-(UILabel *)proConfirmLabel{
    if (_proConfirmLabel == nil) {
        _proConfirmLabel = [self createlabel2frame:CGRectMake(116, 213.5, 259-10, 9)];
         _proConfirmLabel.text = @"由VECHAIN数字签名确认";
    }
    return _proConfirmLabel;
}

-(UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [self createImageViewframe:CGRectMake(66, 7, 244, 244) WithImageName:@"fangweituan"];
    }
    return _bgImageView;
}

-(UIImageView *)ideitifylImageView{
    if (_ideitifylImageView == nil) {
        _ideitifylImageView = [self createImageViewframe:CGRectMake(78, 63.5, 30, 32) WithImageName:@"fangwei"];
    }
    return _ideitifylImageView;
}

-(UIImageView *)productImageView{
    if (_productImageView == nil) {
        _productImageView = [self createImageViewframe:CGRectMake(78, 110, 30, 32) WithImageName:@"changshang"];
    }
    return _productImageView;
}

-(UIImageView *)addressImageView{
    if (_addressImageView == nil) {
        _addressImageView = [self createImageViewframe:CGRectMake(78, 192.5, 30, 32) WithImageName:@"chandi"];
    }
    return _addressImageView;
}

- (UILabel *)createlabel1frame:(CGRect)frame{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = Gray7F7Color;
    label.font = UIFontRegularOfSize(14);
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

- (UILabel *)createlabel2frame:(CGRect)frame{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = Gray948Color;
    label.font = UIFontRegularOfSize(9);
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

- (UIImageView *)createImageViewframe:(CGRect)frame WithImageName:(NSString *)imageNameStr{
    UIImageView * tempImageView = [[UIImageView alloc] initWithFrame:frame];
    tempImageView.image = [UIImage imageNamed:imageNameStr];
    return tempImageView;
}
@end
