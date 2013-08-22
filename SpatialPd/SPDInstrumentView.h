//
//  SPDInstrumentView.h
//  SpatialPd
//
//  Created by Bektur Ryskeldiev on 6/14/13.
//  Copyright (c) 2013 Bektur Ryskeldiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPDProtocols.h"

@interface SPDInstrumentView : UIView
{
    IBOutlet UIImageView *_circleView;
    IBOutlet UILabel     *_labelInstrument;
    IBOutlet UILabel     *_labelXPosition;
    IBOutlet UILabel     *_labelYPosition;
    NSString             *_name;
    UIImage              *_icon;
    CGPoint              _startLocation;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage  *icon;
@property (nonatomic, weak) id<SPDInstrumentViewProtocol> delegate;

@property (nonatomic) UIImageView *circleView;
@property (nonatomic) UILabel     *labelInstrument;

- (void) setImage: (UIImage *)  image
          andName: (NSString *) name;
- (void) updateLocationLabels;

@end
