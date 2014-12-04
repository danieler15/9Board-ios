//
//  NBAPIClient.m
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/21/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import "NBAPIClient.h"

static NSString *const API_BASE_URL = @"localhost://9board";

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

@end
