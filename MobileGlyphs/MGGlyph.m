//
//  MGGlyph.m
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import "MGGlyph.h"

@implementation MGGlyph

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:contours forKey:CONTOURS_KEY];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        contours = [aDecoder decodeObjectForKey:CONTOURS_KEY];
    }
    return self;
}

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
