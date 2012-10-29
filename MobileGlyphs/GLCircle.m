//
//  GLCircle.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/28/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "GLCircle.h"
#import <math.h>

#define PI 3.1415926

@implementation GLCircle

@synthesize center = _center, radius = _radius, isHollow = _isHollow, lineThickness = _lineThickness;

- (id)initWithCenter:(CGPoint)center andRadius:(float)radius;
{
    self = [super init];
    if (self) {
        _center = center;
        _radius = radius;
        _lineThickness = 1;
        [self computeVertices];
    }
    return self;
}

-(int)numVertices
{
    return numVerticesToDisplay;
}

- (void)setCenter:(CGPoint)center
{
    _center = center;
    [self computeVertices];
}

- (void)setRadius:(float)radius
{
    _radius = radius;
    [self computeVertices];
}

- (void)drawVertices
{
    if (_isHollow) {
        glLineWidth(_lineThickness);
        glDrawArrays(GL_LINE_STRIP, 0, self.numVertices);
    } else {
        [super drawVertices];
    }
}

- (void)computeVertices
{
    // Algorithm borrowed from http://slabode.exofire.net/circle_draw.shtml
    int newNumVertices = 10 * sqrtf(_radius);
    
    //TODO: Dynamically compute the new number of vertices required
    if (newNumVertices != numVerticesToDisplay) {
        // Delete all vertex/color/texture coordinate data so that they get regenerated on next load
        vertexData = nil;
        vertexColorData = nil;
        textureCoordinateData = nil;
        numVerticesToDisplay = newNumVertices;
    }
    
    GLKVector2 *vertices = self.vertices;
    
	float theta = 2 * PI / ((float)newNumVertices - 1); // -1 to ensure we complete the loop
	float tangetial_factor = tanf(theta); //calculate the tangential factor
	float radial_factor = cosf(theta); //calculate the radial factor
	float x = _radius; //we start at angle = 0
    
	float y = 0;
    
	for(int ii = 0; ii < newNumVertices; ii++)
	{
        vertices[ii] = GLKVector2Make(x + _center.x, y + _center.y);
        
		//calculate the tangential vector
		//remember, the radial vector is (x, y)
		//to get the tangential vector we flip those coordinates and negate one of them
        
		float tx = -y;
		float ty = x;
        
		//add the tangential vector
        
		x += tx * tangetial_factor;
		y += ty * tangetial_factor;
        
		//correct using the radial factor
        
		x *= radial_factor;
		y *= radial_factor;
	}
}
@end
