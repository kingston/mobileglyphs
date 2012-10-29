//
//  MGGlyphEditor.h
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/28/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "GLView.h"

@class MGGlyph;
@class MGCurvePoint;
@class MGContourPointView;

@interface MGGlyphEditor : GLView {
    __weak UITouch *currentTouch;
    MGContourPointView *activePointView;
}

@property (nonatomic, strong) MGGlyph *glyph;
@property (nonatomic, readonly) MGCurvePoint *activePoint;

- (id)initWithBoundingBox:(CGRect)box AndGlyph:(MGGlyph*)glyph;

- (void)setActivePointView:(MGContourPointView*)view;

- (void)deleteCurrentPoint;

@end
