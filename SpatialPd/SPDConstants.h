//
//  SPDConstants.h
//  SpatialPd
//
//  Created by Bektur Ryskeldiev on 6/18/13.
//  Copyright (c) 2013 Bektur Ryskeldiev. All rights reserved.
//

#import <Foundation/Foundation.h>

// ------------------------
#pragma mark - Instruments icons and names

#define NAME_GUITAR   @"guitar"
#define NAME_BASS     @"bass"
#define NAME_DRUMS    @"drums"
#define NAME_PIANO    @"piano"
#define NAME_LISTENER @"listener"

#define INSTRUMENT_QUANTITY 5.0 // including listener

#define NAME_KEY     @"instrumentName"
#define LOCATION_KEY @"instrumentLocation"

// ------------------------
#pragma mark - PD constants

#define SOUNDTEST_PATCH @"soundtest.pd"
#define SPATIAL_PATCH   @"spatial1.pd"

// ------------------------
#pragma mark - Math calculations constants

#define POLAR_RADIUS_KEY @"radius"
#define POLAR_THETA_KEY  @"theta"
#define ITD_KEY          @"itd"

#define SPEED_OF_SOUND 340.29
#define HEAD_RADIUS    0.09  // in meters

// ------------------------
#pragma mark - Gyroscope Adjustments

#define MOTION_UPDATE_INTERVAL 0.001

@interface SPDConstants : NSObject

@end
