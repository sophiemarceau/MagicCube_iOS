
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
        self.backgroundColor = KBGCell;
        if(array.count > 0){
            CGFloat labelWidth = SCREEN_WIDTH / array.count;
            for (int i = 0 ; i< array.count ; i++ ) {
                UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i *labelWidth +(labelWidth - 40)/2, 0, 40, 40)];
                iconImageView.backgroundColor = [UIColor redColor];
                iconImageView.layer.masksToBounds = YES;
                iconImageView.layer.cornerRadius = 20;
                [self addSubview:iconImageView];
                UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(i *labelWidth, iconImageView.height +10, labelWidth, 12)];
                nameLabel.font = UIFontRegularOfSize(12);
                nameLabel.textColor = BlackMagicColor;
                nameLabel.text = [NSString stringWithFormat:@"%@",[array[i] objectForKey:@"name"]];
                nameLabel.textAlignment = NSTextAlignmentCenter;
                [self addSubview:nameLabel];
            }
        }
    }
    return self;
}


@end
