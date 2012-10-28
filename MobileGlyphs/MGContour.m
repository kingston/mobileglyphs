//
//  MGContour.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "MGContour.h"

@implementation MGContour

@synthesize points;

- (id)init
{
    self = [super init];
    if (self) {
        points = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
