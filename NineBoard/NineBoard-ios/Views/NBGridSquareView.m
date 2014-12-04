//
//  NBGridSquareView.m
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/21/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import "NBGridSquareView.h"

const CGFloat DRAWING_MARGIN = 4.0;

@implementation NBGridSquareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawSquareType:(NBSquareType)squareType animated:(BOOL)animate {
    if (squareType == NBSquareTypeEmpty) {
        [self clearSquare:animate];
        return;
    }
    
    UIBezierPath *bezierPath = (squareType == NBSquareTypeX) ? [self xBezierPath] : [self oBezierPath];
    CAShapeLayer *bezier = [[CAShapeLayer alloc] init];
    
    bezier.path          = bezierPath.CGPath;
    bezier.strokeColor   = [UIColor cyanColor].CGColor;
    bezier.fillColor     = [UIColor clearColor].CGColor;
    bezier.lineWidth     = 4.0;
    bezier.strokeStart   = 0.0;
    bezier.strokeEnd     = 1.0;
    
    UIView *animationBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [animationBg setBackgroundColor:[UIColor clearColor]];
    [self addSubview:animationBg];
    [animationBg.layer addSublayer:bezier];
    
    if (animate)
    {
        CABasicAnimation *animateStrokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animateStrokeEnd.duration  = 0.5;
        animateStrokeEnd.fromValue = [NSNumber numberWithFloat:0.0f];
        animateStrokeEnd.toValue   = [NSNumber numberWithFloat:1.0f];
        [bezier addAnimation:animateStrokeEnd forKey:@"strokeEndAnimation"];
    }
    else {
        [bezierPath stroke];
    }
}

- (UIBezierPath *)xBezierPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapRound;
    [path moveToPoint:CGPointMake(DRAWING_MARGIN, DRAWING_MARGIN)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width - DRAWING_MARGIN, self.bounds.size.height - DRAWING_MARGIN)];
    
    [path moveToPoint:CGPointMake(self.bounds.size.width - DRAWING_MARGIN, DRAWING_MARGIN)];
    [path addLineToPoint:CGPointMake(DRAWING_MARGIN, self.bounds.size.height - DRAWING_MARGIN)];
    
    return path;
}

- (UIBezierPath *)oBezierPath {
    int radius = (self.bounds.size.width - 2*DRAWING_MARGIN) / 2;
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
}

- (void)clearSquare:(BOOL)animate {
    
    if (animate) {
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *v in self.subviews) {
                v.alpha = 0.0;
            }
        } completion:^(BOOL finished) {
            for (UIView *v in self.subviews) {
                [v removeFromSuperview];
            }
        }];
    }
    else {
        for (UIView *v in self.subviews) {
            [v removeFromSuperview];
        }
    }
}

@end
