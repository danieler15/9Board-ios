//
//  NBGameControllerPlayersView.h
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/21/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NBGameObject.h"

@interface NBGameControllerPlayersView : UIView

@property (strong, nonatomic) NBGameObject *gameObject;

- (instancetype)initWithGameObject:(NBGameObject *)gameObject;

@end
