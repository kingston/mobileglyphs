//
//  MicroUIDraggableBox.m
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "MicroUIDraggableBox.h"
#import "MicroUIDraggableContainer.h"

@implementation MicroUIDraggableBox

- (id)initWithBoundingBox:(CGRect)box
{
    self = [super initWithBoundingBox:box];
    if (self) {
        boxView = [[GLBox alloc] initWithBoundingBox:box];
        [self addSubView:boxView];
    }
    return self;
}

- (GLKVector4)color
{
    return [boxView color];
}

- (void)setColor:(GLKVector4)color
{
    [boxView setColor:color];
}

@end
