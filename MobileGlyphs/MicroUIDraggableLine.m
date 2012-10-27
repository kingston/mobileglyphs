//
//  MicroUIDraggableLine.m
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "MicroUIDraggableLine.h"
#import "GLLine.h"
#import "GLQuad.h"
#import <math.h>
#define ENDPOINT_RADIUS 3

@implementation MicroUIDraggableLine

@synthesize startPoint, endPoint;
@synthesize color = _color;
@synthesize isSelected = _isSelected;

- (id)initWithBoundingBox:(CGRect)box
{
    self = [super initWithBoundingBox:box];
    if (self) {
        start = [[MicroUIDraggableEndpoint alloc] initWithCoordinates:CGPointMake(0,0)];
        start.radius = ENDPOINT_RADIUS;
        start.delegate = self;
        [self addSubView:start];
        end = [[MicroUIDraggableEndpoint alloc] initWithCoordinates:CGPointMake(0,0)];
        end.radius = ENDPOINT_RADIUS;
        end.color = GLKVector4Make(1, 1, 1, 1);
        end.delegate = self;
        [self addSubView:end];
    }
    return self;
}

- (void)setStartPoint:(CGPoint)_startPoint
{
    startPoint = _startPoint;
    CGPoint relativePt = [self getRelativePointFromAbsolutePoint:_startPoint];
    [start setPosition:relativePt];
}

- (void)setEndPoint:(CGPoint)_endPoint
{
    endPoint = _endPoint;
    CGPoint relativePt = [self getRelativePointFromAbsolutePoint:_endPoint];
    [end setPosition:relativePt];
}

- (float)squareOfNumber:(float)x
{
    return (x * x);
}

- (float)distanceBetweenPoint:(CGPoint)v AndPoint:(CGPoint)w
{
    return ([self squareOfNumber:(v.x - w.x)] + [self squareOfNumber:(v.y - w.y)]);
    //return (sqr(v.x - w.x) + sqr(v.y - w.y));
}

- (float)distanceFromSegmentToPoint:(CGPoint)testPoint
{
    float l2 = [self distanceBetweenPoint:startPoint AndPoint:endPoint];
    if (l2 == 0.0) return [self distanceBetweenPoint:testPoint AndPoint:startPoint];
    float t = ((testPoint.x - startPoint.x) * (endPoint.x - startPoint.x) + (testPoint.y - startPoint.y) * (endPoint.y - startPoint.y)) / l2;
    if (t < 0) return [self distanceBetweenPoint:testPoint AndPoint:startPoint];
    if (t > 1) return [self distanceBetweenPoint:testPoint AndPoint:endPoint];
    CGPoint projection = CGPointMake(startPoint.x + t * (endPoint.x - startPoint.x), startPoint.y + t * (endPoint.y - startPoint.y));
    return [self distanceBetweenPoint:testPoint AndPoint:projection];
}

- (BOOL)hitTestForPoint:(CGPoint)point
{
    // TODO: Write the algorithm - found here: http://stackoverflow.com/questions/849211/shortest-distance-between-a-point-and-a-line-segment
//    float xmin = fminf(startPoint.x, endPoint.x) - ENDPOINT_RADIUS;
//    float xmax = fmaxf(startPoint.x, endPoint.x) + ENDPOINT_RADIUS;
//    float ymin = fminf(startPoint.y, endPoint.y) - ENDPOINT_RADIUS;
//    float ymax = fmaxf(startPoint.y, endPoint.y) + ENDPOINT_RADIUS;
//    
//    return (xmin < point.x && point.x < xmax && ymin < point.y && point.y < ymax);
    
    NSLog(@"%f", [self distanceFromSegmentToPoint:point]);
    return [self distanceFromSegmentToPoint:point] <= 50;
}

//
//- (void)updateBounds // for hit testing
//{
//    float xmin = fminf([start position].x, [end position].x) - ENDPOINT_RADIUS;
//    float xmax = fmaxf([start position].x, [end position].x) + ENDPOINT_RADIUS;
//    float ymin = fminf([start position].y, [end position].y) - ENDPOINT_RADIUS;
//    float ymax = fmaxf([start position].y, [end position].y) + ENDPOINT_RADIUS;
//    float dx = 0, dy = 0;
//    if (xmin < 0) {
//        dx = xmin;
//    } else if (pt.x > [self size].width) {
//        [self setSize:CGSizeMake(pt.x + ENDPOINT_RADIUS, [self size].height)];
//    }
//    if (pt.y < 0) {
//        dy = pt.y - ENDPOINT_RADIUS;
//    } else if (pt.x > [self size].height) {
//        [self setSize:CGSizeMake([self size].width, pt.y + ENDPOINT_RADIUS)];
//    }
//    if (dx != 0 || dy != 0) {
//        [self setPosition:CGPointMake([self position].x + dx, [self position].y + dy)];
//        
//        // Keep lines exactly where they were
//        [start setPosition:[self getRelativePointFromAbsolutePoint:startPoint]];
//        [end setPosition:[self getRelativePointFromAbsolutePoint:endPoint]];
//    }
//}

- (void)renderToShape:(GLShape *)shape
{
    GLLine *line = [[GLLine alloc] init];
    line.useConstantColor = YES;
    line.color = self.isSelected ? GLKVector4Make(1, 0, 0, 1) : self.color;
    line.start = [self getRelativePointFromAbsolutePoint:self.startPoint];
    line.end = [self getRelativePointFromAbsolutePoint:self.endPoint];
    [shape addChild:line];
}

- (void)onDragMove:(CGPoint)point withSender:(GLView *)sender
{
    startPoint = [self getAbsolutePointFromRelativePoint:[start position]];
    endPoint = [self getAbsolutePointFromRelativePoint:[end position]];
}

- (void)onLayoutChanged
{
    // Update start/end point if we get dragged
    startPoint = [self getAbsolutePointFromRelativePoint:[start position]];
    endPoint = [self getAbsolutePointFromRelativePoint:[end position]];
}

- (void)onTouchStart:(UITouch *)touch atPoint:(CGPoint)point
{
    [super onTouchStart:touch atPoint:point];
    self.isSelected = !self.isSelected;
}

@end
