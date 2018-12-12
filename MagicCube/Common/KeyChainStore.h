//
//  KeyChainStore.h
//  MagicCube
//
//  Created by sophiemarceau_qu on 2018/12/12.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyChainStore : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;

@end

NS_ASSUME_NONNULL_END
