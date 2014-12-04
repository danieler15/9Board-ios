//
//  NBGameSelectCell.m
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/22/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import "NBGameSelectCell.h"

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
    [self.rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.headerLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.profileImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:IMAGE_LEFT_MARGIN]];
    
    
    // image layout
    [self.rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(-2 * CONTENT_VERTICAL_MARGIN)]];
    [self.rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeWidth relatedBy:1.0 toItem:self.profileImageView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    [self.rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    // labels
    [self.rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.detailLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    //[self.rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[d]|" options:0 metrics:nil views:@{@"h": self.headerLabel, @"d": self.detailLabel}]];
    [self.rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-vm-[h][d(==h)]-vm-|" options:0 metrics:@{@"vm": @(CONTENT_VERTICAL_MARGIN + 5)} views:@{@"h": self.headerLabel, @"d": self.detailLabel}]];
    
    
    
//    [self.rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[rv]-10-|" options:0 metrics:nil views:@{@"rv": self.roundedView}]];
//    [self.rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rv]|" options:0 metrics:nil views:@{@"rv": self.roundedView}]];
//    
//    if ([self.separatorView superview]) {
//        [self.roundedView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[s]|" options:0 metrics:nil views:@{@"s": self.separatorView}]];
//        [self.roundedView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[s(1)]|" options:0 metrics:nil views:@{@"s": self.separatorView}]];
//    }
    
    
    [super updateConstraints];
}
- (UIImageView *)profileImageView {
    if (!_profileImageView) {
        _profileImageView = [[UIImageView alloc] init];
        [_profileImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_profileImageView setBackgroundColor:[UIColor cyanColor]];
        _profileImageView.layer.cornerRadius = 5.0;
    }
    return _profileImageView;
}

- (UILabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
        [_headerLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_headerLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
        [_headerLabel setAdjustsFontSizeToFitWidth:YES];
        [_headerLabel setMinimumScaleFactor:0.9];
        [_headerLabel setText:@"Play Against Gabe Stengel"];
        //[_headerLabel setBackgroundColor:[UIColor greenColor]];
    }
    return _headerLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        [_detailLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_detailLabel setFont:[UIFont systemFontOfSize:11.0]];
        [_detailLabel setTextColor:[UIColor grayColor]];
        [_detailLabel setAdjustsFontSizeToFitWidth:YES];
        [_detailLabel setMinimumScaleFactor:0.01];
        [_detailLabel setText:@"Gabe played his last turn 10 days ago"];
        //[_detailLabel setBackgroundColor:[UIColor redColor]];
    }
    return _detailLabel;
}

//- (UIView *)separatorView {
//    if (!_separatorView) {
//        _separatorView = [[UIView alloc] init];
//        [_separatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [_separatorView setBackgroundColor:[UIColor grayColor]];
//    }
//    return _separatorView;
//}
//
//- (UIView *)roundedView {
//    if (!_roundedView) {
//        _roundedView = [[UIView alloc] init];
//        [_roundedView setTranslatesAutoresizingMaskIntoConstraints:NO];
//        //[_roundedView.layer setCornerRadius:CORNER_RADIUS];
//        [_roundedView setBackgroundColor:[UIColor whiteColor]];
//        
//        if (self.cellPosition != NBCellPositionBottom) {
//            [_roundedView addSubview:self.separatorView];
//        }
//    }
//    return _roundedView;
//}

- (UIView *)rootView {
    if (!_rootView) {
        _rootView = [[UIView alloc] init];
        [_rootView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_rootView setBackgroundColor:[UIColor whiteColor]];
        
        [_rootView addSubview:self.profileImageView];
        [_rootView addSubview:self.headerLabel];
        [_rootView addSubview:self.detailLabel];
        //[self.rootView addSubview:self.roundedView];
    }
    return _rootView;
}




@end
