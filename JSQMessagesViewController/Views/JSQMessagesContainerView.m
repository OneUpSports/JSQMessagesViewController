//
//  JSQMessagesContainerView.m
//  JSQMessages
//
//  Created by Luke McDonald on 11/5/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "JSQMessagesContainerView.h"
#import "UIView+JSQNibLoading.h"

@implementation JSQMessagesContainerView


#pragma mark - Initialization

- (void)initializeSubviews
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self jsq_loadFromNib];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeSubviews];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initializeSubviews];
}

@end
