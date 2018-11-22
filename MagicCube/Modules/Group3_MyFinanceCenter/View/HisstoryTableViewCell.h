//
//  HisstoryTableViewCell.h
//  MagicCube
//
//  Created by sophie on 2018/11/22.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HisstoryTableViewCell : UITableViewCell
- (void)configwidth:(NSDictionary *)dict;
+ (CGFloat)cellHeight;
@end

NS_ASSUME_NONNULL_END
