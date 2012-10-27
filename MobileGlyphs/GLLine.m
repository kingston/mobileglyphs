//
//  GLLine.m
//  MicroUI
//
//  Created by Julie Fortuna on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "GLLine.h"

@implementation GLLine

@synthesize start = _start;
@synthesize end = _end;

- (int)numVertices
{
    return 2;
}

- (void)updateVertices
{
    self.vertices[0] = GLKVector2Make(self.start.x, self.start.y);
    self.vertices[1] = GLKVector2Make(self.end.x, self.end.y);
}

- (void)setStart:(CGPoint)start
{
    _start = start;
    [self updateVertices];
}

- (void)setEnd:(CGPoint)end
{
    _end = end;
    [self updateVertices];
}

@end
