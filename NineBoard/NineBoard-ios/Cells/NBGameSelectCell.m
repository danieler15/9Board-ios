//
//  NBGameSelectCell.m
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/22/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import "NBGameSelectCell.h"

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "NBGameObject.h"
#import "NBAppHelper.h"

@interface NBGameSelectCell()

@property (strong, nonatomic) UIView *rootView;
@property (strong, nonatomic) UIView *roundedView;
@property (strong, nonatomic) UIView *separatorView;
@property (strong, nonatomic) UIImageView *profileImageView;
@property (strong, nonatomic) UILabel *headerLabel;
@property (strong, nonatomic) UILabel *detailLabel;

@property (nonatomic, assign) NBCellPosition cellPosition;

@end

const CGFloat IMAGE_LEFT_MARGIN = 15.0;
const CGFloat CONTENT_VERTICAL_MARGIN = 10.0;

@implementation NBGameSelectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellPosition:(NBCellPosition)cellPosition
{
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setCellPosition:cellPosition];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.rootView];
    }
    return self;
}

- (void)updateConstraints {
    [self.contentView removeConstraints:self.contentView.constraints];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[root]|" options:0 metrics:nil views:@{@"root": self.rootView}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[root]|" options:0 metrics:nil views:@{@"root": self.rootView}]];
    
    // general horizontal layout
    [self.rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-m-[im]" options:0 metrics:@{@"m": @(IMAGE_LEFT_MARGIN)} views:@{@"im": self.profileImageView, @"label": self.headerLabel}]];
    [self.rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.headerLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.profileImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.0]];
    
    
    // image layout
    [self.rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(-2 * CONTENT_VERTICAL_MARGIN)]];
    [self.rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeWidth relatedBy:1.0 toItem:self.profileImageView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    [self.rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    // labels
    [self.rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.detailLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [self.rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-vm-[h][d]-vm-|" options:0 metrics:@{@"vm": @(CONTENT_VERTICAL_MARGIN + 5)} views:@{@"h": self.headerLabel, @"d": self.detailLabel}]];
    
    NSLayoutConstraint *equalHeightsConstraint = [NSLayoutConstraint constraintWithItem:self.detailLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.headerLabel attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    [equalHeightsConstraint setPriority:UILayoutPriorityDefaultLow];
    [self.rootView addConstraint:equalHeightsConstraint];
    
    
    [super updateConstraints];
}

- (void)configureWithGame:(NBGameObject *)game {
    [self.profileImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=square", game.opponentFacebookId]]];
    NSString *bigText = @"";
    if (game.status == NBGameStatusMyTurn) {
        bigText = [NSString stringWithFormat:@"Play Turn vs. %@", game.opponentName];
    }
    else if (game.status == NBGameStatusOpponentTurn) {
        bigText = [NSString stringWithFormat:@"Waiting for %@", game.opponentName];
    }
    else if (game.winnerId && [game.winnerId isEqualToString:[NBAppHelper userId]]) {
        bigText = [NSString stringWithFormat:@"You beat %@!", game.opponentName];
    }
    else {
        bigText = [NSString stringWithFormat:@"%@ Beat You!", game.opponentName];
    }
    [self.headerLabel setText:bigText];
    
    
    [self.detailLabel setText:[NSString stringWithFormat:@"Last move: %d days ago", 4]];
}


#pragma mark - setters
- (UIImageView *)profileImageView {
    if (!_profileImageView) {
        _profileImageView = [[UIImageView alloc] init];
        [_profileImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_profileImageView setBackgroundColor:[UIColor cyanColor]];
        _profileImageView.layer.cornerRadius = 5.0;
        [_profileImageView setClipsToBounds:YES];
    }
    return _profileImageView;
}

- (UILabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
        [_headerLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_headerLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
        [_headerLabel setAdjustsFontSizeToFitWidth:YES];
        [_headerLabel setMinimumScaleFactor:0.5];
        //[_headerLabel setBackgroundColor:[UIColor greenColor]];
    }
    return _headerLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        [_detailLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_detailLabel setFont:[UIFont systemFontOfSize:13.0]];
        [_detailLabel setTextColor:[UIColor grayColor]];
        [_detailLabel setAdjustsFontSizeToFitWidth:YES];
        [_detailLabel setMinimumScaleFactor:0.5];
    }
    return _detailLabel;
}

- (UIView *)rootView {
    if (!_rootView) {
        _rootView = [[UIView alloc] init];
        [_rootView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_rootView setBackgroundColor:[UIColor whiteColor]];
        
        [_rootView addSubview:self.profileImageView];
        [_rootView addSubview:self.headerLabel];
        [_rootView addSubview:self.detailLabel];
    }
    return _rootView;
}




@end
