//
//  GLViewController.h
//  MicroUI
//
//  Created by Kingston Tam on 10/13/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "GLView.h"

@interface GLViewController : GLKViewController <GLKViewDelegate, GLKViewControllerDelegate> {
    GLView *baseView;
    GLGraphicsContext *graphicsContext;
    NSMutableDictionary *liveTouches;
}

- (void)setupBaseView;
- (void)setupSubViews:(GLView*)container;

@end
