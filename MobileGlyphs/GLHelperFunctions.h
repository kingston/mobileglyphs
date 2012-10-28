//
//  GLHelperFunctions.h
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/28/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#ifndef MobileGlyphs_GLHelperFunctions_h
#define MobileGlyphs_GLHelperFunctions_h

#import <Foundation/Foundation.h>
#import <math.h>

CGFloat CGPointDistance(CGPoint pt1, CGPoint pt2)
{
    CGFloat dx = pt2.x - pt1.x;
    CGFloat dy = pt2.y - pt1.y;
    return sqrtf(dx * dx + dy * dy);
}

#endif
