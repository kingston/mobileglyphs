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

@implementation MGContourView

@synthesize contour = _contour;

- (void)renderToShape:(GLShape *)shape
{
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
            [shape addChild:line];
        } else {
            MGQuadraticCurve *curve = [[MGQuadraticCurve alloc] initWithStart:pt.onCurvePoint andEnd:nextPt.onCurvePoint AndTangent:pt.tangentPoint];
            curve.color = GLKVector4Make(0, 0, 0, 1);
            [shape addChild:curve];
        }
    }
}

@end
