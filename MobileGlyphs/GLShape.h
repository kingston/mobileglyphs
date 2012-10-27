//
//  GLShape.h
//  MicroUI
//
//  Created by Kingston Tam on 10/13/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

// Borrowing the general concept from the tutorial: http://games.ianterrell.com/2d-game-engine-tutorial/

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "GLGraphicsContext.h"

@interface GLShape : NSObject {
    NSMutableData *vertexData, *vertexColorData, *textureCoordinateData;
}

@property(nonatomic, readonly) int numVertices;
@property(nonatomic, readonly) GLKVector2 *vertices;
@property(nonatomic, readonly) GLKVector4 *vertexColors;
@property(nonatomic, readonly) GLKVector2 *textureCoordinates;
@property(nonatomic) GLKVector4 color;
@property(nonatomic) BOOL useConstantColor;
@property(nonatomic, strong) GLKTextureInfo *texture;

@property(nonatomic) GLKVector2 position;

@property(nonatomic, weak) GLShape *parent;
@property(nonatomic, strong, readonly) NSMutableArray *children;

- (void)renderWithContext:(GLGraphicsContext*)context;
- (void)addChild:(GLShape *)child;
- (void)setTextureImage:(UIImage *)image;

@end
