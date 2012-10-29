//
//  MGAddGlyphViewController.m
//  MobileGlyphs
//
//  Created by Abi Raja on 10/28/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "MGAddGlyphViewController.h"
#import "MGGlyphListViewController.h"

@implementation MGAddGlyphViewController
@synthesize delegate;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)createClicked:(id)sender{
    [delegate createGlyph:[(UITextView *)[self.view viewWithTag:1] text]];
}

@end
