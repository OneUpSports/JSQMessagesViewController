//
//  UIView+LENibLoading.m
//  Auto Layout By Example
//
//  Created by Julius Parishy on 4/30/14.
//  Copyright (c) 2014 jp. All rights reserved.
//

#import "UIView+JSQNibLoading.h"

#import <objc/runtime.h>

static void *JSQLoadFromNibAlreadyLoadedKey = &JSQLoadFromNibAlreadyLoadedKey;

@implementation UIView (JSQNibLoading)

- (void)jsq_setAlreadyLoadedFromNib
{
    objc_setAssociatedObject(self, JSQLoadFromNibAlreadyLoadedKey, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)jsq_alreadyLoadedFromNib
{
    NSNumber *loaded = objc_getAssociatedObject(self, JSQLoadFromNibAlreadyLoadedKey);
    return (loaded != nil);
}

- (void)jsq_loadFromNib
{
    [self jsq_loadFromNibWithNibName:nil bundle:nil];
}

- (void)jsq_loadFromNibWithNibName:(NSString *)name bundle:(NSBundle *)bundle
{
    if(![self jsq_alreadyLoadedFromNib])
    {
        NSString *nibName = name ?: NSStringFromClass([self class]);
        NSBundle *nibBundle = bundle ?: [NSBundle mainBundle];
        
        NSArray *views = [nibBundle loadNibNamed:nibName owner:self options:nil];
        NSAssert(views.count == 1, @"The xib must have a single root view.");
        
        UIView *view = views[0];
        
        if(self.translatesAutoresizingMaskIntoConstraints == NO)
        {
            NSArray *constraints = [view.constraints copy];
            
            [self copySubviewsFromView:view toView:self];
            [self copyLayoutConstraints:constraints fromView:view toView:self];
        }
        else
        {
            [self copySubviewsFromView:view toView:self];
        }
        
        [self jsq_setAlreadyLoadedFromNib];
    }
}

- (void)adjustConstraintsForNib
{
    if (self.subviews.count > 0) {
        UIView *view = self.subviews[0];
        
        if (view.constraints.count > 0) {
            if(self.translatesAutoresizingMaskIntoConstraints == NO)
            {
                NSArray *constraints = [view.constraints copy];
                
                [self copySubviewsFromView:view toView:self];
                [self copyLayoutConstraints:constraints fromView:view toView:self];
            }
            else
            {
                [self copySubviewsFromView:view toView:self];
            }
        }
    }
}

- (void)copySubviewsFromView:(UIView *)sourceView toView:(UIView *)destinationView
{
    for(UIView *subview in sourceView.subviews)
    {
        [subview removeFromSuperview];
        [destinationView addSubview:subview];
    }
}

- (void)copyLayoutConstraints:(NSArray *)constraints fromView:(UIView *)originalView toView:(UIView *)destinationView
{
    for(NSLayoutConstraint *originalConstraint in constraints)
    {
        id firstItem = (originalConstraint.firstItem == originalView) ? self : originalConstraint.firstItem;
        id secondItem = (originalConstraint.secondItem == originalView) ? self : originalConstraint.secondItem;
                
        NSLayoutAttribute firstAttribute = originalConstraint.firstAttribute;
        NSLayoutAttribute secondAttribute = originalConstraint.secondAttribute;
        
        NSLayoutRelation relation = originalConstraint.relation;
        
        CGFloat multipler = originalConstraint.multiplier;
        CGFloat constant = originalConstraint.constant;
        
        NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:firstItem attribute:firstAttribute relatedBy:relation toItem:secondItem attribute:secondAttribute multiplier:multipler constant:constant];
        [destinationView addConstraint:newConstraint];
    }
}

@end