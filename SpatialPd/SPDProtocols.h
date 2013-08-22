//
//  SPDProtocols.h
//  SpatialPd
//
//  Created by Bektur Ryskeldiev on 6/19/13.
//  Copyright (c) 2013 Bektur Ryskeldiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPDInstrumentViewProtocol <NSObject>
@optional
- (void) instrumentMoved: (NSString *) instrumentName
              toLocation: (CGPoint) instrumentLocation;

@end

@protocol SPDListenerAngleProtocol <NSObject>
@optional
- (void) listenerAngleChanged: (float) newAngle;

@end
