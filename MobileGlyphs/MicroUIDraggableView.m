//
//  MicroUIDraggableView.m
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "MicroUIDraggableView.h"

@implementation MicroUIDraggableView

- (id)initWithBoundingBox:(CGRect)box
{
    self = [super initWithBoundingBox:box];
    if (self) {
        currentTouch = nil;
    }
    return self;
}

- (MicroUIDraggableContainer*)findDraggableContainer
{
    GLView *parent = [self parent];
    while (parent != nil) {
        if ([parent isKindOfClass:[MicroUIDraggableContainer class]]) return (MicroUIDraggableContainer*) parent;
        parent = [parent parent];
    }
    return nil;
}

- (void)onDragStart
{
    // Do nothing
}

- (void)onTouchStart:(UITouch *)touch atPoint:(CGPoint)point
{
    if (currentTouch != nil) return; // ignore other touches
    currentTouch = [NSValue valueWithNonretainedObject:touch];
    dragStartBoxPosition = self.boundingBox.origin;
    dragStartTouchPosition = point;
    [self onDragStart];
}

- (void)onTouchMove:(UITouch *)touch atPoint:(CGPoint)point
{
    if ([currentTouch nonretainedObjectValue] != touch) return;
    CGPoint newPt = dragStartBoxPosition;
    
    MicroUIDraggableContainer *container = [self findDraggableContainer];
    // Only move it if it is within the container
    if (!container || [container hitTestForPoint:point]) {
        newPt.x += point.x - dragStartTouchPosition.x;
        newPt.y += point.y - dragStartTouchPosition.y;
    }
    
    [self setPosition:newPt];
    
    if ([[self delegate] respondsToSelector:@selector(onDragMove:withSender:)]) {
        [[self delegate] onDragMove:newPt withSender:self];
    }
}

- (void)onTouchEnd:(UITouch *)touch atPoint:(CGPoint)point
{
    if ([currentTouch nonretainedObjectValue] != touch) return;
    currentTouch = nil;
}

@end
