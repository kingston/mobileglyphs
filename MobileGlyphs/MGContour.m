//
//  MGContour.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "MGContour.h"
#import "MGCurvePoint.h"

@implementation MGContour

@synthesize points;

- (id)init
{
    self = [super init];
    if (self) {
        points = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)deletePoint:(MGCurvePoint *)point
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"OnCurveUpdated" object:point];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TangentUpdated" object:point];
    [points removeObject:point];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PointDeleted" object:self];
}

- (void)addPoint:(MGCurvePoint *)point
{
    point.contour = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pointUpdated) name:@"OnCurveUpdated" object:point];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pointUpdated) name:@"TangentUpdated" object:point];
    [points addObject:point];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PointAdded" object:self];
}

- (void)pointUpdated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PointUpdated" object:self];
}

@end
