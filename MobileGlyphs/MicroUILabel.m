//
//  MicroUILabel.m
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

// Text code adapted from http://www.codza.com/creating-and-drawing-on-a-new-uiimage

#import "MicroUILabel.h"

@implementation MicroUILabel

@synthesize text, font, color;

- (id)initWithBoundingBox:(CGRect)box
{
    self = [super initWithBoundingBox:box];
    if (self)
    {
        text = @"";
        font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    }
    return self;
}

- (void)setText:(NSString *)_text
{
    text = _text;
    cachedTexture = nil;
}

- (void)onLayoutChanged
{
    [super onLayoutChanged];
    // Reset cache if bounds are changed
    cachedTexture = nil;
}

- (UIImage*)getTextImage
{
    UIGraphicsBeginImageContext(self.boundingBox.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIGraphicsPushContext(context);
    
    float x = 0, y = 0;
    CGSize boundingSize = self.boundingBox.size;
    if (self.isCentered) {
        CGSize size = [text sizeWithFont:font];
        x = (boundingSize.width - size.width) / 2.0;
        y = (boundingSize.height - size.height) / 2.0;
    }
    
    [color set];
    
    [text drawInRect:CGRectMake(x, y, boundingSize.width, boundingSize.height) withFont:font lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentLeft];
    
    UIGraphicsPopContext();
    
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (void)renderToShape:(GLShape *)shape
{
    [super renderToShape:shape];
    
    GLRectangle *rect = [[GLRectangle alloc] init];
    rect.color = GLKVector4Make(1,0,0,0);
    rect.useConstantColor = YES;
    rect.width = self.boundingBox.size.width;
    rect.height = self.boundingBox.size.height;
    if (cachedTexture == nil) {
        [rect setTextureImage:[self getTextImage]];
        cachedTexture = [rect texture];
    } else {
        [rect setTexture: cachedTexture];
    }
    [shape addChild:rect];
}
@end
