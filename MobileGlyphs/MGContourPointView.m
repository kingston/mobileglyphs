//
//  MGContourPointView.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/28/12.
//  Copyright (c) 2012 ;. All rights reserved.
//

#import "MGContourPointView.h"

#import "MGCurvePoint.h"
#import "MGContour.h"
#import "GLCircle.h"
#import "GLLine.h"
#import "GLHelperFunctions.h"
#import "MGGlyphEditor.h"
#import "MGTangentPointView.h"

#define CURVE_POINT_RADIUS 3
#define CURVE_POINT_HIT_RADIUS 20

@implementation MGContourPointView {
    GLCircle *circle;
    GLLine *tangentLine;
}

@synthesize point = _point, isActive = _isActive;

- (id)initWithPoint:(MGCurvePoint*)pt
{
    self = [super initWithBoundingBox:CGRectMake(0, 0, 1, 1)];
    if (self) {
        self.point = pt;
    }
    return self;
}

- (void)setPoint:(MGCurvePoint *)point
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"OnCurveUpdated" object:_point];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TangentUpdated" object:_point];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TrackingUpdated" object:_point];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ContinuousUpdated" object:_point];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StraightUpdated" object:_point];
    _point = point;
    tangentView.point = point;
    if (point) {
        [self onCurveUpdated];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCurveUpdated) name:@"OnCurveUpdated" object:_point];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tangentUpdated) name:@"TangentUpdated" object:_point];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(continuityChanged) name:@"TrackingUpdated" object:_point];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(continuityChanged) name:@"ContinuousUpdated" object:_point];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(straightUpdated) name:@"StraightUpdated" object:_point];
    }
}

- (void)dealloc
{
    self.point = nil;
}

- (void)tangentUpdated
{
    tangentLine.end = [self getRelativePointFromAbsolutePoint:_point.tangentPoint];
}

- (void)onCurveUpdated
{
    self.position = [self.parent getRelativePointFromAbsolutePoint:_point.onCurvePoint];
    tangentLine.end = [self getRelativePointFromAbsolutePoint:_point.tangentPoint];
}

- (void)continuityChanged
{
    if (_point.isTrackingContinuity && !_point.isContinuous) {
        tangentLine.color = GLKVector4Make(1.0, 0.8, 0.8, 1.0);
    } else {
        tangentLine.color = GLKVector4Make(0.8, 0.8, 0.8, 1.0);
    }
}

- (void)straightUpdated
{
    tangentLine.isVisible = !_point.isStraight;
    tangentView.isVisible = !_point.isStraight;
}

- (void)onDragStart
{
    [[self getGlyphParent] setActivePointView:self];
    curvePointOffset = CGPointMake(_point.tangentPoint.x - _point.onCurvePoint.x, _point.tangentPoint.y - _point.onCurvePoint.y);
}

- (CGPoint)dragPosition
{
    return _point.onCurvePoint;
}

- (void)setDragPosition:(CGPoint)dragPosition
{
    _point.onCurvePoint = dragPosition;
    _point.tangentPoint = CGPointMake(_point.onCurvePoint.x + curvePointOffset.x, _point.onCurvePoint.y + curvePointOffset.y);
    [_point.contour tangentializePoint:_point];
}

- (void)onViewLoaded
{
    circle = [[GLCircle alloc] initWithCenter:CGPointMake(0,0) andRadius:CURVE_POINT_RADIUS];
    [shapes addObject:circle];
    
    tangentLine = [[GLLine alloc] init];
    tangentLine.start = CGPointMake(0, 0);
    tangentLine.thickness = 1.0;
    [shapes addObject:tangentLine];
    
    [self onCurveUpdated];
    [self continuityChanged];
    [self straightUpdated];
    
    tangentView = [[MGTangentPointView alloc] initWithPoint:_point];
    [self addSubView:tangentView];
    
    // Reset is active
    self.isActive = _isActive;
}

- (void)setIsActive:(BOOL)isActive
{
    _isActive = isActive;
    if (isActive) {
        circle.color = GLKVector4Make(1, 0, 0, 1);
        tangentLine.isVisible = YES;
    } else {
        circle.color = GLKVector4Make(0, 0, 0, 1);
        tangentLine.isVisible = NO;
        
    }
}

- (BOOL)hitTestForPoint:(CGPoint)point
{
    return CGPointDistance(self.point.onCurvePoint, point) < CURVE_POINT_HIT_RADIUS;
}

- (GLView *)hitTestForTouchAtPoint:(CGPoint)point
{
    // Check subviews independently
    for (GLView *view in [self.subviews reverseObjectEnumerator]) {
        GLView *targettedView = [view hitTestForTouchAtPoint:point];
        if (targettedView) return targettedView;
    }
    if ([self hitTestForPoint:point]) {
        return self;
    }
    return nil;
}

- (MGGlyphEditor*)getGlyphParent
{
    GLView *parent = [self parent];
    while (parent != nil) {
        if ([parent isKindOfClass:[MGGlyphEditor class]]) return (MGGlyphEditor*) parent;
        parent = [parent parent];
    }
    return nil;
}

- (void)onLayoutChanged
{
    [super onLayoutChanged];
    circle.center = [self getRelativePointFromAbsolutePoint:_point.onCurvePoint];
}

@end
