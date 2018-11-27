//
//  YXIgnoreHeaderTouchTableView.m
//  MagicCube
//
//  Created by sophiemarceau_qu on 2018/11/28.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "YXIgnoreHeaderTouchTableView.h"

@implementation YXIgnoreHeaderTouchTableView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.tableHeaderView && CGRectContainsPoint(self.tableHeaderView.frame, point)) {
        return NO;
    }
    return [super pointInside:point withEvent:event];
}

@end
