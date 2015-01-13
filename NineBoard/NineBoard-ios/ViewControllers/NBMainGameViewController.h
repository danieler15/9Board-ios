//
//  NBMainGameViewController.h
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/21/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBFullGridView.h"

@class NBGameObject;

@interface NBMainGameViewController : UIViewController <NBFullGridViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NBGameObject *gameObject;

@end
