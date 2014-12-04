//
//  NBFacebookHelper.h
//  NineBoard-ios
//
//  Created by Daniel Ernst on 12/4/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface NBFacebookHelper : NSObject

+ (void)sessionStateChanged:(FBSession *)session state:(FBSessionState)state error:(NSError *)error;
+ (void)initiateLogin;
+ (void)logout;

@end
