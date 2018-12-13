//
//  UserObject.m
//  MagicCube
//
//  Created by sophie on 2018/12/12.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "UserObject.h"

#define LOGIN_DATA_KEY @"Magic_LOGIN_KEY"

static UserObject * info = nil;

@implementation UserObject

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self getInfo];
        if (!info) {
            info = [UserObject new];
//            info.isLogin = NO;
        }else {
//            info.isLogin = YES;
        }
        
    });
    return info;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [super allocWithZone:zone];
    });
    return info;
}
- (id)copyWithZone:(NSZone *)zone {
    return [UserObject shareInstance];
}

-(void)removeLoginData {
    info = [UserObject new];
    info.token = nil;
//    _isLogin = NO;
    [self remove];
}

- (void)save {
//    NSMutableDictionary *dic = [self yy_modelToJSONObject];
    NSMutableDictionary *dic
    = @{}.mutableCopy;
    [dic setObject:_token forKey:@"token"];
    NSLog(@"---save--responseObject--->%@",dic);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dic forKey:LOGIN_DATA_KEY];
    [userDefaults synchronize];
//    _isLogin = YES;
}

+ (void)getInfo {
    info = (UserObject *)[UserObject yy_modelWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:LOGIN_DATA_KEY]];
//    info.isFutureDogUser = [[[NSUserDefaults standardUserDefaults] objectForKey:KisFutureDogUser] boolValue];
//    info.futureDogGoal = [[[NSUserDefaults standardUserDefaults] objectForKey:KisFutureDogUserGoal] integerValue];
}

- (void)remove {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:LOGIN_DATA_KEY];
    [userDefaults synchronize];
}
@end
