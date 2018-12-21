//
//  InviteTableViewCell.m
//  MagicCube
//
//  Created by wanmeizty on 21/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "InviteTableViewCell.h"

@interface InviteTableViewCell ()
@property (strong,nonatomic) MagicLabel * leftLabel;
@property (strong,nonatomic) MagicLabel * rightLabel;
@end
@implementation InviteTableViewCell

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
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat cellHeight = [InviteTableViewCell cellHeight];
    self.rightLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.5, 0, self.frame.size.width * 0.5 - SCALE_W(27), cellHeight)];
    self.rightLabel.textColor = Black626A75Color;
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    self.rightLabel.font = UIFontRegularOfSize(12);
    [self.contentView addSubview:self.rightLabel];
    
    self.leftLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(27), 0, self.frame.size.width * 0.5 - SCALE_W(27), cellHeight)];
    self.leftLabel.textColor = Black626A75Color;
    self.leftLabel.font = UIFontRegularOfSize(12);
    [self.contentView addSubview:self.leftLabel];
}

+ (CGFloat)cellHeight{
    return SCALE_W(34);
}
- (void)configDict:(NSDictionary *)dict{
    self.leftLabel.text = @"188****7902";
    self.rightLabel.text = @"2018/01/20  12:20:45";
}


@end
