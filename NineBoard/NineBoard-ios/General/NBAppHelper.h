//
//  NBAppHelper.h
//  NineBoard-ios
//
//  Created by Daniel Ernst on 12/4/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBAppHelper : NSObject

@property (strong, nonatomic) NSArray *allGames;
@property (strong, nonatomic) NSArray *myTurnGames;
@property (strong, nonatomic) NSArray *opponentTurnGames;
@property (strong, nonatomic) NSArray *recentOverGames;

+ (NBAppHelper *)sharedHelper;


+ (BOOL)userIsLoggedIn;
+ (NSString *)userId;
+ (void)setUserId:(NSString *)userId;
+ (BOOL)userHasFacebook;
+ (NSString *)userFacebookId;
+ (void)setUserFacebookId:(NSString *)facebookId;
+ (NSString *)userName;
+ (void)setUserName:(NSString *)userName;

@end
