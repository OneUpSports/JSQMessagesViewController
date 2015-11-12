//
//  JSQFrameConstraint.h
//  JSQMessages
//
//  Created by Luke McDonald on 11/11/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#ifndef JSQStructs_h
#define JSQStructs_h

#define CGSpaceZero CGSpaceZeroMake(0.0, 0.0, 0.0, 0.0)
#define JSQFrameConstraintZero JSQFrameConstraintMake(CGSpaceZero,CGSizeZero)
#define JSQMessagesAvatarBorderNull JSQMessagesAvatarBorderMake(0.0, nil, nil)


// __unsafe_unretained

/* JSQMessagesAvatarBorder */
typedef struct JSQMessagesAvatarBorder
{
    CGFloat lineWidth;
    CGColor *fillColor;
    UIColor *borderColor;
} JSQMessagesAvatarBorder;

JSQMessagesAvatarBorder JSQMessagesAvatarBorderMake(CGFloat, CGColor*, UIColor*);


/* CGSpace */
typedef struct {
    CGFloat top;
    CGFloat left;
    CGFloat bottom;
    CGFloat right;
} CGSpace;

CGSpace CGSpaceMake(CGFloat, CGFloat, CGFloat, CGFloat);


/* JSQFrameConstraint */
typedef struct {
    CGSpace space;
    CGSize size;
} JSQFrameConstraint;

JSQFrameConstraint JSQFrameConstraintMake(CGSpace, CGSize);

#endif /* JSQFrameConstraint_h */
