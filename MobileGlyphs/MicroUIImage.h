//
//  MicroUIImage.h
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "GLView.h"
#import "GLRectangle.h"

@interface MicroUIImage : GLView {
    GLKTextureInfo *cachedTexture;
}

@property(nonatomic) UIImage *image;

@end
