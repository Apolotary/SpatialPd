//
//  SPDPdPatchManager.m
//  SpatialPd
//
//  Created by Bektur Ryskeldiev on 6/19/13.
//  Copyright (c) 2013 Bektur Ryskeldiev. All rights reserved.
//

#import "SPDPdPatchManager.h"
#import "PdBase.h"
#import "PDAudioController.h"

@interface SPDPdPatchManager () <PdReceiverDelegate>
{
    PdAudioController *_audioController;
}

- (void) loadPatch;

@end

@implementation SPDPdPatchManager

- (id)init
{
    self = [super init];
    if (self) {
        _audioController = [[PdAudioController alloc] init];
        [_audioController configureAmbientWithSampleRate:44100 numberChannels:2 mixingEnabled:YES];
        
        [PdBase setDelegate:self];
        
        [self loadPatch];
        [_audioController print];
    }
    return self;
}

#pragma mark - PdBase delegate
// receivePrint delegate method to receive "print" messages from Libpd
// for simplicity we are just sending print messages to the debugging console
- (void)receivePrint:(NSString *)message {
	NSLog(@"(pd) %@", message);
}

#pragma mark - PdController
- (void)setAudioActive:(BOOL)active {
	[_audioController setActive:active];
}

- (void) loadPatch
{
    [PdBase openFile:SPATIAL_PATCH path:[[NSBundle mainBundle] bundlePath]];
	[_audioController setActive:YES];
}

#pragma mark - Sending messages


- (void)sendITDValue: (float) itdValue
        toInstrument: (NSString *) instrumentName
               atEar: (BOOL) isRightEar
{
    NSString *messageReceiver = [NSString stringWithFormat:@"%@_ITD_%@", instrumentName, isRightEar ? @"R" : @"L" ];
    
    NSLog(@"Sending ITD: %f \n To: %@", itdValue, messageReceiver);
    
    [PdBase sendFloat:itdValue toReceiver:messageReceiver];
}

- (void)sendAmplitudeModifierValue: (float) ampValue
                      toInstrument: (NSString *) instrumentName
{
    NSString *messageReceiver = [NSString stringWithFormat:@"%@_AMP", instrumentName];
    
    NSLog(@"Sending amplitude modifier: %f \n to: %@", ampValue, instrumentName);
    
    [PdBase sendFloat:ampValue toReceiver:messageReceiver];
}

@end
