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

- (void)tangentializePoint:(MGCurvePoint *)point
{
    int index = [points indexOfObject:point];
    MGCurvePoint *prevPoint = index == 0 ? nil : [points objectAtIndex:index - 1];
    MGCurvePoint *nextPoint = (index == (points.count - 1)) ? nil : [points objectAtIndex:index + 1];
    
    MGCurvePoint *nextNextPoint = (index + 2 >= points.count) ? nil : [points objectAtIndex:index + 2];

    if (point.isTrackingContinuity && prevPoint) [self stretchBackInterceptor:point ToDestination:prevPoint];
    if (nextPoint && nextPoint.isTrackingContinuity && nextNextPoint) [self stretchForwardInterceptor:point ToDestination:nextPoint AndNextNext:nextNextPoint];
}

- (void)stretchBackInterceptor:(MGCurvePoint*)source ToDestination:(MGCurvePoint*)destination
{
    CGPoint p = source.onCurvePoint;
    CGPoint q = source.tangentPoint;
    CGPoint m = destination.onCurvePoint;
    CGPoint n = destination.tangentPoint;
    //TODO: First check if lines are parallel
    
    // After solving way too large simultaneous equations...
    float b = ((m.x - p.x) * (q.y - p.y) - (m.y - p.y) * (q.x - p.x)) / ((q.x - p.x) * (n.y - m.y) - (q.y - p.y) * (n.x - m.x));
    float a = ((n.x - m.x) * b + m.x - p.x) / (q.x - p.x);
    
    // Check for valid conditions to be able to tangentialize
    source.isContinuous =  a < 0 && b > 0;
    if (source.isContinuous) {
        // do good stuff
        destination.tangentPoint = CGPointMake((q.x - p.x) * a + p.x, (q.y - p.y) * a + p.y);
    }
}


- (void)stretchForwardInterceptor:(MGCurvePoint*)source ToDestination:(MGCurvePoint*)destination AndNextNext:(MGCurvePoint*)nextNext;
{
    CGPoint p = destination.onCurvePoint;
    CGPoint q = source.tangentPoint;
    CGPoint m = nextNext.onCurvePoint;
    CGPoint n = nextNext.tangentPoint;
    //TODO: First check if lines are parallel
    
    // After solving way too large simultaneous equations...
    float b = ((m.x - p.x) * (q.y - p.y) - (m.y - p.y) * (q.x - p.x)) / ((q.x - p.x) * (n.y - m.y) - (q.y - p.y) * (n.x - m.x));
    float a = ((n.x - m.x) * b + m.x - p.x) / (q.x - p.x);
    
    // Check for valid conditions to be able to tangentialize
    source.isContinuous =  a < 0 && b < 0;
    if (source.isContinuous) {
        // do good stuff
        destination.tangentPoint = CGPointMake((q.x - p.x) * a + p.x, (q.y - p.y) * a + p.y);
    }
    
    NSLog(@"Tracking a at %f", a);
    NSLog(@"Tracking b at %f", b);
}

@end
