//
//  NBSingleGridView.h
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/21/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBSingleGridView : UIView

- (id)initWithSquareColor:(UIColor *)color;

@property (strong, nonatomic) NSArray *squares;

@end
