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
    [activeContour tangentializePoint:pt];
    
    [self setActivePointView:[[MGContourPointView alloc] initWithPoint:pt]];
    [self addSubView:activePointView];
}

- (void)onTouchMove:(UITouch *)touch atPoint:(CGPoint)point
{
    if (currentTouch != touch) return;
    activePointView.point.tangentPoint = point;
    [activePointView.point.contour tangentializePoint:activePointView.point];
}

- (void)onTouchEnd:(UITouch *)touch atPoint:(CGPoint)point
{
    if (currentTouch != touch) return;
    currentTouch = nil;
}

- (void)deleteCurrentPoint
{
    if (activePointView != nil) {
        MGCurvePoint *pt = activePointView.point;
        MGContour *activeContour = pt.contour;
        [activeContour deletePoint:pt];
        [activePointView setPoint:nil];
        [self.subviews removeObject:activePointView];
        activePointView = nil;
        if (activeContour.points.count == 0) {
            //TODO: Inefficient but works
            MGContourView *viewToRemove;
            for (MGContourView *view in self.subviews) {
                if ([view isKindOfClass:[MGContourView class]] && view.contour == activeContour) {
                    viewToRemove = view;
                    break;
                }
            }
            [self.subviews removeObject:viewToRemove];
            [_glyph.contours removeObject:activeContour];
        } else {
            //TODO: Inefficient but works
            MGCurvePoint *lastPoint = [activeContour.points lastObject];
            for (MGContourPointView *view in self.subviews) {
                if ([view isKindOfClass:[MGContourPointView class]] && view.point == lastPoint) {
                    [self setActivePointView:view];
                    break;
                }
            }
        }
    }
}

- (void)setActivePointView:(MGContourPointView *)view
{
    [activePointView setIsActive:NO];
    activePointView = view;
    [view setIsActive:YES];
}

@end
