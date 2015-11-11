//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

/**
 *  A `JSQMessagesCollectionViewLayoutAttributes` is an object that manages the layout-related attributes
 *  for a given `JSQMessagesCollectionViewCell` in a `JSQMessagesCollectionView`.
 */
@interface JSQMessagesCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes <NSCopying>

@property (strong, nonatomic) UICollectionView *collectionView;

/**
 *  The font used to display the body of a text message in a message bubble within a `JSQMessagesCollectionViewCell`.
 *  This value must not be `nil`.
 */
@property (strong, nonatomic) UIFont *messageBubbleFont;

/**
 *  The width of the `messageBubbleContainerView` of a `JSQMessagesCollectionViewCell`.
 *  This value should be greater than `0.0`.
 *
 *  @see JSQMessagesCollectionViewCell.
 */
@property (assign, nonatomic) CGFloat messageBubbleContainerViewWidth;


/**
 *  The spacing of the `messageBubble and Avatar` of a `JSQMessagesCollectionViewCell`.
 *  This value should be greater than `0.0` and no greater than '10.0'. Any greater value may cause issues message bubble layout.
 *
 *  @see JSQMessagesCollectionViewCell.
 */
@property (assign, nonatomic) CGFloat messageBubbleAvatarSpacing;

@property (assign, nonatomic) CGFloat bottomLabelLeftSpacer;

@property (assign, nonatomic) CGFloat bottomLabelRightSpacer;

@property (assign, nonatomic) CGFloat avatarCellSpacer;

/**
 *  The inset of the text container's layout area within the text view's content area in a `JSQMessagesCollectionViewCell`. 
 *  The specified inset values should be greater than or equal to `0.0`.
 */
@property (assign, nonatomic) UIEdgeInsets textViewTextContainerInsets;

/**
 *  The inset of the frame of the text view within a `JSQMessagesCollectionViewCell`. 
 *  
 *  @discussion The inset values should be greater than or equal to `0.0` and are applied in the following ways:
 *
 *  1. The right value insets the text view frame on the side adjacent to the avatar image 
 *  (or where the avatar would normally appear). For outgoing messages this is the right side, 
 *  for incoming messages this is the left side.
 *
 *  2. The left value insets the text view frame on the side opposite the avatar image 
 *  (or where the avatar would normally appear). For outgoing messages this is the left side, 
 *  for incoming messages this is the right side.
 *
 *  3. The top value insets the top of the frame.
 *
 *  4. The bottom value insets the bottom of the frame.
 */
@property (assign, nonatomic) UIEdgeInsets textViewFrameInsets;

/**
 *  The size of the `avatarImageView` of a `JSQMessagesCollectionViewCellIncoming`.
 *  The size values should be greater than or equal to `0.0`.
 *
 *  @see JSQMessagesCollectionViewCellIncoming.
 */
@property (assign, nonatomic) CGSize incomingAvatarViewSize;

/**
 *  The size of the `avatarImageView` of a `JSQMessagesCollectionViewCellOutgoing`.
 *  The size values should be greater than or equal to `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellOutgoing`.
 */
@property (assign, nonatomic) CGSize outgoingAvatarViewSize;

/**
 *  The height of the `cellTopLabel` of a `JSQMessagesCollectionViewCell`.
 *  This value should be greater than or equal to `0.0`.
 *
 *  @see JSQMessagesCollectionViewCell.
 */
@property (assign, nonatomic) CGFloat cellTopLabelHeight;

/**
 *  The height of the `messageBubbleTopLabel` of a `JSQMessagesCollectionViewCell`.
 *  This value should be greater than or equal to `0.0`.
 *
 *  @see JSQMessagesCollectionViewCell.
 */
@property (assign, nonatomic) CGFloat messageBubbleTopLabelHeight;

/**
 *  The height of the `cellBottomLabel` of a `JSQMessagesCollectionViewCell`.
 *  This value should be greater than or equal to `0.0`.
 *
 *  @see JSQMessagesCollectionViewCell.
 */
@property (assign, nonatomic) CGFloat cellBottomLabelHeight;

/**
 *  The height of the `messageBubbleBottomLabel` of a `JSQMessagesCollectionViewCell`.
 *  This value should be greater than or equal to `0.0`.
 *
 *  @see JSQMessagesCollectionViewCell.
 */
@property (assign, nonatomic) CGFloat messageBubbleBottomLabelHeight;


// bottomAccessoryViewHeightConstraint
/**
 *  The height of the `bottomAccessoryView` of a `JSQMessagesCollectionViewCell`.
 *  This value should be greater than or equal to `0.0`.
 *
 *  @see JSQMessagesCollectionViewCell.
 */
@property (assign, nonatomic) CGFloat bottomAccessoryViewHeight;


/**
 *  The spacing between cellBottomLabel & messageBubbleBottomLabel of the `bottomLabelsSpacerHeightConstraint` of a `JSQMessagesCollectionViewCell`.
 *  This value should be greater than or equal to `0.0`.
 *
 *  @see JSQMessagesCollectionViewCell.
 */
@property (assign, nonatomic) CGFloat bottomLabelsSpacerHeight;

/**
 *  The spacing between cellBottomLabel & bottomAccessoryView of the `bottomAccessorySpacerHeightConstraint` of a `JSQMessagesCollectionViewCell`.
 *  This value should be greater than or equal to `0.0`.
 *
 *  @see JSQMessagesCollectionViewCell.
 */
@property (assign, nonatomic) CGFloat bottomAccessorySpacerHeight;


/**
 *  The spacing between bottomAccessoryView & the next cell to appear below this cell of the `bottomAccessorySpacerHeightConstraint` of a `bottomCellSpacerHeightConstraint`.
 *  This value should be greater than or equal to `0.0`.
 *
 *  @see JSQMessagesCollectionViewCell.
 */
@property (assign, nonatomic) CGFloat bottomCellSpacerHeight;

/* Show Cell Accessory Views */
@property (assign, nonatomic) BOOL showBottomCellAccessoryView;

@end
