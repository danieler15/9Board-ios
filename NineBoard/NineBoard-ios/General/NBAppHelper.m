//
//  NBAppHelper.m
//  NineBoard-ios
//
//  Created by Daniel Ernst on 12/4/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import "NBAppHelper.h"

@implementation NBAppHelper

+ (BOOL)userIsLoggedIn {
    return [self userId];
}
+ (void)setUserId:(NSString *)userId {
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:kKeyUserId];
}
+ (NSString *)userId {
    NSString *uid = [[NSUserDefaults standardUserDefaults] stringForKey:kKeyUserId];
    if (uid && ![uid isEqualToString:@""]) {
        return uid;
    }
    return nil;
}

+ (BOOL)userHasFacebook {
    return [self userFacebookId];
}
+ (void)setUserFacebookId:(NSString *)facebookId {
    [[NSUserDefaults standardUserDefaults] setObject:facebookId forKey:kKeyFacebookId];
}
+ (NSString *)userFacebookId {
    NSString *fid = [[NSUserDefaults standardUserDefaults] stringForKey:kKeyFacebookId];
    if (fid && ![fid isEqualToString:@""]) {
        return fid;
    }
    return nil;
}

+ (void)setUserName:(NSString *)userName {
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:kKeyUserName];
}
+ (NSString *)userName {
    return [[NSUserDefaults standardUserDefaults] stringForKey:kKeyUserName];
}

@end
