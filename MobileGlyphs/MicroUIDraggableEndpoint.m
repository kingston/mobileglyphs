//
//  MicroUIDraggableEndpoint.m
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "MicroUIDraggableEndpoint.h"
#import <math.h>

@implementation MicroUIDraggableEndpoint

@synthesize radius;

- (id)initWithCoordinates:(CGPoint)pt
{
    self = [super initWithBoundingBox:CGRectMake(pt.x, pt.y, 1, 1)];
    if (self) {
        boxView = [[GLBox alloc] initWithBoundingBox:CGRectMake(-1, -1, 1, 1)];
        [boxView setColor:GLKVector4Make(0, 0, 0, 1)];
        
        [self addSubView:boxView];
        radius = 3;
    }
    return self;
}

- (GLKVector4)color
{
    return [boxView color];
}

- (void)setColor:(GLKVector4)color
{
    [boxView setColor:color];
}

- (void)setRadius:(float)_radius
{
    radius = _radius;
    [self onLayoutChanged];
}

- (void)onLayoutChanged
{
    actualRect = CGRectMake(-radius, -radius, radius * 2, radius * 2);
    [boxView setBoundingBox:actualRect];
}

-(BOOL)hitTestForPoint:(CGPoint)point
{
    if (self.parent != nil) point = [[self parent] getRelativePointFromAbsolutePoint:point];
    return (point.x - [self position].x) * (point.x - [self position].x) + (point.y - [self position].y) * (point.y - [self position].y) < 100;
}

@end
