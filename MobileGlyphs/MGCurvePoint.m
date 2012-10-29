//
//  MGCurvePoint.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "MGCurvePoint.h"

@implementation MGCurvePoint

@synthesize onCurvePoint = _onCurvePoint, tangentPoint = _tangentPoint, isTrackingContinuity = _isTrackingContinuity, isContinuous = _isContinuous;

- (id)init
{
    self = [super init];
    if (self) {
        _isTrackingContinuity = YES;
        _isContinuous = YES;
    }
    return self;
}

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

- (void)setIsTrackingContinuity:(BOOL)isTrackingContinuity
{
    _isTrackingContinuity = isTrackingContinuity;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TrackingUpdated" object:self];
}

- (void)setIsContinuous:(BOOL)isContinuous
{
    _isContinuous = isContinuous;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ContinuousUpdated" object:self];
}

@end
