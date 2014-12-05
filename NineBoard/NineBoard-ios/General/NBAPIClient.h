//
//  NBAPIClient.h
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/21/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"

@class NBGameObject;

@interface NBAPIClient : AFHTTPSessionManager

+ (NBAPIClient *)sharedAPIClient;


- (void)userLoggedInWithFacebookId:(NSString *)facebookId name:(NSString *)name success:(void (^)(NSString *userId))success failure:(void (^)(NSError *error))failure;
- (void)userLoggedOutWithFacebookId:(NSString *)facebookId success:(void (^)(NSString *userId))success failure:(void (^)(NSError *error))failure;

- (void)addNewGameWithOpponentFacebookId:(NSString *)facebookId success:(void (^)(NBGameObject *gameObject))success failure:(void (^)(NSError *error))failure;
- (void)getAllUserGamesWithSuccess:(void (^)(NSArray *myTurnGames, NSArray *opponentTurnGames, NSArray *recentOverGames))success failure:(void (^)(NSError *error))failure;

@end
