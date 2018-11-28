//
//  HomePageTableViewCell.h
//  MagicCube
//
//  Created by sophiemarceau_qu on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageTableViewCell : UITableViewCell
@property (strong,nonatomic) UIImageView * bgImageView;

- (void)configwidth:(NSDictionary *)dict;
+ (CGFloat)cellHeight;
@end

NS_ASSUME_NONNULL_END
