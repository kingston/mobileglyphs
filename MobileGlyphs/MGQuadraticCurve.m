//
//  MGQuadraticCurve.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 ;. All rights reserved.
//

#import "MGQuadraticCurve.h"

@implementation MGQuadraticCurve

@synthesize start = _start, tangent = _tangent, end = _end;

- (id)initWithStart:(CGPoint)start andEnd:(CGPoint)end AndTangent:(CGPoint)tangent
{
    self = [super init];
    if (self) {
        _start = start;
        _tangent = tangent;
        _end = end;
        [self computeVertices];
    }
    return self;
}

- (CGPoint)linearInterpolateFrom:(CGPoint) pt1 To:(CGPoint) pt2 WithT: (float)t
{
    return CGPointMake(pt1.x * (1 - t) + pt2.x * t, pt1.y * (1 - t) + pt2.y * t);
}

- (void)setStart:(CGPoint)start {
    _start = start;
    [self computeVertices];
}

- (void)setTangent:(CGPoint)tangent
{
    _tangent = tangent;
    [self computeVertices];
}

- (void)setEnd:(CGPoint)end {
    _end = end;
    [self computeVertices];
}

- (void)computeVertices
{
    int newNumVertices = 128;
    
    //TODO: Dynamically compute the new number of vertices required
    if (newNumVertices != numVerticesRequired) {
        // Delete all vertex/color/texture coordinate data so that they get regenerated on next load
        vertexData = nil;
        vertexColorData = nil;
        textureCoordinateData = nil;
        numVerticesRequired = newNumVertices;
    }
    
    GLKVector2 *vertices = self.vertices;
    for (int i = 0; i < newNumVertices; i++) {
        CGPoint newPt = [self linearInterpolateFrom:self.start To:self.end WithT:((i + 0.0)/(newNumVertices - 1.0))];
        vertices[i] = GLKVector2Make(newPt.x, newPt.y);
    }
}

- (int)numVertices
{
    return numVerticesRequired;
}

- (void)drawVertices
{
    glLineWidth(3.);
    glDrawArrays(GL_LINE_STRIP, 0, self.numVertices);
}

@end
