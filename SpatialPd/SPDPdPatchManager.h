//
//  SPDPdPatchManager.h
//  SpatialPd
//
//  Created by Bektur Ryskeldiev on 6/19/13.
//  Copyright (c) 2013 Bektur Ryskeldiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPDPdPatchManager : NSObject

- (void)setAudioActive:(BOOL)active;

- (void)sendITDValue: (float) itdValue
        toInstrument: (NSString *) instrumentName
               atEar: (BOOL) isRightEar;

- (void)sendAmplitudeModifierValue: (float) ampValue
                      toInstrument: (NSString *) instrumentName;

- (void)sendSwitchValue: (BOOL) isOn
           toInstrument: (NSString *) instrumentName;

@end
