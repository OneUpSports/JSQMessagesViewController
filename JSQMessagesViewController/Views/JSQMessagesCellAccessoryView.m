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

@implementation JSQMessagesCellAccessoryView

//- (void)dealloc {
//    
//}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if (object == self && [keyPath isEqualToString:@"bounds"]) {
//        // do your stuff, or better schedule to run later using performSelector:withObject:afterDuration:
//    }
//}
//
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self addObserver:self forKeyPath:@"bounds" options:0 context:nil];
//    }
//    return self;
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.subviews.count > 0) {
        UIView *view = self.subviews[0];
//        [self jsq_pinAllEdgesOfSubview:view];
        
    }
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
//    if (self.subviews.count > 0 && frame.size.height != 20.0f) {
//        UIView *view = self.subviews[0];
//        [self jsq_pinAllEdgesOfSubview:view];
//    }

}

-(void)setBounds:(CGRect)newBounds {
    [super setBounds:newBounds];
    if (self.subviews.count > 0 && newBounds.size.height != 20.0f) {
        UIView *view = self.subviews[0];
        view.frame = newBounds;
//        [self jsq_pinAllEdgesOfSubview:view];
    }
}

- (void)updateConstraints {
    [super updateConstraints];
//    NSLog(@"This is the frame: %@", NSStringFromCGSize(self.frame.size));
    if (self.subviews.count > 0) {
        UIView *view = self.subviews[0];
        view.frame = self.bounds;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.superview layoutIfNeeded];
        });
    }
}

- (void)updateConstraintsIfNeeded {
    [super updateConstraintsIfNeeded];
//    NSLog(@"updateConstraintsIfNeeded This is the frame: %@", NSStringFromCGSize(self.frame.size));
    if (self.subviews.count > 0) {
        UIView *view = self.subviews[0];
        view.frame = self.bounds;
    }
}
@end
