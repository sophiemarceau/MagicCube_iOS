//
//  YXIgnoreHeaderTouchAndRecognizeSimultaneousTableView.m
//  MagicCube
//
//  Created by sophiemarceau_qu on 2018/11/28.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "YXIgnoreHeaderTouchAndRecognizeSimultaneousTableView.h"

@implementation YXIgnoreHeaderTouchAndRecognizeSimultaneousTableView


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end
