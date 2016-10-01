//
//  PCCircleView.m
//  PCCal
//
//  Created by Pierre-David Bélanger on 16-09-30.
//  Copyright © 2016 PjEr.ca. All rights reserved.
//

#import "PCCircleView.h"

@implementation PCCircleView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGFloat size = MIN(rect.size.width, rect.size.height);
    CGFloat x = rect.origin.x + rect.size.width / 2.0 - size / 2.0;
    CGFloat y = rect.origin.y + rect.size.height / 2.0 - size / 2.0;
    CGRect circleRect = CGRectMake(x, y, size, size);
    
    CGContextSetFillColorWithColor(ctx, [self.tintColor CGColor]);
    CGContextFillEllipseInRect(ctx, circleRect);
}

@end
