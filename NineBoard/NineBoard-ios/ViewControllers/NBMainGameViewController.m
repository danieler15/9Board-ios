//
//  NBMainGameViewController.m
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/21/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import "NBMainGameViewController.h"

#import "NBGameControllerPlayersView.h"
#import "NBFullGridView.h"
#import "NBSingleGridView.h"
#import "NBGridSquareView.h"

@interface NBMainGameViewController ()

@property (strong, nonatomic) NBGameControllerPlayersView *playersView;
@property (strong, nonatomic) NBFullGridView *fullGridView;

@end

@implementation NBMainGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Your Turn"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.playersView];
    [self.view addSubview:self.fullGridView];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    [self.view removeConstraints:self.view.constraints];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-74-[playersView(100)]-20-[grid]-(>=0)-|" options:0 metrics:nil views:@{@"playersView": self.playersView, @"grid": self.fullGridView}]];
    

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[v]-10-|" options:0 metrics:nil views:@{@"v": self.playersView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[v]-10-|" options:0 metrics:nil views:@{@"v": self.fullGridView}]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.fullGridView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.fullGridView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.fullGridView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    
    
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - NBFullGridViewDelegate

- (void)squareTappedWithPosition:(NSInteger)squarePos inGridWithPosition:(NSInteger)gridPos {
    NSLog(@"Square tapped-- Grid: %d, Position: %d", (int)gridPos, (int)squarePos);
    
    if (gridPos == 0) {
        NBGridSquareView *square = ((NBSingleGridView *)self.fullGridView.grids[8]).squares[8];
        [square drawSquareType:NBSquareTypeEmpty animated:YES];
    }
    
    
    NBGridSquareView *square = ((NBSingleGridView *)self.fullGridView.grids[gridPos]).squares[squarePos];
    [square drawSquareType:NBSquareTypeX animated:YES];
    
    
}

#pragma mark - getters

- (NBGameControllerPlayersView *)playersView {
    if (!_playersView) {
        _playersView = [[NBGameControllerPlayersView alloc] init];
        [_playersView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_playersView setBackgroundColor:[UIColor cyanColor]];
    }
    return _playersView;
}

- (NBFullGridView *)fullGridView {
    if (!_fullGridView) {
        _fullGridView = [[NBFullGridView alloc] init];
        [_fullGridView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_fullGridView setBackgroundColor:[UIColor clearColor]];
        [_fullGridView setDelegate:self];
    }
    return _fullGridView;
}





@end
