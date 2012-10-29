//
//  GLViewController.m
//  MicroUI
//
//  Created by Kingston Tam on 10/13/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "GLViewController.h"

@interface GLViewController ()

@end

@implementation GLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setupOpenGL
{
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:context];
    
    GLKView *view = (GLKView*)[self view];
    // TODO: Figure out exact height of the nav bar.
    [view setFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height - 50)];
    [view setContext:context];
    
    graphicsContext = [[GLGraphicsContext alloc] init];
    
    [self setupProjectionMatrix];
}

- (void)setupProjectionMatrix
{
    UIView *view = [self view];
    [graphicsContext setProjectionMatrix:GLKMatrix4MakeOrtho(0, view.bounds.size.width, 0, view.bounds.size.height, 1, -1)];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self setupProjectionMatrix];
}

- (void)setupBaseView
{
    CGRect bounds = [[self view] bounds];
    baseView = [[GLView alloc] initWithBoundingBox:bounds];
    [self setupSubViews:baseView];
}

- (void)setupSubViews:(GLView*)container
{
    // no sub views to add
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setupOpenGL];
    [self setupBaseView];
    
    liveTouches = [[NSMutableDictionary alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    if ([EAGLContext currentContext] != nil) {
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)glkViewControllerUpdate:(GLKViewController *)controller
{
    [baseView updateWithController:controller];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    // We do all our clearing stuff here
    glClearColor(1.0, 1.0, 1.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [baseView render:graphicsContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGPoint)getCoordinatesFromTouch:(UITouch *)touch
{
    CGPoint pt = [touch locationInView:[self view]];
    // Swap vertical axis as iOS does things differently
    pt.y = [self view].bounds.size.height - pt.y;
    return pt;
}

//Tells the receiver when one or more fingers touch down in a view or window.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        CGPoint pt = [self getCoordinatesFromTouch:touch];
        GLView *targettedView = [baseView hitTestForTouchAtPoint:pt];
        [targettedView onTouchStart:touch atPoint:pt];
        if (targettedView != nil) {
            NSLog(@"Detected start of a touch for %@", targettedView);
            
            // Store touch
            NSValue *key = [NSValue valueWithNonretainedObject:touch];
            [liveTouches setObject:targettedView forKey:key];
        }
    }
}

//Sent to the receiver when a system event (such as a low-memory warning) cancels a touch event.
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"touches cancelled");
    [self touchesEnded:touches withEvent:event];
}

//Tells the receiver when one or more fingers are raised from a view or window.
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        GLView *targettedView = [liveTouches objectForKey:key];
        [liveTouches removeObjectForKey:key];
        CGPoint pt = [self getCoordinatesFromTouch:touch];
        [targettedView onTouchEnd:touch atPoint:pt];
    }
}

//Tells the receiver when one or more fingers associated with an event move within a view or window.
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        GLView *targettedView = [liveTouches objectForKey:key];
        CGPoint pt = [self getCoordinatesFromTouch:touch];
        [targettedView onTouchMove:touch atPoint:pt];
    }
}

@end
