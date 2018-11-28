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
        UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, 0.5)];
        lineview.backgroundColor = LineGrayColor;
        [self addSubview:lineview];
        
        [self addSubview:self.bgImageView];
        
        [self addSubview:self.ideitifylImageView];
        [self addSubview:self.identifylLabel];
        [self addSubview:self.identifySubLabel];
        
        [self addSubview:self.productImageView];
        [self addSubview:self.proNameTitleLabel];
//        [self addSubview:self.proNameLabel];
        [self addSubview:self.proNameSubLabel];
        
        [self addSubview:self.addressImageView];
        [self addSubview:self.proAddressLabel];
        [self addSubview:self.proConfirmLabel];
    }
    return self;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 16, SCREEN_WIDTH - 20, 14)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = BlackMagicColor;
        _titleLabel.font = UIFontRegularOfSize(14);
        _titleLabel.text = @"商品卡信息";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

-(UILabel *)identifylLabel{
    if (_identifylLabel == nil) {
        _identifylLabel = [self createlabel1frame:CGRectMake(49.5, 59, SCREEN_WIDTH-49.5, 12)];
        _identifylLabel.text = @"本卡产品认证生产商为厦门燕之屋生物工程发展有限公司";
    }
    return _identifylLabel;
}

-(UILabel *)identifySubLabel{
    if (_identifySubLabel == nil) {
        _identifySubLabel = [self createlabel2frame:CGRectMake(15, 80.5, SCREEN_WIDTH-30, 9)];
         _identifySubLabel.text = @"由厦门燕之屋生物工程发展有限公司数字签名确认";
    }
    return _identifySubLabel;
}

-(UILabel *)proNameTitleLabel{
    if (_proNameTitleLabel == nil) {
        _proNameTitleLabel = [self createlabel1frame:CGRectMake(49.5, 104.5, SCREEN_WIDTH-49.5, 12)];
        _proNameTitleLabel.text = @"本卡产品认证发货商为厦门燕之屋生物工程发展有限公司";
    }
    return _proNameTitleLabel;
}
//
//-(UILabel *)proNameLabel{
//    if (_proNameLabel == nil) {
//        _proNameLabel = [self createlabel1frame:CGRectMake(116, self.proNameTitleLabel.bottom, 259, 14)];
//        _proNameLabel.text = @"Moet Hennessy Louis Vuitton";
//    }
//    return _proNameLabel;
//}
//
-(UILabel *)proNameSubLabel{
    if (_proNameSubLabel == nil) {
        _proNameSubLabel = [self createlabel2frame:CGRectMake(15, 126, SCREEN_WIDTH-30, 9)];
        _proNameSubLabel.text = @"由厦门燕之屋生物工程发展有限公司数字签名确认";
    }
    return _proNameSubLabel;
}

-(UILabel *)proAddressLabel{
    if (_proAddressLabel == nil) {
        _proAddressLabel = [self createlabel1frame:CGRectMake(49.5, 149.5,  216, 12)];
        _proAddressLabel.text = @"本卡信息已在蚂蚁金服区块链存证备查";
    }
    return _proAddressLabel;
}

-(UILabel *)proConfirmLabel{
    if (_proConfirmLabel == nil) {
        _proConfirmLabel = [self createlabel2frame:CGRectMake(self.proAddressLabel.right, 146.5, 80, 16)];
         _proConfirmLabel.text = @"查看数字签名";
        _proConfirmLabel.font = UIFontRegularOfSize(10);
        _proConfirmLabel.textColor = Gray666Color;
        _proConfirmLabel.textAlignment = NSTextAlignmentCenter;
        _proConfirmLabel.layer.masksToBounds = YES;
        _proConfirmLabel.layer.borderWidth = 0.5;
        _proConfirmLabel.layer.borderColor = Gray666Color.CGColor;
        _proConfirmLabel.layer.cornerRadius = 2;
    }
    return _proConfirmLabel;
}

-(UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [self createImageViewframe:CGRectMake((SCREEN_WIDTH -120)/2, 52.5, 120, 120) WithImageName:@"fangweituan"];
    }
    return _bgImageView;
}

-(UIImageView *)ideitifylImageView{
    if (_ideitifylImageView == nil) {
        _ideitifylImageView = [self createImageViewframe:CGRectMake(22, 146, 21, 24) WithImageName:@"fangwei"];
    }
    return _ideitifylImageView;
}

-(UIImageView *)productImageView{
    if (_productImageView == nil) {
        _productImageView = [self createImageViewframe:CGRectMake(22, 53.5, 21, 24) WithImageName:@"changshang"];
    }
    return _productImageView;
}

-(UIImageView *)addressImageView{
    if (_addressImageView == nil) {
        _addressImageView = [self createImageViewframe:CGRectMake(22, 100,21, 24) WithImageName:@"huoyuan"];
    }
    return _addressImageView;
}

- (UILabel *)createlabel1frame:(CGRect)frame{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = Gray7F7Color;
    label.font = UIFontRegularOfSize(12);
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

//- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
//    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
//    detailLabel.font = UIFontRegularOfSize(fontSize);
//    detailLabel.text = value;
//    detailLabel.numberOfLines = 0;
//    CGSize deSize = [detailLabel sizeThatFits:CGSizeMake(width,1)];
//    return deSize.height;
//}

@end
