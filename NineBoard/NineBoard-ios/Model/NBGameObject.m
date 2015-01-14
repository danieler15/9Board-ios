//
//  NBGameObject.m
//  NineBoard-ios
//
//  Created by Daniel Ernst on 12/4/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import "NBGameObject.h"

#import "NBAppHelper.h"

@implementation NBGameObject

+ (NBGameObject *)gameObjectFromServerJSON:(id)json {
    NBGameObject *game = [[NBGameObject alloc] init];
    game.gameId = json[@"id"];
    
    
    for (NSString *s in json[@"players"]) {
        if (![s isEqualToString:[NBAppHelper userId]]) {
            game.opponentId = s;
        }
    }
    
    return nil;
}

@end
