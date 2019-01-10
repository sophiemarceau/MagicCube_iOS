//
//  UserObject.h
//  MagicCube
//
//  Created by sophie on 2018/12/12.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface UserObject : NSObject

@property (nonatomic, copy) NSString *token;
@property (copy,nonatomic) NSString * nickName;
#pragma mark - methods
+ (instancetype)shareInstance;
//删除登录数据
- (void)removeLoginData;
//保存登录数据
- (void)save;
@end

//NS_ASSUME_NONNULL_END
