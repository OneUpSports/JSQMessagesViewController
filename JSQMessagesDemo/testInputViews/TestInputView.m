//
//  TestInputView.m
//  JSQMessages
//
//  Created by Luke McDonald on 11/4/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "TestInputView.h"

@implementation TestInputView

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:@"TestInputView" owner:self options:nil];
    [self addSubview:self.containerView];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
//    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}

@end
