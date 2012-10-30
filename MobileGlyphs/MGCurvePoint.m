//
//  MGCurvePoint.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "MGCurvePoint.h"

@implementation MGCurvePoint

@synthesize onCurvePoint = _onCurvePoint, tangentPoint = _tangentPoint, isTrackingContinuity = _isTrackingContinuity, isContinuous = _isContinuous, isStraight = _isStraight;

- (id)init
{
    self = [super init];
    if (self) {
        _isTrackingContinuity = YES;
        _isContinuous = YES;
        _isStraight = NO;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    // http://stackoverflow.com/questions/448173/encoding-cgpoint-struct-with-nscoder
    [aCoder encodeCGPoint:_onCurvePoint forKey:@"onCurvePoint"];
    [aCoder encodeCGPoint:_tangentPoint forKey:@"tangentPoint"];
    [aCoder encodeBool:_isStraight forKey:@"isStraight"];
    [aCoder encodeObject:_contour forKey:@"contour"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        _tangentPoint = [aDecoder decodeCGPointForKey:@"tangentPoint"];
        _onCurvePoint = [aDecoder decodeCGPointForKey:@"onCurvePoint"];
        _isStraight = [aDecoder decodeBoolForKey:@"isStraight"];
        _contour = [aDecoder decodeObjectForKey:@"contour"];
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

- (void)setIsStraight:(BOOL)isStraight
{
    if (_isStraight == isStraight) return;
    _isStraight = isStraight;
    _isContinuous = NO;
    if (_isStraight) {
        self.tangentPoint = _onCurvePoint;
        _isTrackingContinuity = NO;
    } else {
        // Arbitrarily place tangent
        self.tangentPoint = CGPointMake(_onCurvePoint.x, _onCurvePoint.y + 100);
        _isTrackingContinuity = YES;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"StraightUpdated" object:self];
}

@end
