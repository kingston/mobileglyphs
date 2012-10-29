//
//  MGGlyphEditorViewController.h
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "GLViewController.h"
#import "MicroUIButtonDelegate.h"

@class MicroUIButton;
@class MGGlyphEditor;
@class MGGlyph;

@interface MGGlyphEditorViewController : GLViewController<MicroUIButtonDelegate> {
    MicroUIButton *newButton;
    MicroUIButton *convertPointButton;
    MicroUIButton *deleteButton;
    MicroUIButton *saveButton;
    MGGlyphEditor *editor;
}

@property (nonatomic, strong) MGGlyph *glyph;

@end
