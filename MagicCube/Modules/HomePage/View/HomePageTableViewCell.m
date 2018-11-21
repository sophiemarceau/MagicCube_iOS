//
//  HomePageTableViewCell.m
//  MagicCube
//
//  Created by sophiemarceau_qu on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "HomePageTableViewCell.h"
@interface HomePageTableViewCell ()

@property (strong,nonatomic) UIView * bgView;
@property (strong,nonatomic) UIImageView * picImageView;
@property (strong,nonatomic) UILabel* titleLabel;
@property (strong,nonatomic) UILabel * priceLabel;
@property (strong,nonatomic) UILabel * numLabel;
@property (strong,nonatomic) UILabel * redBgLabel;
@end
@implementation HomePageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview: self.bgView];
        [self.bgView addSubview:self.picImageView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.priceLabel];
        [self.bgView addSubview:self.numLabel];
        [self.bgView addSubview:self.redBgLabel];
    }
    return self;
}

- (void)configwidth:(NSDictionary *)dict{
    
}

+ (CGFloat)cellHeight{
    return 255;
}

-(UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(16, 5, SCREEN_WIDTH -32, 250)];
        _bgView.backgroundColor = [UIColor brownColor];
    }
    return _bgView;
}

-(UIImageView *)picImageView{
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bgView.width, 150)];
        _picImageView.backgroundColor = [UIColor greenColor];
    }
    return _picImageView;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, self.picImageView.height +10, self.bgView.width -32, 45)];
        _titleLabel.backgroundColor = [UIColor yellowColor];
        _titleLabel.textColor = BlackMagicColor;
        _titleLabel.font = UIFontRegularOfSize(15);
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = @"【商品名称】AirJordan 工坊是品牌的灵魂AirJordan 工坊是品牌的灵魂";
    }
    return _titleLabel;
}

-(UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, self.titleLabel.bottom +10, (self.bgView.width -32)/2, 18)];
        _priceLabel.backgroundColor = [UIColor yellowColor];
        _priceLabel.textColor = GrayMagicColor;
        _priceLabel.font = UIFontRegularOfSize(15);
        _priceLabel.text = @"￥588零售指导价";
    }
    return _priceLabel;
}


-(UILabel *)numLabel{
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, self.priceLabel.bottom , (self.bgView.width -32)/2, 18)];
        _numLabel.backgroundColor = [UIColor yellowColor];
        _numLabel.textColor = GrayMagicColor;
        _numLabel.font = UIFontRegularOfSize(15);
        _numLabel.text = @"已经出售99323个";
    }
    return _numLabel;
}


-(UILabel *)redBgLabel{
    if (_redBgLabel == nil) {
        _redBgLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bgView.width - 114 -16, self.bgView.height - 30 -10 , 114, 30)];
        _redBgLabel.backgroundColor = [UIColor yellowColor];
        _redBgLabel.backgroundColor = RedMagicColor;
        _redBgLabel.textColor = [UIColor whiteColor];
        _redBgLabel.textAlignment = NSTextAlignmentCenter;
        _redBgLabel.font = UIFontRegularOfSize(15);
        _redBgLabel.text = @"代理价低至3折";
        _redBgLabel.layer.masksToBounds = YES;
        _redBgLabel.layer.cornerRadius = 3;
    }
    return _redBgLabel;
}
@end
