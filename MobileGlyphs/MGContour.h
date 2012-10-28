//
//  MGContour.h
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGCurvePoint;

@interface MGContour : NSObject

@property (nonatomic, strong) NSMutableArray *points;

- (void)addPoint:(MGCurvePoint*)point;

- (void)deletePoint:(MGCurvePoint *)point;

@end
