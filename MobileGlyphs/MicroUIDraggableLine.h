//
//  MicroUIDraggableLine.h
//  MicroUI
//
//  Created by Kingston Tam on 10/14/12.
//  Copyright (c) 2012 KT & JF Inc. All rights reserved.
//

#import "MicroUIDraggableView.h"
#import "MicroUIDraggableEndpoint.h"
#import "MicroUIDraggableDelegate.h"

@interface MicroUIDraggableLine : MicroUIDraggableView<MicroUIDraggableDelegate> {
    MicroUIDraggableEndpoint *start;
    MicroUIDraggableEndpoint *end;
}

@property(nonatomic) CGPoint startPoint;
@property(nonatomic) CGPoint endPoint;

@property (nonatomic) GLKVector4 color;
@property (nonatomic) BOOL isSelected;

@end
