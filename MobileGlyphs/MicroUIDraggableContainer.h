//
//  MicroUIDraggableContainer.h
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "GLView.h"

// Contains draggable objects and doesn't let them out.

@interface MicroUIDraggableContainer : GLView {
    NSValue *currentTouch;
    CGPoint dragStartTouchPosition;
}

@property (nonatomic, strong) NSMutableArray *viewArray;

- (void)drawViewsInContainer;

- (void)removeSelectedViewsInContainer;

@end
