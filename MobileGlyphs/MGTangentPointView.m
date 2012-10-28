//
//  MGTangentPointView.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/28/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "MGTangentPointView.h"

#import "MGCurvePoint.h"
#import "GLCircle.h"

#define CURVE_POINT_RADIUS 3

@implementation MGTangentPointView

@synthesize point = _point;

- (id)initWithPoint:(MGCurvePoint*)pt
{
    self = [super initWithBoundingBox:CGRectMake(0, 0, 1, 1)];
    if (self) {
        self.point = pt;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tangentUpdated) name:@"TangentUpdated" object:pt];
    }
    return self;
}

- (void)setPoint:(MGCurvePoint *)point
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TangentUpdated" object:_point];
    _point = point;
    if (point) {
        [self tangentUpdated];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tangentUpdated) name:@"TangentUpdated" object:_point];
    }
}

- (void)dealloc
{
    self.point = nil;
}

- (void)tangentUpdated
{
    self.position = [self.parent getRelativePointFromAbsolutePoint:_point.tangentPoint];
}

- (void)onViewLoaded
{
    self.position = [self.parent getRelativePointFromAbsolutePoint:_point.tangentPoint];
    circle = [[GLCircle alloc] initWithCenter:CGPointMake(0,0) andRadius:CURVE_POINT_RADIUS];
    circle.color = GLKVector4Make(0.0, 0.0, 1.0, 1.0);
    circle.isHollow = YES;
    [shapes addObject:circle];
}

@end
