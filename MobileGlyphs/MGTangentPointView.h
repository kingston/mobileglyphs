//
//  MGTangentPointView.h
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/28/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "MicroUIDraggableView.h"

@class MGCurvePoint;
@class GLCircle;

@interface MGTangentPointView : MicroUIDraggableView {
    GLCircle *circle;
}

@property (nonatomic, strong) MGCurvePoint *point;

- (id)initWithPoint:(MGCurvePoint*)pt;

@end
