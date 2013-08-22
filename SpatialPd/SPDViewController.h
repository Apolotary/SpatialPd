//
//  SPDViewController.h
//  SpatialPd
//
//  Created by Bektur Ryskeldiev on 6/12/13.
//  Copyright (c) 2013 Bektur Ryskeldiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPDProtocols.h"

@interface SPDViewController : UIViewController <SPDInstrumentViewProtocol, SPDListenerAngleProtocol>
{
    IBOutlet UILabel *_labelInstrument;
    IBOutlet UILabel *_labelRad;
    IBOutlet UILabel *_labelTheta;
    IBOutlet UILabel *_labelITD;
    IBOutlet UILabel *_labelRotationAngle;
    IBOutlet UILabel *_labelAngle;
}

@end
