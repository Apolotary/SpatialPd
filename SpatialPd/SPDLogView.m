//
//  SPDLogView.m
//  SpatialPd
//
//  Created by Bektur Ryskeldiev on 10/12/13.
//  Copyright (c) 2013 Bektur Ryskeldiev. All rights reserved.
//

#import "SPDLogView.h"

@implementation SPDLogView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) updateInstrumentLabel:(NSString *) instrumentName
{
    [_labelInstrument setText:[NSString stringWithFormat:@"Instrument: %@", instrumentName]];
}

- (void) updateRadLabel:(CGFloat) radValue
{
    [_labelRad setText:[NSString stringWithFormat:@"Rad: %1.1f", radValue]];
}

- (void) updateThetaLabel:(CGFloat) thetaValue
{
    [_labelTheta setText:[NSString stringWithFormat:@"θ: %1.1f", thetaValue]];
}

- (void) updateITDLabel:(CGFloat) itdValue
{
    [_labelITD setText:[NSString stringWithFormat:@"ITD: %1.1f", itdValue]];
}

- (void) updateListenerLabel:(CGFloat) listenerValue
{
    [_labelListenerAngle setText:[NSString stringWithFormat:@"Listener's angle: %1.1f", listenerValue]];
}

- (void) updateRotationLabel:(CGFloat) rotationValue
{
    [_labelRotationAngle setText:[NSString stringWithFormat:@"Rotation angle: %1.1f", rotationValue]];
}

@end
