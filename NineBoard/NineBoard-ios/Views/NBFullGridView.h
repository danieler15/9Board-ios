//
//  NBFullGridView.h
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/21/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NBFullGridViewDelegate <NSObject>

- (void)squareTappedWithPosition:(NSInteger)squarePos inGridWithPosition:(NSInteger)gridPos;

@end

@interface NBFullGridView : UIView

- (void)squareTappedWithPosition:(NSInteger)squarePos inGridWithPosition:(NSInteger)gridPos;

@property (strong, nonatomic) NSArray *grids;
@property (weak, nonatomic) id<NBFullGridViewDelegate> delegate;

@end
