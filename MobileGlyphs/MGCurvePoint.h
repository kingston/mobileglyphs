//
//  MGCurvePoint.h
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGContour;

@interface MGCurvePoint : NSObject <NSCoding>

@property (nonatomic) CGPoint onCurvePoint;
@property (nonatomic) CGPoint tangentPoint;

@property (nonatomic) BOOL isTrackingContinuity;
@property (nonatomic) BOOL isContinuous;

@property (nonatomic) BOOL isStraight;

@property (nonatomic, weak) MGContour *contour;

@end
