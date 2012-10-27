//
//  MicroUIImage.m
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "MicroUIImage.h"

@implementation MicroUIImage

- (void)renderToShape:(GLShape *)shape
{
    [super renderToShape:shape];
    
    GLRectangle *rect = [[GLRectangle alloc] init];
    rect.color = GLKVector4Make(1,0,0,0);
    rect.useConstantColor = YES;
    rect.width = self.boundingBox.size.width;
    rect.height = self.boundingBox.size.height;
    if (cachedTexture == nil) {
        [rect setTextureImage:self.image];
        cachedTexture = [rect texture];
    } else {
        [rect setTexture: cachedTexture];
    }
    [shape addChild:rect];
}

@end
