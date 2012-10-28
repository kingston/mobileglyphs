//
//  MGGlyph.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "MGGlyph.h"

@implementation MGGlyph

- (id)init
{
    self = [super init];
    if (self) {
        contours = [[NSMutableArray alloc] init];
    }
    return self;
}

@synthesize contours;

@end
