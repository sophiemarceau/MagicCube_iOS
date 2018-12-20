
//
//  HisstoryTableViewCell.m
//  MagicCube
//
//  Created by sophie on 2018/11/22.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "HisstoryTableViewCell.h"
@interface HisstoryTableViewCell ()

@property (strong,nonatomic) UIView *lineView;
@property (strong,nonatomic) UILabel *nameLabel;
@property (strong,nonatomic) UILabel *priceLabel;
@property (strong,nonatomic) UILabel *timeLabel;
@end
@implementation HisstoryTableViewCell

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
        self.contentView.backgroundColor = KBGCell;
        [self.contentView addSubview: self.lineView];
        [self.contentView addSubview:self.nameLabel];
//        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.timeLabel];
    }
    return self;
}

- (void)configwidth:(NSDictionary *)dict{
    self.nameLabel.text = stringFormat([dict objectForKey:@"date"]);
    self.timeLabel.text = [NSString stringWithFormat:@"¥%@",stringFormat([dict objectForKey:@"income"])];
}

+ (CGFloat)cellHeight{
    return 1 + 42 ;
}

-(UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        _lineView.backgroundColor = LineGrayColor;
    }
    return _lineView;
}

-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [self createlabelframe:CGRectMake(20, 0, 70, 46)];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

-(UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [self createlabelframe:CGRectMake(SCREEN_WIDTH - 80 - 149.5, 0, 80, 46)];
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
}

-(UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [self createlabelframe:CGRectMake(SCREEN_WIDTH - 80 - 20 , 0, 80, 46)];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = UIFontRegularOfSize(16);
    }
    return _timeLabel;
}

- (UILabel *)createlabelframe:(CGRect)frame{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = Gray666Color;
    label.font = UIFontRegularOfSize(14);
    return label;
}
@end
