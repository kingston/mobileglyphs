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
@synthesize archiverPath = _archiverPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [[dirPaths objectAtIndex:0] stringByAppendingPathComponent:@"glyph_test"];
        NSKeyedUnarchiver *unarchiver = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (unarchiver != nil){
            _glyph = unarchiver;
        }else{
            _glyph = [[MGGlyph alloc] init];
        }
    }
    return self;
}

- (id) initWithGlyphName:(NSString *) glyphName{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _archiverPath = [[dirPaths objectAtIndex:0] stringByAppendingPathComponent:[glyphName stringByAppendingString:@"_glyph"]];
        NSKeyedUnarchiver *unarchiver = [NSKeyedUnarchiver unarchiveObjectWithFile:_archiverPath];
        if (unarchiver != nil){
            _glyph = unarchiver;
        }else{
            _glyph = [[MGGlyph alloc] init];
        }
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
    } else if (sender == deleteContourButton){
        [editor deleteLastContour];
    } else if (sender == convertPointButton) {
        // Toggle straightness of active point
        MGCurvePoint *activePoint = [editor activePoint];
        if (activePoint) {
            activePoint.isStraight = !activePoint.isStraight;
        }
    } else if (sender == saveButton){
        NSLog(@"Saving this glyph");
        [NSKeyedArchiver archiveRootObject:_glyph toFile:_archiverPath];
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
    
    deleteContourButton = [[MicroUIButton alloc] initWithX:490 AndY:buttonY AndWidth:150 AndHeight:BUTTON_HEIGHT];
    [deleteContourButton setButtonText:@"Delete Contour"];
    [deleteContourButton setDelegate:self];
    [container addSubView:deleteContourButton];
    
    saveButton = [[MicroUIButton alloc] initWithX:650 AndY:buttonY AndWidth:150 AndHeight:BUTTON_HEIGHT];
    [saveButton setButtonText:@"Save"];
    [saveButton setDelegate:self];
    [container addSubView:saveButton];
}

@end
