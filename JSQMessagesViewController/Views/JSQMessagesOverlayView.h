//
//  JSQMessagesOverlayView.h
//  JSQMessages
//
//  Created by Luke McDonald on 11/11/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSQMessagesOverlayView : UIView
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
