//
//  MGGlyphEditorViewController.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "MGGlyphEditorViewController.h"
#import "MicroUIButton.h"

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
}

@end
