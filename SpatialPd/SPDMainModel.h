//
//  SPDMainModel.h
//  SpatialPd
//
//  Created by Bektur Ryskeldiev on 6/19/13.
//  Copyright (c) 2013 Bektur Ryskeldiev. All rights reserved.
//

// Encapsulates work with main application logic,
// mostly math calculation and Pd patch reaction
// to change in sound source locations

#import <Foundation/Foundation.h>
#import "SPDProtocols.h"

@interface SPDMainModel : NSObject

@property (nonatomic, weak) id<SPDListenerAngleProtocol> delegate;
@property CGFloat listenerAngle;

+ (SPDMainModel *) sharedInstance;

- (NSDictionary *) calculateInstrument: (NSString *) instrumentName
                          relocationTo: (CGPoint) instrumentLocation
                    relativetoListener: (CGPoint) listenerLocation;

- (void) calculateListenerRelocationTo: (CGPoint) listenerLocation
                     forAllInstruments: (NSArray *) instruments;   // Dictionaries with name/coordinates pairs

- (void) switchInstrument: (NSString *) instrumentName
                     toOn: (BOOL) isOn;

@end
