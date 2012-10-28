//
//  MGContourPointView.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/28/12.
//  Copyright (c) 2012 ;. All rights reserved.
//

#import "MGContourPointView.h"

#import "MGCurvePoint.h"
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
    _point = point;
    tangentView.point = point;
    if (point) {
        [self onCurveUpdated];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCurveUpdated) name:@"OnCurveUpdated" object:_point];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tangentUpdated) name:@"TangentUpdated" object:_point];
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

- (void)onViewLoaded
{
    circle = [[GLCircle alloc] initWithCenter:CGPointMake(0,0) andRadius:CURVE_POINT_RADIUS];
    circle.color = GLKVector4Make(0.0, 0.0, 0.0, 1.0);
    [shapes addObject:circle];
    
    tangentLine = [[GLLine alloc] init];
    tangentLine.start = CGPointMake(0, 0);
    tangentLine.color = GLKVector4Make(0.8, 0.8, 0.8, 1.0);
    tangentLine.thickness = 1.0;
    [shapes addObject:tangentLine];
    
    [self onCurveUpdated];
    
    tangentView = [[MGTangentPointView alloc] initWithPoint:_point];
    [self addSubView:tangentView];
}

- (void)setIsActive:(BOOL)isActive
{
    _isActive = isActive;
    if (isActive) {
        circle.color = GLKVector4Make(1, 0, 0, 1);
    } else {
        circle.color = GLKVector4Make(0, 0, 0, 1);
    }
}

- (BOOL)hitTestForPoint:(CGPoint)point
{
    return CGPointDistance(self.point.onCurvePoint, point) < CURVE_POINT_HIT_RADIUS;
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

- (void)onDragStart
{
    [[self getGlyphParent] setActivePointView:self];
}

- (void)onLayoutChanged
{
    [super onLayoutChanged];
    circle.center = [self getRelativePointFromAbsolutePoint:_point.onCurvePoint];
}

@end
