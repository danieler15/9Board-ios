//
//  NBGameObject.h
//  NineBoard-ios
//
//  Created by Daniel Ernst on 12/4/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NBGameStatus) {
    NBGameStatusMyTurn,
    NBGameStatusOpponentTurn,
    NBGameStatusOver
};

@interface NBGameObject : NSObject

@property (strong, nonatomic) NSString *gameId;
@property (strong, nonatomic) NSString *opponentName;
@property (strong, nonatomic) NSString *opponentFacebookId;
@property (strong, nonatomic) NSString *opponentId;
@property (nonatomic, assign) BOOL userIsX;
@property (nonatomic, assign) NBGameStatus status;
@property (nonatomic, assign) int lastMoveGrid;
@property (strong, nonatomic) NSDate *lastMoveDate;
@property (strong, nonatomic) NSString *winnerName;
@property (strong, nonatomic) NSString *winnerId;

// contains a subarray of each individual board
@property (strong, nonatomic) NSMutableArray *board;

@end
