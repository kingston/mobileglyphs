//
//  MicroUIButton.h
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "GLView.h"
#import "GLBox.h"
#import "MicroUILabel.h"
#import "MicroUIButtonDelegate.h"

@interface MicroUIButton : GLView {
    GLBox *rect;
    MicroUILabel *label;
}
@property (nonatomic)GLKVector4 normalColor;
@property (nonatomic)GLKVector4 activeColor;
@property (nonatomic)GLKVector4 leftColor;
@property (nonatomic, copy) NSString *buttonText;
@end
