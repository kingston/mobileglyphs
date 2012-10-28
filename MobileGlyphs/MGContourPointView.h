//
//  MGContourPointView.h
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/28/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "MicroUIDraggableView.h"

@class MGCurvePoint;
@class MGTangentPointView;

@interface MGContourPointView : MicroUIDraggableView {
    MGTangentPointView *tangentView;
}

@property (nonatomic, strong) MGCurvePoint *point;
@property (nonatomic) BOOL isActive;

- (id)initWithPoint:(MGCurvePoint*)pt;

@end
