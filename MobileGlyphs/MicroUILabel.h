//
//  MicroUILabel.h
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "GLBox.h"
#import <GLKit/GLKit.h>
#import "GLRectangle.h"

@interface MicroUILabel : GLView {
    GLKTextureInfo *cachedTexture;
}

@property(nonatomic, copy) NSString *text;
@property(nonatomic) UIFont *font;
@property(nonatomic) UIColor *color;

@property(nonatomic) BOOL isCentered;


@end
