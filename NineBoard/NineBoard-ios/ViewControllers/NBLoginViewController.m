//
//  NBLoginViewController.m
//  NineBoard-ios
//
//  Created by Daniel Ernst on 12/4/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import "NBLoginViewController.h"

#import "NBAppDelegate.h"
#import "NBFacebookHelper.h"


@interface NBLoginViewController ()

@property (strong, nonatomic) UILabel *mainLabel;
@property (strong, nonatomic) UIButton *facebookButton;

@end

@implementation NBLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.mainLabel];
    [self.view addSubview:self.facebookButton];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    [self.view removeConstraints:self.view.constraints];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[label(130)]-20-[fb(50)]" options:0 metrics:nil views:@{@"label": self.mainLabel, @"fb": self.facebookButton}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-30-[label]-30-|" options:0 metrics:nil views:@{@"label": self.mainLabel}]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.facebookButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.facebookButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.65 constant:0.0]];
    
    
    [super updateViewConstraints];
}

- (void)facebookLogout {
    [NBFacebookHelper logout];
}

- (void)doFacebookLogin {
    [NBFacebookHelper initiateLogin];
}

- (UILabel *)mainLabel {
    if (!_mainLabel) {
        _mainLabel = [[UILabel alloc] init];
        [_mainLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mainLabel setTextAlignment:NSTextAlignmentCenter];
        [_mainLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17.0]];
        [_mainLabel setNumberOfLines:-1];
        [_mainLabel setText:@"Welcome to 9Board, a fun game for the whole family! We suggest you log in to facebook, so you can play with your maaaany friends!"];
        
    }
    return _mainLabel;
}

- (UIButton *)facebookButton {
    if (!_facebookButton) {
        _facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_facebookButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_facebookButton addTarget:self action:@selector(doFacebookLogin) forControlEvents:UIControlEventTouchUpInside];
        
        [_facebookButton setBackgroundColor:[UIColor colorWithRed:0.286 green:0.396 blue:0.624 alpha:1.000]];
        [_facebookButton.layer setCornerRadius:5.0];
        [_facebookButton setTitle:@"Login With Facebook" forState:UIControlStateNormal];
        [_facebookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_facebookButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
        
    }
    return _facebookButton;
}




@end
