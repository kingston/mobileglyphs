//
//  MGQuadraticCurve.h
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "GLShape.h"

@interface MGQuadraticCurve : GLShape {
    int numVerticesRequired;
}

@property (nonatomic) CGPoint start;
@property (nonatomic) CGPoint tangent;
@property (nonatomic) CGPoint end;

- initWithStart:(CGPoint)start andEnd:(CGPoint)end AndTangent:(CGPoint)tangent;

@end
