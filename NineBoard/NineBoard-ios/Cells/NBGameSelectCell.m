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

@property (nonatomic, assign) NBCellPosition cellPosition;

@end

const CGFloat CORNER_RADIUS = 5.0;

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
        [_rootView setBackgroundColor:[UIColor clearColor]];
        
        [self.rootView addSubview:self.roundedView];
    }
    return _rootView;
}




@end
