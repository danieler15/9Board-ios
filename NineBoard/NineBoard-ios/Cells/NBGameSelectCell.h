//
//  NBGameSelectCell.h
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/22/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NBCellPosition) {
    NBCellPositionTop,
    NBCellPositionBottom,
    NBCellPositionMiddle
};

@interface NBGameSelectCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellPosition:(NBCellPosition)cellPosition;

@end
