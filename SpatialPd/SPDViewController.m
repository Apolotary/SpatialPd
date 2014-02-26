//
//  SPDViewController.m
//  SpatialPd
//
//  Created by Bektur Ryskeldiev on 6/12/13.
//  Copyright (c) 2013 Bektur Ryskeldiev. All rights reserved.
//

#import "SPDViewController.h"
#import "SPDInstrumentView.h"
#import "SPDControlsView.h"
#import "SPDLogView.h"
#import "SPDMainModel.h"

//TODO: remove later
#import "SPDMathUtils.h"

@interface SPDViewController () <UIGestureRecognizerDelegate, SPDControlsViewProtocol>
{
    SPDMainModel        *_mainModel;
    SPDInstrumentView   *_listenerView;
    SPDControlsView     *_controlsView;
    SPDLogView          *_logView;
    
    NSMutableArray      *_instrumentViewsArray;
    NSMutableDictionary *_prevGestureLocations;
    CGFloat              _listenerAngle;
}

- (void) panDetected: (id) sender;

@end

@implementation SPDViewController

#pragma mark - Placing instrument objects

- (id) loadNibForInstrumentView
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"SPDInstrumentView" owner:nil options:nil];
    
    for (id obj in nibs)
    {
        if ([obj isKindOfClass:[SPDInstrumentView class]])
        {
            return (SPDInstrumentView *) obj;
        }
    }
    return [NSNull null];
}

- (void) placeInstrumentViews
{
    //TODO: pass array from somewhere else (like JSON/plist for instance), using hardcode for now
    
    NSArray *instrumentNames = @[NAME_BASS, NAME_DRUMS, NAME_GUITAR, NAME_LISTENER, NAME_PIANO];
    NSArray *instrumentColors = @[[UIColor redColor], [UIColor blueColor], [UIColor orangeColor], [UIColor lightGrayColor], [UIColor greenColor]];
    NSMutableArray *instrumentLocations = [[NSMutableArray alloc] init];
    
    [instrumentLocations addObject:[NSValue valueWithCGPoint:CGPointMake(200, 200)]];
    [instrumentLocations addObject:[NSValue valueWithCGPoint:CGPointMake(600, 200)]];
    [instrumentLocations addObject:[NSValue valueWithCGPoint:CGPointMake(200, 500)]];
    [instrumentLocations addObject:[NSValue valueWithCGPoint:CGPointMake(350, 350)]];
    [instrumentLocations addObject:[NSValue valueWithCGPoint:CGPointMake(600, 500)]];
    
    for (int i = 0; i < INSTRUMENT_QUANTITY; i++)
    {
        id obj = [self loadNibForInstrumentView];
        
        if ([obj isKindOfClass:[SPDInstrumentView class]])
        {
            SPDInstrumentView *instrView = (SPDInstrumentView *) obj;
            
            UIColor *instrColor = [instrumentColors objectAtIndex:i];
            CGPoint instrCenter = [[instrumentLocations objectAtIndex:i] CGPointValue];
            
            [self.view addSubview:instrView];
            [instrView setCenter:instrCenter];
            [instrView setColor:instrColor andName:[instrumentNames objectAtIndex:i]];
            [instrView setDelegate:self];
            
            UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
            [panRecognizer setMaximumNumberOfTouches:1];
            [instrView addGestureRecognizer:panRecognizer];
            
            if ([instrView.name isEqualToString:NAME_LISTENER])
            {
                [instrView drawCenter];
                UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationDetected:)];
                _listenerView = instrView;
                [self.view addGestureRecognizer:rotationRecognizer];
            }
            
            [_instrumentViewsArray addObject:instrView];
        }
    }

    NSLog(@"%@", _instrumentViewsArray.description);
}

#pragma mark - Placing helper views

- (void) placeHelperViews
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"SPDLogView" owner:nil options:nil];
    
    for (id obj in nibs)
    {
        if ([obj isKindOfClass:[SPDLogView class]])
        {
            _logView = (SPDLogView *) obj;
        }
    }
    
    nibs = [[NSBundle mainBundle] loadNibNamed:@"SPDControlsView" owner:nil options:nil];
    
    for (id obj in nibs)
    {
        if ([obj isKindOfClass:[SPDControlsView class]])
        {
            _controlsView = (SPDControlsView *) obj;
            [_controlsView updateColors];
            [_controlsView setDelegate:self];
        }
    }
    
    [self.view addSubview:_controlsView];
    [self.view addSubview:_logView];
    [_controlsView setCenter:CGPointMake(self.view.frame.size.width - _controlsView.bounds.size.width / 2, _logView.bounds.size.height / 2)];
    [_logView setCenter:CGPointMake(self.view.frame.size.width - _controlsView.bounds.size.width / 2, self.view.frame.size.height - _controlsView.bounds.size.height / 2)];
}

#pragma mark - Instrument location methods

- (NSArray *) gatherInstrumentLocationsExceptListener
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (SPDInstrumentView *instrView in _instrumentViewsArray)
    {
        if (![instrView.name isEqualToString:NAME_LISTENER])
        {
            [tmpArray addObject:@{NAME_KEY : instrView.name, LOCATION_KEY : [NSValue valueWithCGPoint:instrView.center]}];
        }
    }
    return (NSArray *) tmpArray;
}

#pragma mark - Instrument View Protocol

