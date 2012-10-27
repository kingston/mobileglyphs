//
//  GLBox.m
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "GLBox.h"
#import "GLRectangle.h"
#import <GLKit/GLKit.h>

@implementation GLBox

- (id)initWithBoundingBox:(CGRect)box
{
    self = [super initWithBoundingBox:box];
    if (self) {
        self.color = GLKVector4Make(0, 0, 0, 0);
    }
    return self;
}

@synthesize color;

- (void)renderToShape:(GLShape *)shape
{
    GLRectangle *rect = [[GLRectangle alloc] init];
    rect.width = self.boundingBox.size.width;
    rect.height = self.boundingBox.size.height;
    rect.color = color;
    rect.useConstantColor = YES;
    [shape addChild:rect];
}
@end
