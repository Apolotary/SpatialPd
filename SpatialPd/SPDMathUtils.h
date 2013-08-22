//
//  SPDMathUtils.h
//  SpatialPd
//
//  Created by Bektur Ryskeldiev on 6/14/13.
//  Copyright (c) 2013 Bektur Ryskeldiev. All rights reserved.
//

// Basic reusable math calculation methods

#import <Foundation/Foundation.h>

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface SPDMathUtils : NSObject

+ (NSDictionary *) calculatePolarCoordinatesForX1: (float) x1
                                               Y1: (float) y1
                                               X2: (float) x2
                                               Y2: (float) y2;

+ (float) calculateITDValueForRadius: (float) radius
                            andTheta: (float) theta;

+ (CGFloat) forceAngleToITDConstraints: (CGFloat) angle;

@end
