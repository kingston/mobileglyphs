//
//  MGContourView.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "MGContour.h"
#import "MGContourView.h"
#import "MGCurvePoint.h"
#import "GLLine.h"
#import "MGQuadraticCurve.h"
#import "GLHelperFunctions.h"

@implementation MGContourView

@synthesize contour = _contour;

- (id)initWithBoundingBox:(CGRect)box AndContour:(MGContour *)contour
{
    self = [super initWithBoundingBox:box];
    if (self) {
        self.contour = contour;
    }
    return self;
}

- (void)setContour:(MGContour *)contour
{
    _contour = contour;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(invalidateShapesCache) name:@"PointDeleted" object:contour];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(invalidateShapesCache) name:@"PointUpdated" object:contour];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(invalidateShapesCache) name:@"PointAdded" object:contour];
}

- (void)invalidateShapesCache
{
    shapesCache = nil;
}

- (void)generateShapesCache
{
    shapesCache = [[NSMutableArray alloc] init];
    // Render all the components of the curve
    NSMutableArray *points = _contour.points;
    for (int i = 0; i < points.count - 1; i++) {
        MGCurvePoint *pt = points[i];
        MGCurvePoint *nextPt = points[i + 1];
        
        // Check if it's linear or quadratic
        if (CGPointEqualToPoint(pt.onCurvePoint, pt.tangentPoint)) {
            GLLine *line = [[GLLine alloc] init];
            line.color = GLKVector4Make(0, 0, 0, 1);
            line.start = pt.onCurvePoint;
            line.end = nextPt.onCurvePoint;
            [shapesCache addObject:line];
        } else {
            MGQuadraticCurve *curve = [[MGQuadraticCurve alloc] initWithStart:pt.onCurvePoint andEnd:nextPt.onCurvePoint AndTangent:pt.tangentPoint];
            curve.color = GLKVector4Make(0, 0, 0, 1);
            [shapesCache addObject:curve];
        }
    }
}

- (void)renderToShape:(GLShape *)shape
{
    if (shapesCache == nil) [self generateShapesCache];
    for (GLShape *subshape in shapesCache) {
        [shape addChild:subshape];
    }
}

- (GLView *)hitTestForTouchAtPoint:(CGPoint)point{
    if ([self hitTestForPoint:point]){
        return self;
    }
    return nil;
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

- (float)distanceFromSegmentStart:(CGPoint)startPoint AndSegmentEnd:(CGPoint)endPoint ToPoint:(CGPoint)testPoint
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
    NSLog(@"Checking if contour was touched");
    // Check subviews independently
    for (GLShape *view in shapesCache) {
        if(view.numVertices > 2){
            for (int i =0; i < view.numVertices; i++){
                GLKVector2 vertex = view.vertices[i];
                if(CGPointDistance(CGPointMake(vertex.x, vertex.y), point) < 20){
                    return YES;
                }
            }
        } else if ([view isKindOfClass:[GLLine class]]) {
            GLLine *line = (GLLine*)view;
            if ([self distanceFromSegmentStart:line.start AndSegmentEnd:line.end ToPoint:point] < 20) return YES;
        }
    }
    
    
    // Make us invisible to clicks
    return NO;
}

- (void)onTouchStart:(UITouch *)touch atPoint:(CGPoint)point
{
    dragStart = point;
}

- (void)onTouchMove:(UITouch *)touch atPoint:(CGPoint)point
{
    CGPoint diff = CGPointMake(point.x - dragStart.x, point.y - dragStart.y);
    dragStart = point;
    
    NSMutableArray *points = _contour.points;
    for (int i = 0; i < points.count; i++) {
        MGCurvePoint *pt = points[i];
        pt.tangentPoint = CGPointMake(pt.tangentPoint.x + diff.x, pt.tangentPoint.y + diff.y);
        pt.onCurvePoint = CGPointMake(pt.onCurvePoint.x + diff.x, pt.onCurvePoint.y + diff.y);
    }
    
    [self invalidateShapesCache];
}

@end
