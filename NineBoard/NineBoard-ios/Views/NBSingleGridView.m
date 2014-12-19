//
//  NBSingleGridView.m
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/21/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import "NBSingleGridView.h"

#import "NBFullGridView.h"
#import "NBGridSquareView.h"

@interface NBSingleGridView()

@property (strong, nonatomic) UIColor *squareColor;

@end

const CGFloat SQUARE_MARGIN = 4.0;

@implementation NBSingleGridView

- (id)initWithSquareColor:(UIColor *)color
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.squareColor = color;
        self.backgroundColor = [UIColor clearColor];
        
        for (NBGridSquareView *sq in self.squares) {
            [self addSubview:sq];
        }
    }
    return self;
}

- (void)updateConstraints {
    [self removeConstraints:self.constraints];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[sq0]-m-[sq1(==sq0)]-m-[sq2(==sq0)]|" options:0 metrics:@{@"m": @(SQUARE_MARGIN)} views:@{@"sq0": self.squares[0], @"sq1": self.squares[1], @"sq2": self.squares[2]}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[sq3]-m-[sq4(==sq3)]-m-[sq5(==sq3)]|" options:0 metrics:@{@"m": @(SQUARE_MARGIN)} views:@{@"sq3": self.squares[3], @"sq4": self.squares[4], @"sq5": self.squares[5]}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[sq6]-m-[sq7(==sq6)]-m-[sq8(==sq6)]|" options:0 metrics:@{@"m": @(SQUARE_MARGIN)} views:@{@"sq6": self.squares[6], @"sq7": self.squares[7], @"sq8": self.squares[8]}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[sq0]-m-[sq3(==sq0)]-m-[sq6(==sq0)]|" options:0 metrics:@{@"m": @(SQUARE_MARGIN)} views:@{@"sq0": self.squares[0], @"sq3": self.squares[3], @"sq6": self.squares[6]}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[sq1]-m-[sq4(==sq1)]-m-[sq7(==sq1)]|" options:0 metrics:@{@"m": @(SQUARE_MARGIN)} views:@{@"sq1": self.squares[1], @"sq4": self.squares[4], @"sq7": self.squares[7]}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[sq2]-m-[sq5(==sq2)]-m-[sq8(==sq2)]|" options:0 metrics:@{@"m": @(SQUARE_MARGIN)} views:@{@"sq2": self.squares[2], @"sq5": self.squares[5], @"sq8": self.squares[8]}]];
    
    [super updateConstraints];
}

- (NSArray *)squares {
    if (!_squares) {
        NSMutableArray *mSquares = [NSMutableArray new];
        for (int i = 0; i <= 8; i++) {
            NBGridSquareView *sq = [[NBGridSquareView alloc] init];
            sq.backgroundColor = self.squareColor;
            sq.tag = i;
            [sq setTranslatesAutoresizingMaskIntoConstraints:NO];
            
            UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(squareTapped:)];
            [sq addGestureRecognizer:gr];
            [mSquares addObject:sq];
        }
        _squares = [mSquares copy];
    }
    return _squares;
}

- (void)squareTapped:(id)sender {
    NBFullGridView *fullGrid = (NBFullGridView *)[self superview];
    NBGridSquareView *square = (NBGridSquareView *)((UITapGestureRecognizer *)sender).view;

    [fullGrid squareTappedWithPosition:square.tag inGridWithPosition:self.tag];
}

- (void)highlight {
    [self setBackgroundColor:[UIColor yellowColor]];
}

- (void)noHightlight {
    [self setBackgroundColor:[UIColor clearColor]];
}

@end
