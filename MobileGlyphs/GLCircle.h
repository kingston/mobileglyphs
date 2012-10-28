//
//  GLCircle.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/28/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "GLShape.h"

@interface GLCircle : GLShape {
    int numVerticesToDisplay;
}

@property (nonatomic)CGPoint center;
@property (nonatomic)float radius;

@property (nonatomic)BOOL isHollow;
@property (nonatomic)float lineThickness;

- (id)initWithCenter:(CGPoint)center andRadius:(float)radius;

@end
