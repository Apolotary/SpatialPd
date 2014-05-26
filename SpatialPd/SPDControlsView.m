//
//  SPDControlsView.m
//  SpatialPd
//
//  Created by Bektur Ryskeldiev on 10/12/13.
//  Copyright (c) 2013 Bektur Ryskeldiev. All rights reserved.
//

#import "SPDControlsView.h"

@implementation SPDControlsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [_switchGuitar setOnTintColor:[UIColor orangeColor]];
        [_switchBass setOnTintColor:[UIColor redColor]];
        [_switchDrums setOnTintColor:[UIColor blueColor]];
        [_switchPiano setOnTintColor:[UIColor greenColor]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)switchGuitarChanged:(id)sender
{
    [_delegate instrument:NAME_GUITAR wasSwitchedToOn:_switchGuitar.isOn];
}

- (IBAction)switchBassChanged:(id)sender
{
    [_delegate instrument:NAME_BASS wasSwitchedToOn:_switchBass.isOn];
}

- (IBAction)switchPianoChanged:(id)sender
{
    [_delegate instrument:NAME_PIANO wasSwitchedToOn:_switchPiano.isOn];
}

- (IBAction)switchDrumsChanged:(id)sender
{
    [_delegate instrument:NAME_DRUMS wasSwitchedToOn:_switchDrums.isOn];
}

- (void) updateColors
{
    [_switchGuitar setOnTintColor:[UIColor orangeColor]];
    [_switchBass setOnTintColor:[UIColor redColor]];
    [_switchDrums setOnTintColor:[UIColor blueColor]];
    [_switchPiano setOnTintColor:[UIColor greenColor]];
}

@end
