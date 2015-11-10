//
//  JSQChatButton.h
//  JSQMessages
//
//  Created by Roger Dalal on 11/10/14.
//  Updated by Luke McDonald on 11/9/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    JSQChatButtonStyleHamburger,
    JSQChatButtonStyleClose,
    JSQChatButtonStylePlus,
    JSQChatButtonStyleCirclePlus,
    JSQChatButtonStyleCircleClose,
    JSQChatButtonStyleCircleCaretLeft,
    JSQChatButtonStyleCircleCaretRight,
    JSQChatButtonStyleCaretUp,
    JSQChatButtonStyleCaretDown,
    JSQChatButtonStyleCaretLeft,
    JSQChatButtonStyleCaretRight,
    JSQChatButtonStyleArrowLeft,
    JSQChatButtonStyleArrowRight
} JSQChatButtonStyle;

@interface JSQChatButton : UIButton
-(JSQChatButtonStyle)buttonStyle;

-(void)setStyle:(JSQChatButtonStyle)style animated:(BOOL)animated;
-(void)setCircleColor:(UIColor *)circleColor animated:(BOOL)animated;
-(void)showHighlight;
-(void)showUnHighlight;

@property (nonatomic, strong) NSDictionary *options;

+ (NSDictionary *)defaultOptions;

// button customization options:

// scale to apply to the button CGPath(s) when the button is pressed. Default is 0.9:
extern NSString *const kJSQChatButtonHighlightScale;
// the button CGPaths stroke width, default 1.0f pixel
extern NSString *const kJSQChatButtonLineWidth;
// the button CGPaths stroke color, default is black
extern NSString *const kJSQChatButtonColor;
// the button CGPaths stroke color when highlighted, default is light gray
extern NSString *const kJSQChatButtonHighlightedColor;
// duration in second of the highlight (pressed down) animation, default 0.1
extern NSString *const kJSQChatButtonHighlightAnimationDuration;
// duration in second of the unhighlight (button release) animation, defualt 0.15
extern NSString *const kJSQChatButtonUnHighlightAnimationDuration;
// duration in second of the style change animation, default 0.3
extern NSString *const kJSQChatButtonStyleChangeAnimationDuration;

@end
