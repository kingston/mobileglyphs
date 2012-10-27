//
//  MicroUIButtonDelegate.h
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MicroUIButtonDelegate <NSObject>

-(void)onButtonPress:(CGPoint)point withSender:(GLView*)sender;

@end
