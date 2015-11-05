//
//  testBottomAccessoryView.m
//  JSQMessages
//
//  Created by Luke McDonald on 10/29/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "TestBottomAccessoryView.h"

@implementation TestBottomAccessoryView

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:@"TestBottomAccessoryView" owner:self options:nil];
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

- (IBAction)testTap:(id)sender {
    NSLog(@"testTap");
}

@end
