//
//  JSQFrameConstraint.m
//  JSQMessages
//
//  Created by Luke McDonald on 11/11/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSQStructs.h"

/* JSQ MESSAGES AVATAR BORDER */
JSQMessagesAvatarBorder JSQMessagesAvatarBorderMake(CGFloat lineWidth, CGColor *fillColor, UIColor *borderColor)
{
    JSQMessagesAvatarBorder avatar;
    avatar.lineWidth = lineWidth;
    avatar.fillColor = fillColor;
    avatar.borderColor = borderColor;
    return avatar;
}


/* CG SPACE */
CGSpace CGSpaceMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
{
    CGSpace s;
    s.top = top;
    s.left = left;
    s.bottom = bottom;
    s.right = right;
    return s;
}

/* JSQ FRAME CONSTRAINT */
JSQFrameConstraint JSQFrameConstraintMake(CGSpace space, CGSize size)
{
    JSQFrameConstraint s;
    s.space = space;
    s.size = size;
    return s;
}