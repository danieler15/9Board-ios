//
//  NBFullGridView.m
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/21/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import "NBFullGridView.h"

#import "NBSingleGridView.h"

const CGFloat GRID_MARGIN = 7.0;

@implementation NBFullGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        for (NBSingleGridView *gr in self.grids) {
            [self addSubview:gr];
        }
    }
    return self;
}

- (void)updateConstraints {
    [self removeConstraints:self.constraints];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[gr0]-m-[gr1(==gr0)]-m-[gr2(==gr0)]|" options:0 metrics:@{@"m": @(GRID_MARGIN)} views:@{@"gr0": self.grids[0], @"gr1": self.grids[1], @"gr2": self.grids[2]}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[gr3]-m-[gr4(==gr3)]-m-[gr5(==gr3)]|" options:0 metrics:@{@"m": @(GRID_MARGIN)} views:@{@"gr3": self.grids[3], @"gr4": self.grids[4], @"gr5": self.grids[5]}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[gr6]-m-[gr7(==gr6)]-m-[gr8(==gr6)]|" options:0 metrics:@{@"m": @(GRID_MARGIN)} views:@{@"gr6": self.grids[6], @"gr7": self.grids[7], @"gr8": self.grids[8]}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[gr0]-m-[gr3(==gr0)]-m-[gr6(==gr0)]|" options:0 metrics:@{@"m": @(GRID_MARGIN)} views:@{@"gr0": self.grids[0], @"gr3": self.grids[3], @"gr6": self.grids[6]}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[gr1]-m-[gr4(==gr1)]-m-[gr7(==gr1)]|" options:0 metrics:@{@"m": @(GRID_MARGIN)} views:@{@"gr1": self.grids[1], @"gr4": self.grids[4], @"gr7": self.grids[7]}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[gr2]-m-[gr5(==gr2)]-m-[gr8(==gr2)]|" options:0 metrics:@{@"m": @(GRID_MARGIN)} views:@{@"gr2": self.grids[2], @"gr5": self.grids[5], @"gr8": self.grids[8]}]];
    
    [super updateConstraints];
}

- (NSArray *)grids {
    if (!_grids) {
        NSMutableArray *mGrids = [NSMutableArray new];
        for (int i = 0; i <= 8; i++) {
            UIColor *bg = (i % 2 == 0) ? [UIColor lightGrayColor] : [UIColor darkGrayColor];
            
            NBSingleGridView *gr = [[NBSingleGridView alloc] initWithSquareColor:bg];
            gr.tag = i;
            [gr setTranslatesAutoresizingMaskIntoConstraints:NO];
            
            [mGrids addObject:gr];
        }
        _grids = [mGrids copy];
    }
    return _grids;
}

- (void)squareTappedWithPosition:(NSInteger)squarePos inGridWithPosition:(NSInteger)gridPos {
    if (self.delegate) {
        [self.delegate squareTappedWithPosition:squarePos inGridWithPosition:gridPos];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
