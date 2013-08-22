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

- (void) setImage: (UIImage *)  image
          andName: (NSString *) name
{
    [self setIcon:image];
    [self setName:name];
    
    [_circleView setImage:image];
    [_labelInstrument setText:name];
    
    [_labelXPosition setText:[NSString stringWithFormat:@"%1.0f", self.center.x]];
    [_labelYPosition setText:[NSString stringWithFormat:@"%1.0f", self.center.y]];
}

- (void) updateLocationLabels
{
    [_labelXPosition setText:[NSString stringWithFormat:@"%1.0f", self.center.x]];
    [_labelYPosition setText:[NSString stringWithFormat:@"%1.0f", self.center.y]];
}


@end
