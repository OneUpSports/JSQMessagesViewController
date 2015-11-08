//
//  UIView+JSQNibLoading.h
//

#import <UIKit/UIKit.h>

@interface UIView (JSQNibLoading)

- (void)jsq_loadFromNib;
- (void)jsq_loadFromNibWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle;
- (void)adjustConstraintsForNib;
@end
