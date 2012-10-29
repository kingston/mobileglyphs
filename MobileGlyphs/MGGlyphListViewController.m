//
//  MGGlyphListViewController.m
//  MobileGlyphs
//
//  Created by Abi Raja on 10/28/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "MGGlyphListViewController.h"

#import "MGGlyphEditorViewController.h"
#import "MGAddGlyphViewController.h"
#import "MGAppDelegate.h"


@implementation MGGlyphListViewController

@synthesize glyphs;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                   NSUserDomainMask, YES);
    NSString *path = [[dirPaths objectAtIndex:0] stringByAppendingPathComponent:@"glyph_list"];
    glyphs = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (glyphs == nil){
        glyphs = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"New"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(addGlyph)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void) addGlyph{
    NSLog(@"Add a new glyph");
    MGAddGlyphViewController *addController = [[MGAddGlyphViewController alloc] initWithNibName:@"MGAddGlyphViewController" bundle:nil];
    addController.delegate = self;
    addController.modalPresentationStyle =  UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:addController animated:YES];
    
}

- (void) createGlyph: (NSString *) name{
    [self dismissModalViewControllerAnimated:YES];
    [glyphs addObject:name];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[dirPaths objectAtIndex:0] stringByAppendingPathComponent:@"glyph_list"];
    [NSKeyedArchiver archiveRootObject:glyphs toFile:path];

    [self.tableView reloadData];
    
    [self openGlyphEditor:name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [glyphs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setText:[glyphs objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self openGlyphEditor:[glyphs objectAtIndex:indexPath.row]];
}

- (void) openGlyphEditor:(NSString *) name{
    MGAppDelegate *del = (MGAppDelegate *)[UIApplication sharedApplication].delegate;
    MGGlyphEditorViewController *editorController = [[MGGlyphEditorViewController alloc] initWithGlyphName:name];
    editorController.title = [@"Edit " stringByAppendingString:name];
    [del.navController pushViewController:editorController animated:YES];
    // TODO: Store the Glyph
}

@end
