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
#import "NBGameObject.h"
#import "NBPosition.h"
#import "NBAPIClient.h"

@interface NBMainGameViewController ()

@property (strong, nonatomic) NBGameControllerPlayersView *playersView;
@property (strong, nonatomic) NBFullGridView *fullGridView;
@property (strong, nonatomic) NBPosition *userMovePosition;
@property (strong, nonatomic) UIButton *playTurnButton;
@property (strong, nonatomic) UIButton *cancelMoveButton;
@property (strong, nonatomic) UILabel *footerLabel;

@end

#define PlayTurnButtonColorEnabled [UIColor colorWithRed:0.129 green:0.808 blue:0.600 alpha:1.000]
#define PlayTurnButtonColorDisabled [UIColor colorWithRed:0.129 green:0.808 blue:0.600 alpha:0.5]
#define CancelMoveButtonColorEnabled [UIColor colorWithRed:0.875 green:0.890 blue:0.176 alpha:1.000]
#define CancelMoveButtonColorDisabled [UIColor colorWithRed:0.875 green:0.890 blue:0.176 alpha:0.5]

@implementation NBMainGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Your Turn"];
        self.userMovePosition = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.playersView];
    [self.view addSubview:self.fullGridView];
    [self.view addSubview:self.playTurnButton];
    [self.view addSubview:self.cancelMoveButton];
    
    [self.view setNeedsUpdateConstraints];
    
   
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)updateViewConstraints {
    [self.view removeConstraints:self.view.constraints];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-74-[playersView(100)]-20-[grid]-15-[but]-15-|" options:0 metrics:nil views:@{@"playersView": self.playersView, @"grid": self.fullGridView, @"but": self.cancelMoveButton}]];
    

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[v]-10-|" options:0 metrics:nil views:@{@"v": self.playersView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[v]-10-|" options:0 metrics:nil views:@{@"v": self.fullGridView}]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.fullGridView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.fullGridView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.fullGridView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[cancel]-20-[play(==cancel)]-20-|" options:0 metrics:nil views:@{@"cancel": self.cancelMoveButton, @"play": self.playTurnButton}]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.cancelMoveButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.playTurnButton attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.cancelMoveButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.playTurnButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    
    [self configureForGame];
    
    [super updateViewConstraints];
}

- (void)configureForGame {
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            NBGridSquareView *square = ((NBSingleGridView *)self.fullGridView.grids[i]).squares[j];
            [square drawSquareType:NBSquareTypeEmpty animated:NO];
            
        }
    }
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            NSNumber *squareValue = self.gameObject.board[i][j];
            int squareType = [squareValue intValue];
            
            NBGridSquareView *square = ((NBSingleGridView *)self.fullGridView.grids[i]).squares[j];
            if (squareType == NBSquareTypeX) {
                [square drawSquareType:NBSquareTypeX animated:NO];
            }
            else if (squareType == NBSquareTypeO) {
                [square drawSquareType:NBSquareTypeO animated:NO];
            }
            else {
                [square drawSquareType:NBSquareTypeEmpty animated:NO];
            }
        }
    }
    [(NBSingleGridView *)self.fullGridView.grids[self.gameObject.lastMoveGrid] highlight];
}

- (void)playTurn {
    if (!self.userMovePosition) {
        return;
    }
    [[NBAPIClient sharedAPIClient] playTurnInGrid:self.userMovePosition.gridPosition position:self.userMovePosition.innerPosition forGame:self.gameObject.gameId withSuccess:^(NBGameObject *updatedGameObject) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Sucess!" message:@"You have played your turn" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        av.tag = 100;
        [av show];
    } failure:^(NSError *error) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Unable to record turn." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        av.tag = 200;
        [av show];
    }];
}

- (void)cancelMove {
    NBGridSquareView *square = ((NBSingleGridView *)self.fullGridView.grids[self.userMovePosition.gridPosition]).squares[self.userMovePosition.innerPosition];
    [square drawSquareType:NBSquareTypeEmpty animated:YES];
    self.userMovePosition = nil;
    
    [self.playTurnButton setBackgroundColor:PlayTurnButtonColorDisabled];
    [self.cancelMoveButton setBackgroundColor:CancelMoveButtonColorDisabled];
    [self.playTurnButton setEnabled:NO];
    [self.cancelMoveButton setEnabled:NO];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - NBFullGridViewDelegate

- (void)squareTappedWithPosition:(NSInteger)squarePos inGridWithPosition:(NSInteger)gridPos {
    NSLog(@"Square tapped-- Grid: %d, Position: %d", (int)gridPos, (int)squarePos);
    
    NBGridSquareView *square = ((NBSingleGridView *)self.fullGridView.grids[gridPos]).squares[squarePos];
    int squareValue = [self.gameObject.board[gridPos][squarePos] intValue];
    
    if (self.gameObject.status == NBGameStatusMyTurn && self.gameObject.lastMoveGrid == gridPos && !self.userMovePosition &&squareValue == NBSquareTypeEmpty) {
        // is user's turn, and he can move there
        NBSquareType mySquareType = (self.gameObject.userIsX) ? NBSquareTypeX : NBSquareTypeO;
        [square drawSquareType:mySquareType animated:YES];
        self.userMovePosition = [[NBPosition alloc] initWithGridPosition:(int)gridPos innerPosition:(int)squarePos];
        [self.playTurnButton setBackgroundColor:PlayTurnButtonColorEnabled];
        [self.cancelMoveButton setBackgroundColor:CancelMoveButtonColorEnabled];
        [self.playTurnButton setEnabled:YES];
        [self.cancelMoveButton setEnabled:YES];
    }
}

#pragma mark - getters

- (NBGameControllerPlayersView *)playersView {
    if (!_playersView) {
        _playersView = [[NBGameControllerPlayersView alloc] initWithGameObject:self.gameObject];
        [_playersView setTranslatesAutoresizingMaskIntoConstraints:NO];
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

- (UIButton *)playTurnButton {
    if (!_playTurnButton) {
        _playTurnButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playTurnButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_playTurnButton setBackgroundColor:PlayTurnButtonColorDisabled];
        [_playTurnButton.layer setCornerRadius:10.0];
        [_playTurnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_playTurnButton setTitle:@"Play Move" forState:UIControlStateNormal];
        [_playTurnButton addTarget:self action:@selector(playTurn) forControlEvents:UIControlEventTouchUpInside];
        [_playTurnButton setEnabled:NO];
    }
    return _playTurnButton;
}

- (UIButton *)cancelMoveButton {
    if (!_cancelMoveButton) {
        _cancelMoveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelMoveButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_cancelMoveButton setBackgroundColor:CancelMoveButtonColorDisabled];
        [_cancelMoveButton.layer setCornerRadius:10.0];
        [_cancelMoveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelMoveButton setTitle:@"Cancel Move" forState:UIControlStateNormal];
        [_cancelMoveButton addTarget:self action:@selector(cancelMove) forControlEvents:UIControlEventTouchUpInside];
        [_cancelMoveButton setEnabled:NO];
    }
    return _cancelMoveButton;
}




@end
