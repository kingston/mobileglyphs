//
//  MGGlyph.h
//  MobileGlyphs
//
//  Created by Kingston Tam on 10/27/12.
//  Copyright (c) 2012 abikt. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CONTOURS_KEY @"contours"

@interface MGGlyph : NSObject <NSCoding>

@property (nonatomic, strong) NSMutableArray *contours;

@end
