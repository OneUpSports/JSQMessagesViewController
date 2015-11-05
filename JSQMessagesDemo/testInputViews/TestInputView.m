//
//  TestInputView.m
//  JSQMessages
//
//  Created by Luke McDonald on 11/4/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "TestInputView.h"
#import "UIView+JSQMessages.h"

@implementation TestInputView

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:@"TestInputView" owner:self options:nil];
    [self addSubview:self.containerView];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
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
    [self setup];
}


@end
