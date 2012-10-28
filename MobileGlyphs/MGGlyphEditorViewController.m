//
//  MGGlyphEditorViewController.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "MGGlyphEditorViewController.h"
#import "MicroUIButton.h"
#import "MGContourView.h"

#import "MGContour.h"
#import "MGCurvePoint.h"

#define BUTTON_HEIGHT 50

@interface MGGlyphEditorViewController ()

@end

@implementation MGGlyphEditorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubViews:(GLView *)container
{
    float height = [container size].height;
    float buttonY = height - BUTTON_HEIGHT - 20;
    newButton = [[MicroUIButton alloc] initWithX:10 AndY:buttonY AndWidth:150 AndHeight:BUTTON_HEIGHT];
    [newButton setButtonText:@"New Curve"];
    [newButton setDelegate:self];
    [container addSubView:newButton];
    
    convertPointButton = [[MicroUIButton alloc] initWithX:170 AndY:buttonY AndWidth:150 AndHeight:BUTTON_HEIGHT];
    [convertPointButton setButtonText:@"Convert Point"];
    [convertPointButton setDelegate:self];
    [container addSubView:convertPointButton];
    
    deleteButton = [[MicroUIButton alloc] initWithX:330 AndY:buttonY AndWidth:150 AndHeight:BUTTON_HEIGHT];
    [deleteButton setButtonText:@"Delete Point"];
    [deleteButton setDelegate:self];
    [container addSubView:deleteButton];
    
    //TESTING: Draw sample bezier curve
    MGContour *contour = [[MGContour alloc] init];
    MGCurvePoint *pt = [[MGCurvePoint alloc] init];
    pt.onCurvePoint = CGPointMake(100, 100);
    pt.tangentPoint = CGPointMake(200, 200);
    [contour.points addObject:pt];
    
    pt = [[MGCurvePoint alloc] init];
    pt.onCurvePoint = CGPointMake(300, 200);
    pt.tangentPoint = CGPointMake(300, 200);
    [contour.points addObject:pt];
    
    pt = [[MGCurvePoint alloc] init];
    pt.onCurvePoint = CGPointMake(400, 400);
    pt.tangentPoint = CGPointMake(500, 500);
    [contour.points addObject:pt];
    
    MGContourView *contourView = [[MGContourView alloc] initWithX:0 AndY:0 AndWidth:container.size.width AndHeight:container.size.height];
    contourView.contour = contour;
    [container addSubView:contourView];
}

@end
