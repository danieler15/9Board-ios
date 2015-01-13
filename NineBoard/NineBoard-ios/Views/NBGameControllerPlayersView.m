//
//  NBGameControllerPlayersView.m
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/21/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import "NBGameControllerPlayersView.h"

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "NBAppHelper.h"
#import "NBGameObject.h"

@interface NBGameControllerPlayersView()

@property (strong, nonatomic) UIImageView *meImageView;
@property (strong, nonatomic) UIImageView *opponentImageView;
@property (strong, nonatomic) UILabel *meNameLabel;
@property (strong, nonatomic) UILabel *opponentNameLabel;

@end

@implementation NBGameControllerPlayersView

- (instancetype)initWithGameObject:(NBGameObject *)gameObject {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setGameObject:gameObject];
        [self addSubview:self.meImageView];
        [self addSubview:self.meNameLabel];
        [self addSubview:self.opponentImageView];
        [self addSubview:self.opponentNameLabel];
        [self setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)updateConstraints {
    [self removeConstraints:self.constraints];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[meim(40)]-3-[mename]-15-[oname(==mename)]-3-[oim(==meim)]-5-|" options:0 metrics:nil views:@{@"meim": self.meImageView, @"mename": self.meNameLabel, @"oname": self.opponentNameLabel, @"oim": self.opponentImageView}]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.meImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.meNameLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.opponentImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.opponentNameLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.meImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.meImageView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.meNameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.meImageView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.opponentImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.meImageView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.opponentNameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.meImageView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    
    [super updateConstraints];
}

- (UIImageView *)meImageView {
    if (!_meImageView) {
        _meImageView = [[UIImageView alloc] init];
        [_meImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_meImageView setClipsToBounds:YES];
        [_meImageView.layer setCornerRadius:10.0];
        [_meImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=square", [NBAppHelper userFacebookId]]]];
        
    }
    return _meImageView;
}

- (UIImageView *)opponentImageView {
    if (!_opponentImageView) {
        _opponentImageView = [[UIImageView alloc] init];
        [_opponentImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_opponentImageView.layer setCornerRadius:10.0];
        [_opponentImageView setClipsToBounds:YES];
        [_opponentImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=square", self.gameObject.opponentFacebookId]]];
        
    }
    return _opponentImageView;
}

- (UILabel *)meNameLabel {
    if (!_meNameLabel) {
        _meNameLabel = [[UILabel alloc] init];
        [_meNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_meNameLabel setText:[NBAppHelper userName]];
        [_meNameLabel setBackgroundColor:[UIColor clearColor]];
        [_meNameLabel setAdjustsFontSizeToFitWidth:YES];
        [_meNameLabel setMinimumScaleFactor:0.3];
    }
    return _meNameLabel;
}

- (UILabel *)opponentNameLabel {
    if (!_opponentNameLabel) {
        _opponentNameLabel = [[UILabel alloc] init];
        [_opponentNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_opponentNameLabel setText:self.gameObject.opponentName];
        [_opponentNameLabel setBackgroundColor:[UIColor clearColor]];
        [_opponentNameLabel setAdjustsFontSizeToFitWidth:YES];
        [_opponentNameLabel setMinimumScaleFactor:0.3];
    }
    return _opponentNameLabel;
}



@end
