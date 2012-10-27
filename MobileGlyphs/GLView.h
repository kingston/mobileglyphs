//
//  GLView.h
//  MicroUI
//
//  Created by Kingston Tam on 10/13/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "GLShape.h"
#import "GLGraphicsContext.h"

@interface GLView : NSObject

@property (nonatomic)CGRect boundingBox; // NB: Bounding box is relative to parent view
@property (nonatomic, weak)GLView *parent;
@property (nonatomic, readonly, strong)NSMutableArray *subviews;
@property (nonatomic)id delegate;
@property (nonatomic)CGPoint position;
@property (nonatomic)CGSize size;

- (id)initWithX:(float)x AndY:(float)y AndWidth:(float)width AndHeight:(float)height;

- (id)initWithBoundingBox:(CGRect)box;

- (void)updateWithController:(GLKViewController*)controller;

- (void)render:(GLGraphicsContext*)context;

- (void)renderToShape:(GLShape*)shape;

- (void)addSubView:(GLView*)view;

- (void)removeAllSubViews;

- (CGRect)absoluteBoundingBox;

- (BOOL)hitTestForPoint:(CGPoint)point;

- (GLView *)hitTestForTouchAtPoint:(CGPoint)point;

- (void)onTouchStart:(UITouch*)touch atPoint:(CGPoint)point;

- (void)onTouchMove:(UITouch*)touch atPoint:(CGPoint)point;

- (void)onTouchEnd:(UITouch*)touch atPoint:(CGPoint)point;

- (void)onLayoutChanged; // called when the position, width, or height is changed

- (CGPoint)getRelativePointFromAbsolutePoint:(CGPoint)point;

- (CGPoint)getAbsolutePointFromRelativePoint:(CGPoint)point;

@end