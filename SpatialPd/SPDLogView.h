//
//  SPDLogView.h
//  SpatialPd
//
//  Created by Bektur Ryskeldiev on 10/12/13.
//  Copyright (c) 2013 Bektur Ryskeldiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPDLogView : UIView
{
    IBOutlet UILabel *_labelInstrument;
    IBOutlet UILabel *_labelRad;
    IBOutlet UILabel *_labelTheta;
    IBOutlet UILabel *_labelITD;
    IBOutlet UILabel *_labelListenerAngle;
    IBOutlet UILabel *_labelRotationAngle;
}

- (void) updateInstrumentLabel: (NSString *) instrumentName;
- (void) updateRadLabel:        (CGFloat) radValue;
- (void) updateThetaLabel:      (CGFloat) thetaValue;
- (void) updateITDLabel:        (CGFloat) itdValue;
- (void) updateListenerLabel:   (CGFloat) listenerValue;
- (void) updateRotationLabel:   (CGFloat) rotationValue;

@end
