//
//  NBAPIClient.m
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/21/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import "NBAPIClient.h"

#define NOSERVER

static NSString *const API_BASE_URL = @"localhost://9board/api";

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
    success(@"testid");
#else
    NSString *url = @"user/login/facebook";
    NSDictionary *params = @{ @"facebookId": facebookId, @"name": name };
    
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

#pragma mark - convenience methods







@end
