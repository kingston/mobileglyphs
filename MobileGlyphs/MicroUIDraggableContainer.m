//
//  MicroUIDraggableContainer.m
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "MicroUIDraggableContainer.h"
#import "MicroUIDraggableLine.h"
#import "MicroUIDraggableBox.h"

@implementation MicroUIDraggableContainer

@synthesize viewArray = _viewArray;

- (NSMutableArray *)viewArray
{
    if (!_viewArray) {
        _viewArray = [[NSMutableArray alloc] init];
    }
    return _viewArray;
}

- (void)onTouchStart:(UITouch *)touch atPoint:(CGPoint)point
{
    if (currentTouch != nil) return; // ignore other touches
    currentTouch = [NSValue valueWithNonretainedObject:touch];
    dragStartTouchPosition = point;
    
    MicroUIDraggableLine *line = [[MicroUIDraggableLine alloc] init];
    //start and end point are relative to the bounding box
    CGPoint startPointInImage = CGPointMake(dragStartTouchPosition.x - self.boundingBox.origin.x, dragStartTouchPosition.y - self.boundingBox.origin.y);
    CGPoint endPointInImage = CGPointMake(point.x - self.boundingBox.origin.x, point.y - self.boundingBox.origin.y);
    line.startPoint = startPointInImage;
    line.endPoint = endPointInImage;
    [line setColor:GLKVector4Make(0., 0., 0., 1.)];
    [self.viewArray addObject:line];
    [self drawViewsInContainer];
}

- (void)onTouchMove:(UITouch *)touch atPoint:(CGPoint)point
{
    if ([currentTouch nonretainedObjectValue] != touch) return;
    MicroUIDraggableLine *line = [[MicroUIDraggableLine alloc] init];
    //start and end point are relative to the bounding box
    CGPoint startPointInImage = CGPointMake(dragStartTouchPosition.x - self.boundingBox.origin.x, dragStartTouchPosition.y - self.boundingBox.origin.y);
    CGPoint endPointInImage = CGPointMake(point.x - self.boundingBox.origin.x, point.y - self.boundingBox.origin.y);
    line.startPoint = startPointInImage;
    line.endPoint = endPointInImage;
    [line setColor:GLKVector4Make(1., 1., 1., 1.)];
    [self.viewArray removeLastObject];
    [self.viewArray addObject:line];
    [self drawViewsInContainer];
}

- (void)onTouchEnd:(UITouch *)touch atPoint:(CGPoint)point
{
    if ([currentTouch nonretainedObjectValue] != touch) return;
    currentTouch = nil;
    
    MicroUIDraggableLine *line = [[MicroUIDraggableLine alloc] init];
    //start and end point are relative to the bounding box
    CGPoint startPointInImage = CGPointMake(dragStartTouchPosition.x - self.boundingBox.origin.x, dragStartTouchPosition.y - self.boundingBox.origin.y);
    CGPoint endPointInImage = CGPointMake(point.x - self.boundingBox.origin.x, point.y - self.boundingBox.origin.y);
    line.startPoint = startPointInImage;
    line.endPoint = endPointInImage;
    [line setColor:GLKVector4Make(0., 0., 0., 1.)];
    [self.viewArray removeLastObject];
    [self.viewArray addObject:line];
    [self drawViewsInContainer];
}

- (void)drawViewsInContainer
{
    [self removeAllSubViews];
    for (MicroUIDraggableView *view in self.viewArray) {
        [self addSubView:view];
    }
}

- (void)removeSelectedViewsInContainer
{
    NSMutableIndexSet *indices = [[NSMutableIndexSet alloc] init];
    for (int i = 0; i < [self.viewArray count]; i++) {
        MicroUIDraggableView *view = self.viewArray[i];
        if (view.class == [MicroUIDraggableLine class]) {
            MicroUIDraggableLine *line = (MicroUIDraggableLine *)view;
            if (line.isSelected) {
                [indices addIndex:i];
            }
        }
    }
    [self.viewArray removeObjectsAtIndexes:indices];
    [self drawViewsInContainer];
}

@end
