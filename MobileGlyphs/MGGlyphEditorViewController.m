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
#import "MGGlyphEditor.h"
#import "MGGlyph.h"

#define BUTTON_HEIGHT 50

@interface MGGlyphEditorViewController ()

@end

@implementation MGGlyphEditorViewController

@synthesize glyph = _glyph;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _glyph = [[MGGlyph alloc] init];
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

- (void)onButtonPress:(CGPoint)point withSender:(GLView *)sender
{
    if (sender == newButton) {
        [editor setActivePointView:nil];
    } else if (sender == deleteButton) {
        [editor deleteCurrentPoint];
    }
}

- (void)setupSubViews:(GLView *)container
{
    // Create glyph editor
    editor = [[MGGlyphEditor alloc] initWithBoundingBox:container.boundingBox AndGlyph:_glyph];
    [container addSubView:editor];
    
    // Create button bar
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
}

@end
