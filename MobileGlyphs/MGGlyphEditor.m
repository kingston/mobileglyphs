//
//  MGGlyphEditor.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/28/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "MGGlyphEditor.h"
#import "MGCurvePoint.h"
#import "MGContourView.h"
#import "MGContourPointView.h"

#import "MGContour.h"
#import "MGGlyph.h"

@implementation MGGlyphEditor

@synthesize glyph = _glyph;

-(id)initWithBoundingBox:(CGRect)box AndGlyph:(MGGlyph *)glyph
{
    self = [super initWithBoundingBox:box];
    if (self) {
        _glyph = glyph;
        // Render all contours and point views
        for (MGContour *contour in glyph.contours) {
            [self addSubView:[[MGContourView alloc] initWithBoundingBox:box AndContour:contour]];
            for (MGCurvePoint *point in contour.points) {
                [self addSubView:[[MGContourPointView alloc] initWithPoint:point]];
            }
        }
    }
    return self;
}

- (void)onTouchStart:(UITouch *)touch atPoint:(CGPoint)point
{
    if (currentTouch != nil) return; // ignore other touches
    currentTouch = touch;
    
    MGContour *activeContour;
    if (activePointView == nil) {
        activeContour = [[MGContour alloc] init];
        [_glyph.contours addObject:activeContour];
        [self.subviews addObject:[[MGContourView alloc] initWithBoundingBox:self.boundingBox AndContour:activeContour]];
    } else {
        activeContour = activePointView.point.contour;
    }
    
    MGCurvePoint *pt = [[MGCurvePoint alloc] init];
    pt.onCurvePoint = point;
    pt.tangentPoint = point;
    [activeContour addPoint:pt];
    
    [self setActivePointView:[[MGContourPointView alloc] initWithPoint:pt]];
    [self addSubView:activePointView];
}

- (void)onTouchMove:(UITouch *)touch atPoint:(CGPoint)point
{
    if (currentTouch != touch) return;
    activePointView.point.tangentPoint = point;
}

- (void)onTouchEnd:(UITouch *)touch atPoint:(CGPoint)point
{
    if (currentTouch != touch) return;
    currentTouch = nil;
}

- (void)deleteCurrentPoint
{
    if (activePointView != nil) {
        MGContour *activeContour = activePointView.point.contour;
        [activeContour deletePoint:activePointView.point];
        if (activeContour.points.count == 0) {
            [_glyph.contours removeObject:activeContour];
            //TODO: Inefficient but works
            MGContourView *viewToRemove;
            for (MGContourView *view in self.subviews) {
                if (view.contour == activeContour) {
                    viewToRemove = view;
                    break;
                }
            }
            [self.subviews removeObject:viewToRemove];
        }
        [self.subviews removeObject:activePointView];
    }
}

- (void)setActivePointView:(MGContourPointView *)view
{
    [activePointView setIsActive:NO];
    activePointView = view;
    [view setIsActive:YES];
}

@end
