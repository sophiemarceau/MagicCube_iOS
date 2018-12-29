//
//  MagicShareView.h
//  MagicCube
//
//  Created by wanmeizty on 29/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, UMSHAREPic_TYPE)
{
    UMSHAREPic_TYPE_TEXT,
    UMSHAREPic_TYPE_IMAGE,
    UMSHAREPic_TYPE_IMAGE_URL,
    UMSHAREPic_TYPE_TEXT_IMAGE,
    UMSHAREPic_TYPE_WEB_LINK,
};
@interface MagicShareView : UIView

@end

NS_ASSUME_NONNULL_END
