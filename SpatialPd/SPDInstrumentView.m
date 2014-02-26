//
//  SPDInstrumentView.m
//  SpatialPd
//
//  Created by Bektur Ryskeldiev on 6/14/13.
//  Copyright (c) 2013 Bektur Ryskeldiev. All rights reserved.
//

#import "SPDInstrumentView.h"

@implementation SPDInstrumentView

#pragma mark - Setup code

- (void) setColor: (UIColor *) color
          andName: (NSString *) name
{
    _color = color;
    [self setName:name];
    
    [_labelInstrument setText:name];
    
    [_labelXPosition setText:[NSString stringWithFormat:@"%1.0f", self.center.x]];
    [_labelYPosition setText:[NSString stringWithFormat:@"%1.0f", self.center.y]];
}

- (void) updateLocationLabels
{
    [_labelXPosition setText:[NSString stringWithFormat:@"%1.0f", self.center.x]];
    [_labelYPosition setText:[NSString stringWithFormat:@"%1.0f", self.center.y]];
}

- (void) drawCenter
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (context != nil)
    {
        CGPoint center;
        center.x = self.bounds.size.width / 2;
        center.y = self.bounds.size.height / 2;
        CGContextSaveGState(context);
        
        CGContextSetLineWidth(context, 2);
        CGColorRef strokeColor = [_color CGColor];
        
        CGContextSetStrokeColorWithColor(context, strokeColor);
        
        CGContextAddArc(context, center.x, center.y, 50, 0.0, M_PI*2, YES);
        
        if ([_name isEqualToString:NAME_LISTENER])
        {
            CGContextMoveToPoint(context, center.x, center.y - 50);
            CGContextAddLineToPoint(context, center.x, center.y - 60);
        }
        
        CGContextStrokePath(context);
    }
}

- (void) drawRect:(CGRect)rect
{
    [self drawCenter];
}

@end
