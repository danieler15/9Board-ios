//
//  NBGridSquareView.h
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/21/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NBSquareType) {
    NBSquareTypeX,
    NBSquareTypeO,
    NBSquareTypeEmpty
};

@interface NBGridSquareView : UIView

- (void)drawSquareType:(NBSquareType)squareType animated:(BOOL)animated;

@end
