//
//  NBAPIClient.m
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/21/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import "NBAPIClient.h"

#import "NBGameObject.h"
#import "NBAppHelper.h"

//#define NOSERVER

static NSString *const API_BASE_URL = @"http://localhost:3000/api";

@implementation NBAPIClient

+ (NBAPIClient *)sharedAPIClient {
    static NBAPIClient *_sharedAPIClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAPIClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:API_BASE_URL]];
    });
    
    return _sharedAPIClient;
}


- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

#pragma mark - API requests

- (void)userLoggedInWithFacebookId:(NSString *)facebookId name:(NSString *)name success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure {
    
#ifdef NOSERVER
    if (success) {
        success(@"id");
    }
#else
    NSString *url = @"user";
    NSDictionary *params = @{ @"facebookId": facebookId, @"name": name, @"deviceId": @"TEST_DEVICE_ID" };
    
    [self POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            NSString *userId = responseObject[@"userId"];
            success(userId);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
#endif
}

- (void)userLoggedOutWithFacebookId:(NSString *)facebookId success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure {
    
}

- (void)getAllUserGamesWithSuccess:(void (^)(NSArray *, NSArray *, NSArray *))success failure:(void (^)(NSError *))failure {
    
    
#ifndef NOSERVER
    
#else
    // dummy
    NSMutableArray *myturn = [NSMutableArray new];
    NSMutableArray *their = [NSMutableArray new];
    NSMutableArray *recent = [NSMutableArray new];
    for (int i = 0; i < 3; i++) {
        NBGameObject *game = [[NBGameObject alloc] init];
        game.gameId = @"sdkjfka;lsf";
        game.opponentName = @"Gabe Stengel";
        game.opponentId = @"akl;jsdfl;ksf";
        game.opponentFacebookId = @"gabe.stengel";
        game.userIsX = (i % 2 == 0) ? TRUE : FALSE;
        game.status = NBGameStatusMyTurn;
        game.lastMoveGrid = 1;
        game.lastMoveDate = [NSDate date];
        game.winnerId = nil;
        game.winnerName = nil;
        game.board = [NSMutableArray new];
        for (int i = 0; i < 9; i++) {
            NSArray *b = @[@(NBSquareTypeO), @(NBSquareTypeX), @(NBSquareTypeEmpty), @(NBSquareTypeO), @(NBSquareTypeO), @(NBSquareTypeEmpty), @(NBSquareTypeEmpty), @(NBSquareTypeEmpty), @(NBSquareTypeX)];
            
            [game.board addObject:b];
        }
        [myturn addObject:game];
    }
    for (int i = 0; i < 3; i++) {
        NBGameObject *game = [[NBGameObject alloc] init];
        game.gameId = @"sdkjfka;lsf";
        game.opponentName = @"Gabe Stengel";
        game.opponentId = @"akl;jsdfl;ksf";
        game.opponentFacebookId = @"gabe.stengel";
        game.userIsX = arc4random() < 0.5;
        game.status = NBGameStatusOpponentTurn;
        game.lastMoveGrid = 2;
        game.lastMoveDate = [NSDate date];
        game.winnerId = nil;
        game.winnerName = nil;
        game.board = [NSMutableArray new];
        for (int i = 0; i < 9; i++) {
            NSArray *b = @[@(NBSquareTypeO), @(NBSquareTypeX), @(NBSquareTypeEmpty), @(NBSquareTypeO), @(NBSquareTypeO), @(NBSquareTypeEmpty), @(NBSquareTypeEmpty), @(NBSquareTypeEmpty), @(NBSquareTypeX)];
            
            [game.board addObject:b];
        }
        [their addObject:game];
    }
    for (int i = 0; i < 3; i++) {
        NBGameObject *game = [[NBGameObject alloc] init];
        game.gameId = @"sdkjfka;lsf";
        game.opponentName = @"Gabe Stengel";
        game.opponentId = @"g";
        game.opponentFacebookId = @"gabe.stengel";
        game.userIsX = arc4random() < 0.5;
        game.status = NBGameStatusOver;
        game.lastMoveGrid = 1;
        game.lastMoveDate = [NSDate date];
        game.winnerId = @"g";
        game.winnerName = nil;
        game.board = [NSMutableArray new];
        for (int i = 0; i < 9; i++) {
            NSArray *b = @[@(NBSquareTypeO), @(NBSquareTypeX), @(NBSquareTypeEmpty), @(NBSquareTypeO), @(NBSquareTypeO), @(NBSquareTypeEmpty), @(NBSquareTypeEmpty), @(NBSquareTypeEmpty), @(NBSquareTypeX)];
            
            [game.board addObject:b];
        }
        [recent addObject:game];
    }
    success(myturn, their, recent);
#endif

    
    
}

- (void)getUserStatsWithSuccess:(void (^)(int, int, int))success failure:(void (^)(NSError *))failure {
    
#ifdef NOSERVER
    success(6, 3, 19);
#else
    
#endif
}

- (void)playTurnInGrid:(int)grid position:(int)position forGame:(NSString *)gameId withSuccess:(void (^)(NBGameObject *))success failure:(void (^)(NSError *))failure {
    
    int row = -1, column = -1;
    if (position == 0) { row = 0; column = 0; }
    if (position == 1) { row = 0; column = 1; }
    if (position == 2) { row = 0; column = 2; }
    if (position == 3) { row = 1; column = 0; }
    if (position == 4) { row = 1; column = 1; }
    if (position == 5) { row = 1; column = 2; }
    if (position == 6) { row = 2; column = 0; }
    if (position == 7) { row = 2; column = 1; }
    if (position == 8) { row = 2; column = 2; }
    
    NSNumber *encoded = @([[NSString stringWithFormat:@"%d%d%d", grid, row, column] intValue]);
    NSDictionary *params = @{ @"turn": encoded };
    NSString *url = [NSString stringWithFormat:@"api/%@/games/%@", [NBAppHelper userId], gameId];
    
    [self POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

#pragma mark - convenience methods







@end
