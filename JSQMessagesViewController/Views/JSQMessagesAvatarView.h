//
//  JSQMessagesAvatarView.h
//  JSQMessages
//
//  Created by Luke McDonald on 11/2/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSQMessagesAvatarImageView.h"

@interface JSQMessagesAvatarView : UIView
/**
 *  Returns the avatar image view of the cell that is responsible for displaying avatar images.
 */
@property (weak, nonatomic, readonly) JSQMessagesAvatarImageView *avatarImageView;

@end
