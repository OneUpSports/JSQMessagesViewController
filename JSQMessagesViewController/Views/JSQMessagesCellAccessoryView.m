//
//  JSQMessagesCellAccessoryView.m
//  JSQMessages
//
//  Created by Luke McDonald on 11/2/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCellAccessoryView.h"
#import "UIView+JSQMessages.h"
#import "UIDevice+JSQMessages.h"
#import "UIView+JSQNibLoading.h"

@implementation JSQMessagesCellAccessoryView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.subviews.count > 0) {
        UIView *view = self.subviews[0];
        [self jsq_pinAllEdgesOfSubview:view];
    }
}

- (void)addSubview:(UIView *)view
{
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [view adjustConstraintsForNib];
    [super addSubview:view];
}

@end
