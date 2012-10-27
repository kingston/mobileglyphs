//
//  GLView.m
//  MicroUI
//
//  Created by Kingston Tam on 10/13/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "GLView.h"

@implementation GLView

@synthesize boundingBox, parent, subviews, delegate;

- (id) init
{
    return [self initWithBoundingBox:CGRectMake(0, 0, 0, 0)];
}

- (id)initWithX:(float)x AndY:(float)y AndWidth:(float)width AndHeight:(float)height
{
    return [self initWithBoundingBox:CGRectMake(x, y, width, height)];
}

- (id) initWithBoundingBox:(CGRect)box
{
    self = [super init];
    if (self) {
        boundingBox = box;
        subviews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setBoundingBox:(CGRect)_boundingBox
{
    boundingBox = _boundingBox;
    [self onLayoutChanged];
}

- (CGPoint)position
{
    return boundingBox.origin;
}

- (void)setPosition:(CGPoint)pt
{
    boundingBox.origin = pt;
    [self onLayoutChanged];
}

- (CGSize)size
{
    return boundingBox.size;
}

- (void)setSize:(CGSize)size
{
    boundingBox.size = size;
    [self onLayoutChanged];
}

- (void)updateWithController:(GLKViewController *)controller
{
    [subviews makeObjectsPerformSelector:@selector(updateWithController:) withObject:controller];
}

- (void)render:(GLGraphicsContext*)context
{
    // Slightly awkward... :/
    
    // By default, render a base shape if we are subclassing
    if ([self class] != [GLView class]) {
        GLShape *baseShape = [[GLShape alloc] init];
        CGRect absBox = self.absoluteBoundingBox;
        baseShape.position = GLKVector2Make(absBox.origin.x, absBox.origin.y);
        [self renderToShape:baseShape];
        [baseShape renderWithContext:context];
    }
    
    // Render sub views afterwards
    [subviews makeObjectsPerformSelector:@selector(render:) withObject:context];
}

- (void)renderToShape:(GLShape *)shape
{
    // No shapes to render :)
}

- (void)addSubView:(GLView *)view
{
    view.parent = self;
    [subviews addObject:view];
}

- (void)removeAllSubViews
{
    [subviews removeAllObjects];
}

- (BOOL)hitTestForPoint:(CGPoint)point
{
    return CGRectContainsPoint(self.absoluteBoundingBox, point);
}

- (GLView *)hitTestForTouchAtPoint:(CGPoint)point
{
    if ([self hitTestForPoint:point]) {
        // Check if any subviews are in bounding box
        // reversed so that we get top most first
        for (GLView *view in [subviews reverseObjectEnumerator]) {
            GLView *targettedView = [view hitTestForTouchAtPoint:point];
            if (targettedView) return targettedView;
        }
        return self;
    }
    return nil;
}

// by default, bubble event up to parent
- (void)onTouchStart:(UITouch*)touch atPoint:(CGPoint)point
{
    if (parent != nil) [parent onTouchStart:touch atPoint:point];
}

- (void)onTouchEnd:(UITouch*)touch atPoint:(CGPoint)point
{
    if (parent != nil) [parent onTouchEnd:touch atPoint:point];
}

- (void)onTouchMove:(UITouch*)touch atPoint:(CGPoint)point
{
    if (parent != nil) [parent onTouchMove:touch atPoint:point];
}

- (CGRect)absoluteBoundingBox
{
    CGRect box = boundingBox;
    if (parent != nil) {
        CGPoint parentOrigin = [parent absoluteBoundingBox].origin;
        CGPoint origin = box.origin;
        box.origin = CGPointMake(parentOrigin.x + origin.x, parentOrigin.y + origin.y);
    }
    return box;
}

- (CGPoint)getRelativePointFromAbsolutePoint:(CGPoint)point
{
    if (parent != nil) {
        point = [parent getRelativePointFromAbsolutePoint:point];
    }
    point.x -= boundingBox.origin.x;
    point.y -= boundingBox.origin.y;
    return point;
}

- (CGPoint)getAbsolutePointFromRelativePoint:(CGPoint)point
{
    if (parent != nil) {
        point = [parent getAbsolutePointFromRelativePoint:point];
    }
    point.x += boundingBox.origin.x;
    point.y += boundingBox.origin.y;
    return point;
}

- (void)onLayoutChanged
{
    // do nothing...
}

@end
