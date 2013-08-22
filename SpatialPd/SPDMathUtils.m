//
//  SPDMathUtils.m
//  SpatialPd
//
//  Created by Bektur Ryskeldiev on 6/14/13.
//  Copyright (c) 2013 Bektur Ryskeldiev. All rights reserved.
//

#import "SPDMathUtils.h"

@implementation SPDMathUtils

+ (NSDictionary *) calculatePolarCoordinatesForX1: (float) x1
                                               Y1: (float) y1
                                               X2: (float) x2
                                               Y2: (float) y2
{
    float theta = atan2f(y2 - y1, x2 - x1);
    
    theta = RADIANS_TO_DEGREES(theta);
    
    // adjusting theta:
    // in the app it is assumed that theta is always positive
    // and is mapped as
    //
    //      360/0
    //
    //  270       90
    //
    //       180
    //
    // however, without adjustments, angles are mapped as
    //
    //       -90
    //
    // +/-180      0
    //
    //        90
    //
    // thus, if for instance we have a -30 degrees angle,
    // which is actually a 60 degrees angle in the system we need,
    // then:
    //
    // since theta is negative, transform it to positive 0-360 angle measure
    // theta = 180 + (180 - 30) = 330
    //
    // since 0 in the system we need is equal to -90, add 90 degrees to theta
    // theta = 330 + 90 = 420
    //
    // since theta is > 360, substract 360
    // theta = 420 - 360 = 60
    //
    // there's probably a better way to deal with coordinates,
    // so feel free to leave any suggestions or comments
    
    if (theta < 0)
    {
        theta = 180 + (180 - ABS(theta));
    }
    
    theta += 90;
    
    if (theta > 360)
    {
        theta -= 360;
    }
    
    float rad = pow((pow(x2 - x1, 2) + pow(y2 - y1, 2)), 0.5);
    
    return @{POLAR_THETA_KEY : [NSNumber numberWithFloat:theta], POLAR_RADIUS_KEY : [NSNumber numberWithFloat:rad]};
}

+ (float) calculateITDValueForRadius: (float) radius
                            andTheta: (float) theta
{
    float ITD = radius * (theta + sin(theta)) / SPEED_OF_SOUND;
    
    CGFloat degreeTheta = RADIANS_TO_DEGREES(theta);
    
    // object is either directly in front of listener
    // or behind listener
    if (degreeTheta == 0 || degreeTheta == 180)
    {
        return 0;
    }
    
    return ITD;
}

+ (CGFloat) forceAngleToITDConstraints: (CGFloat) angle
{
    // angle for ITD is measured at -PI/2 <= a <= PI/2
    // back of the head would have the same angle values,
    // but in mirrored orientation
    
    int sign = 1;
    
    if (angle < 0)
    {
        sign = -1;
    }
    
    angle = ABS(angle);
    
    if (angle > 90 && angle < 180)
    {
        return ABS(180 - angle) * sign;
    }
    
    if (angle > 180 && angle < 270)
    {
        return ABS(270 - angle - 90) * sign * -1;
    }
    
    if (angle > 270 && angle < 360)
    {
        return ABS(360 - angle) * sign * -1;
    }
    
    return angle * sign;
}

@end
