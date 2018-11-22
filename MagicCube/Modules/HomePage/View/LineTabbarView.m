
//
//  LineTabbarView.m
//  MagicCube
//
//  Created by sophiemarceau_qu on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "LineTabbarView.h"

@implementation LineTabbarView

- (instancetype)initWithFrame:(CGRect)frame WithNameArray:(NSArray *)array{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = KBGCell;
        if(array.count > 0){
            CGFloat labelWidth = SCREEN_WIDTH / array.count;
            for (int i = 0 ; i< array.count ; i++ ) {
                UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
                tempButton.backgroundColor = [UIColor clearColor];
                tempButton.frame = CGRectMake(i *labelWidth , 0, labelWidth, frame.size.height);
                tempButton.tag = 1000+i;
                [tempButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:tempButton];
                
                UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i *labelWidth +(labelWidth - 45)/2, 14, 45, 45)];
                iconImageView.image = [UIImage imageNamed:[array[i] objectForKey:@"pic"]];
                iconImageView.layer.masksToBounds = YES;
                iconImageView.layer.cornerRadius = 45/2;
                [self addSubview:iconImageView];
                
                UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(i *labelWidth, iconImageView.bottom + 10, labelWidth, 14)];
                nameLabel.font = UIFontRegularOfSize(14);
                nameLabel.textColor = BlackMagicColor;
                nameLabel.text = [NSString stringWithFormat:@"%@",[array[i] objectForKey:@"name"]];
                nameLabel.textAlignment = NSTextAlignmentCenter;
                [self addSubview:nameLabel];
            }
        }
    }
    return self;
}

-(void)onClick:(UIButton *)sender{
    sender.enabled = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabbarDidSelect:)]) {
         [self.delegate tabbarDidSelect:sender.tag];
    }
    sender.enabled = YES;
}
@end
