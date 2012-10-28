//
//  GLCurve.h
//  MobileGlyphs
//
//  Created by Abi Raja on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "GLShape.h"

@interface GLCurve : GLShape

@property (nonatomic) CGPoint start;
@property (nonatomic) CGPoint tangent;
@property (nonatomic) CGPoint end;

@end
