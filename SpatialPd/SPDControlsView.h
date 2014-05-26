//
//  SPDControlsView.h
//  SpatialPd
//
//  Created by Bektur Ryskeldiev on 10/12/13.
//  Copyright (c) 2013 Bektur Ryskeldiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPDProtocols.h"

@interface SPDControlsView : UIView
{
    IBOutlet UISwitch *_switchGuitar;
    IBOutlet UISwitch *_switchBass;
    IBOutlet UISwitch *_switchPiano;
    IBOutlet UISwitch *_switchDrums;
}

@property (nonatomic, weak) id<SPDControlsViewProtocol> delegate;

- (IBAction)switchGuitarChanged:(id)sender;
- (IBAction)switchBassChanged:(id)sender;
- (IBAction)switchPianoChanged:(id)sender;
- (IBAction)switchDrumsChanged:(id)sender;

- (void) updateColors;


@end
