//
//  MGCurvePoint.h
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGContour;

@interface MGCurvePoint : NSObject

@property (nonatomic) CGPoint onCurvePoint;
@property (nonatomic) CGPoint tangentPoint;

@property (nonatomic, weak) MGContour *contour;

@end
