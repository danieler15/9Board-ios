//
//  NBAppHelper.h
//  NineBoard-ios
//
//  Created by Daniel Ernst on 12/4/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBAppHelper : NSObject

+ (BOOL)userIsLoggedIn;
+ (NSString *)userId;
+ (void)setUserId:(NSString *)userId;
+ (BOOL)userHasFacebook;
+ (NSString *)userFacebookId;
+ (void)setUserFacebookId:(NSString *)facebookId;
+ (NSString *)userName;
+ (void)setUserName:(NSString *)userName;

@end
