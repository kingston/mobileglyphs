//
//  GLRectangle.m
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "GLRectangle.h"

@implementation GLRectangle

-(id)init
{
    self = [super init];
    if (self) {
        self.textureCoordinates[0] = GLKVector2Make(0,0);
        self.textureCoordinates[1] = GLKVector2Make(1,0);
        self.textureCoordinates[2] = GLKVector2Make(1,1);
        self.textureCoordinates[3] = GLKVector2Make(0,1);
    }
    return self;
}

@synthesize width, height;

-(void)updateVertices {
    self.vertices[0] = GLKVector2Make(0, 0);
    self.vertices[1] = GLKVector2Make(width, 0);
    self.vertices[2] = GLKVector2Make(width,  height);
    self.vertices[3] = GLKVector2Make(0, height);
}

-(void)setWidth:(float)_width {
    width = _width;
    [self updateVertices];
}

-(void)setHeight:(float)_height {
    height = _height;
    [self updateVertices];
}

@end
