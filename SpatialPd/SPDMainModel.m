//
//  SPDMainModel.m
//  SpatialPd
//
//  Created by Bektur Ryskeldiev on 6/19/13.
//  Copyright (c) 2013 Bektur Ryskeldiev. All rights reserved.
//

#import "SPDMainModel.h"
#import "SPDPdPatchManager.h"
#import "SPDMathUtils.h"

@interface SPDMainModel()
{
    SPDPdPatchManager *_patchManager;
    CGFloat _previousAngle;
}

@end

@implementation SPDMainModel

#pragma mark - Singleton methods

static SPDMainModel *_sharedInstance = nil;

static void singleton_remover() {
}

+ (SPDMainModel *) sharedInstance
{
    if (!_sharedInstance) {
        _sharedInstance = [[SPDMainModel alloc] init];
        atexit(singleton_remover);
    }
    return _sharedInstance;
}

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        _patchManager = [[SPDPdPatchManager alloc] init];
        _listenerAngle = 0.0;
        _previousAngle = 0.0;
    }
    return self;
}

#pragma mark - Calculating instrument relocations

- (NSDictionary *) calculateInstrument: (NSString *) instrumentName
                          relocationTo: (CGPoint) instrumentLocation
                    relativetoListener: (CGPoint) listenerLocation
{
    NSDictionary *coordinates = [SPDMathUtils calculatePolarCoordinatesForX1:listenerLocation.x
                                                                          Y1:listenerLocation.y
                                                                          X2:instrumentLocation.x
                                                                          Y2:instrumentLocation.y];
    float radius = [[coordinates objectForKey:POLAR_RADIUS_KEY] floatValue];
    float theta  = [[coordinates objectForKey:POLAR_THETA_KEY] floatValue];
    
    NSLog(@"Listener angle: %f, theta: %F", RADIANS_TO_DEGREES(_listenerAngle), theta);
    
    if (theta <= RADIANS_TO_DEGREES(_listenerAngle))
    {
        theta = RADIANS_TO_DEGREES(_listenerAngle) - theta;
        theta *= -1;
    }
    else
    {
        theta = theta - RADIANS_TO_DEGREES(_listenerAngle);
    }

    NSLog(@"unadjusted theta: %f", theta);
    
    theta = [SPDMathUtils forceAngleToITDConstraints:theta];
    
    BOOL isSentToRightEar = YES;
    
    if (theta > 0)
    {
        isSentToRightEar = NO;
    }
    
    NSLog(@"theta: %f", theta);
    
    float ITD = [SPDMathUtils calculateITDValueForRadius:HEAD_RADIUS andTheta:DEGREES_TO_RADIANS(theta)];
    ITD = ABS(ITD);
    ITD *= 1000;
    
    float ampModifier = 1 / ((INSTRUMENT_QUANTITY - 1) * powf(radius, 2));
    
    ampModifier *= 40000;
    
    if (ampModifier > 0.25)
    {
        ampModifier = 0.25;
    }
    
    [_patchManager sendITDValue:ITD toInstrument:instrumentName atEar:isSentToRightEar];
    [_patchManager sendAmplitudeModifierValue:ampModifier toInstrument:instrumentName];
    
    return @{POLAR_RADIUS_KEY : [NSNumber numberWithFloat:radius],
             POLAR_THETA_KEY  : [NSNumber numberWithFloat:theta],
             ITD_KEY          : [NSNumber numberWithFloat:ITD]};
}

- (void) calculateListenerRelocationTo: (CGPoint) listenerLocation
                     forAllInstruments: (NSArray *) instruments
{
    for (NSDictionary *instrument in instruments)
    {
        NSString *instrumentName = [instrument objectForKey:NAME_KEY];
        CGPoint instrumentLocation = [[instrument objectForKey:LOCATION_KEY] CGPointValue];
        
        [self calculateInstrument:instrumentName relocationTo:instrumentLocation relativetoListener:listenerLocation];
    }
}

@end
