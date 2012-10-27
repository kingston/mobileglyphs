//
//  MicroUIDraggableBox.h
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "MicroUIDraggableView.h"
#import "GLBox.h"

@interface MicroUIDraggableBox : MicroUIDraggableView {
    GLBox *boxView;
}

@property (nonatomic)GLKVector4 color;

@end
