//
//  MGGlyphListViewController.h
//  MobileGlyphs
//
//  Created by Abi Raja on 10/28/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGGlyphListViewController : UITableViewController{
    NSMutableArray *glyphs;
}

@property (nonatomic, strong) NSMutableArray *glyphs;
- (void) createGlyph:(NSString *) name;

@end
