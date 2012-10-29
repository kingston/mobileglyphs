//
//  MGAddGlyphViewController.h
//  MobileGlyphs
//
//  Created by Abi Raja on 10/28/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MGGlyphListViewController.h"

@interface MGAddGlyphViewController : UIViewController

@property (nonatomic, strong) MGGlyphListViewController *delegate;

- (IBAction)createClicked:(id)sender;

@end
