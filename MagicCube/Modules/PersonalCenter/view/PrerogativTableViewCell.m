//
//  PrerogativTableViewCell.m
//  MagicCube
//
//  Created by wanmeizty on 23/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "PrerogativTableViewCell.h"

@interface PrerogativTableViewCell ()
@property (strong,nonatomic) MagicLabel * nameLabel;
@property (strong,nonatomic) MagicLabel * descLabel;
@property (strong,nonatomic) MagicLabel * periodLabel;
@property (strong,nonatomic) RedButton * buyBtn;
@end

@implementation PrerogativTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        CGFloat cellHeight = [PrerogativTableViewCell cellHeight];
        
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.descLabel];
        [self.contentView addSubview:self.periodLabel];
        [self.contentView addSubview:self.buyBtn];
        
        MagicLineView * lineView = [MagicLineView initFame:CGRectMake(10, cellHeight - 0.5, SCREEN_WIDTH - 20, 0.5)];
        [self.contentView addSubview:lineView];
        
    }
    return self;
}

- (void)configDict:(NSDictionary *)dict{
    
    self.nameLabel.text = @"分红翻倍";
    self.descLabel.text = @"购买后您的每日分红将翻倍";
    self.periodLabel.text = @"298/周";
}

- (MagicLabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [MagicLabel initWithFrame:CGRectMake(10, 20, 207, 16)];
        _nameLabel.font = UIFontRegularOfSize(16);
        _nameLabel.textColor = Gray666Color;
    }
    return _nameLabel;
}

-(MagicLabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [MagicLabel initWithFrame:CGRectMake(10, 46, 207, 14)];
    }
    return _descLabel;
}

-(MagicLabel *)periodLabel{
    if (!_periodLabel) {
        _periodLabel = [MagicLabel initWithFrame:CGRectMake(SCALE_W(217), 32, 60, 16)];
        _periodLabel.textColor = Gray666Color;
        _periodLabel.font = UIFontRegularOfSize(16);
    }
    return _periodLabel;
}

- (RedButton *)buyBtn{
    if (!_buyBtn) {
        _buyBtn = [[RedButton alloc] initWithFrame:CGRectMake(SCALE_W(298), 25, SCALE_W(64), 30)];
        [_buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    }
    return _buyBtn;
}

+ (CGFloat)cellHeight{
    return 80;
}
@end
