//
//  MGContourView.h
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "GLView.h"
@class MGContour;

@interface MGContourView : GLView {
    NSMutableArray *shapesCache;
    CGPoint dragStart;
}

- (id)initWithBoundingBox:(CGRect)box AndContour:(MGContour*)contour;
- (void)invalidateShapesCache;

@property (nonatomic, strong) MGContour *contour;

@end