- (void) instrumentMoved: (NSString *) instrumentName
              toLocation: (CGPoint) instrumentLocation
{
    NSLog(@"instrument: %@ location: %f, %f", instrumentName, instrumentLocation.x, instrumentLocation.y);
    
    if (![instrumentName isEqual:NAME_LISTENER]) // calculate instrument relocation with static listener
    {
        NSDictionary *dictionary = [_mainModel calculateInstrument:instrumentName
                                                      relocationTo:instrumentLocation
                                                relativetoListener:_listenerView.center];
        
//        [_labelInstrument setText:[NSString stringWithFormat:@"Instrument: %@", instrumentName]];
        
        float radius = [[dictionary objectForKey:POLAR_RADIUS_KEY] floatValue];
        float theta  = [[dictionary objectForKey:POLAR_THETA_KEY] floatValue];
        float ITD    = [[dictionary objectForKey:ITD_KEY] floatValue];
        
//        [_labelRad setText:[NSString stringWithFormat:@"Rad: %f", radius]];
//        [_labelTheta setText:[NSString stringWithFormat:@"θ: %f", theta]];
//        [_labelITD setText:[NSString stringWithFormat:@"ITD: %f", ITD]];
        
        [_logView updateInstrumentLabel:instrumentName];
        [_logView updateRadLabel:radius];
        [_logView updateThetaLabel:theta];
        [_logView updateITDLabel:ITD];
    }
    else // calculate listener's relocation for all instruments
    {
        NSArray *instrumentsLocationsArray = [self gatherInstrumentLocationsExceptListener];
        
//        [_labelInstrument setText:[NSString stringWithFormat:@"Instrument: %@", instrumentName]];
//        
//        [_labelRad setText:[NSString stringWithFormat:@"Rad: not applicable"]];
//        [_labelTheta setText:[NSString stringWithFormat:@"θ: not applicable"]];
//        [_labelITD setText:[NSString stringWithFormat:@"ITD: not applicable"]];
        
        [_logView updateInstrumentLabel:instrumentName];
        [_logView updateRadLabel:0.0];
        [_logView updateThetaLabel:0.0];
        [_logView updateITDLabel:0.0];
        
        [_mainModel calculateListenerRelocationTo:instrumentLocation
                                forAllInstruments:instrumentsLocationsArray];
    }
}

#pragma mark - Listener angle delegate

- (void) listenerAngleChanged:(float)newAngle
{
    NSLog(@"-- Angle: %f", RADIANS_TO_DEGREES(newAngle));
 
    
//    [_labelRotationAngle setText:[NSString stringWithFormat:@"Rotation angle: %f", RADIANS_TO_DEGREES(newAngle)]];
    [_logView updateRotationLabel:RADIANS_TO_DEGREES(newAngle)];
    
    _listenerAngle += RADIANS_TO_DEGREES(newAngle);
    
    if (ABS(_listenerAngle) > 360)
    {
        float intpart = 0.0;
        float fractpart = modff(_listenerAngle, &intpart);
        _listenerAngle = (int)intpart % 360 + fractpart;
    }
    
    if (_listenerAngle < 0)
    {
        _listenerAngle += 360;
    }
    
    NSLog(@"-- Listener Angle: %f", _listenerAngle);
    
    _listenerView.transform = CGAffineTransformRotate(_listenerView.transform, newAngle);

    [_logView updateListenerLabel:_listenerAngle];
    
    [_mainModel setListenerAngle:DEGREES_TO_RADIANS(_listenerAngle)];
    [self instrumentMoved:NAME_LISTENER toLocation:_listenerView.center];
}

#pragma mark - Gesture recognizer

- (void) rotationDetected: (id) sender
{
    if ([sender isKindOfClass:[UIRotationGestureRecognizer class]])
    {
        UIRotationGestureRecognizer *rotationGesture = (UIRotationGestureRecognizer *) sender;
        
        float rotationAngle = [rotationGesture rotation];
        NSLog(@"rotation angle: %f", rotationAngle);
        
        rotationGesture.rotation = 0;
        
        [self listenerAngleChanged:rotationAngle];
    }
}

- (void) panDetected: (id) sender
{
    if ([sender isKindOfClass:[UIPanGestureRecognizer class]])
    {
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *) sender;
        
        SPDInstrumentView *instrumentView = (SPDInstrumentView *) panGesture.view;
        
        CGPoint translation = [panGesture translationInView:self.view];
        CGPoint imageViewPosition = instrumentView.center;
        imageViewPosition.x += translation.x;
        imageViewPosition.y += translation.y;
        
        instrumentView.center = imageViewPosition;
        [panGesture setTranslation:CGPointZero inView:self.view];
        
        [instrumentView updateLocationLabels];
        [self instrumentMoved:instrumentView.name toLocation:instrumentView.center];
    }
}

#pragma mark - Controls view protocol

- (void) instrument: (NSString *) instrumentName
    wasSwitchedToOn: (BOOL) isOn
{
    [_mainModel switchInstrument:instrumentName toOn:isOn];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _mainModel = [SPDMainModel sharedInstance];
    [_mainModel setDelegate:self];
    _instrumentViewsArray = [[NSMutableArray alloc] init];
    _prevGestureLocations = [[NSMutableDictionary alloc] init];
    [self placeHelperViews];
	[self placeInstrumentViews];
    
    NSArray *instruments = [self gatherInstrumentLocationsExceptListener];
    
    _listenerAngle = 0;
    
    [_mainModel calculateListenerRelocationTo:_listenerView.center forAllInstruments:instruments];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
