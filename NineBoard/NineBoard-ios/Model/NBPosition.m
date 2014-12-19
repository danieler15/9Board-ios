//
//  NBPosition.m
//  NineBoard-ios
//
//  Created by Daniel Ernst on 12/19/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import "NBPosition.h"

@implementation NBPosition

- (instancetype)initWithGridPosition:(int)grid innerPosition:(int)inner {
    if (self = [super init]) {
        self.innerPosition = inner;
        self.gridPosition = grid;
    }
    return self;
}

@end
