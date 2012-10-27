//
//  MicroUIDraggableView.h
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "GLView.h"
#import "MicroUIDraggableContainer.h"
#import "MicroUIDraggableDelegate.h"

@interface MicroUIDraggableView : GLView {
    NSValue *currentTouch;
    CGPoint dragStartBoxPosition;
    CGPoint dragStartTouchPosition;
}

@end
