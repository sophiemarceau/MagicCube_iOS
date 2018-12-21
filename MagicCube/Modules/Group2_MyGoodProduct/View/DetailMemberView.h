//
//  DetailMemberView.h
//  MagicCube
//
//  Created by wanmeizty on 19/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DistributeLevelView.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailMemberView : UIView
@property (weak,nonatomic) id<gradeUpDelegate>gradeDelegate;
-(void)setUpdata:(NSArray *)array;
-(void)setUpdata:(NSArray *)array currentUserMemberLevel:(NSInteger)currentUserMemberLevel;
@end

NS_ASSUME_NONNULL_END
