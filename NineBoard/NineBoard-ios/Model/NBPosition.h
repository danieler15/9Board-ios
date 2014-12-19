//
//  NBPosition.h
//  NineBoard-ios
//
//  Created by Daniel Ernst on 12/19/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBPosition : NSObject

@property (nonatomic, assign) int gridPosition;
@property (nonatomic, assign) int innerPosition;

- (instancetype)initWithGridPosition:(int)grid innerPosition:(int)inner;

@end
