//
//  MGCurvePoint.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "MGCurvePoint.h"

@implementation MGCurvePoint

@synthesize onCurvePoint = _onCurvePoint, tangentPoint = _tangentPoint;

- (void)setOnCurvePoint:(CGPoint)onCurvePoint
{
    _onCurvePoint = onCurvePoint;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OnCurveUpdated" object:self];
}

- (void)setTangentPoint:(CGPoint)tangentPoint
{
    _tangentPoint = tangentPoint;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TangentUpdated" object:self];
}

@end
