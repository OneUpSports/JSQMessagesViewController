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

#import "JSQMessagesCollectionView.h"

#import "JSQMessagesCollectionViewFlowLayout.h"
#import "JSQMessagesCollectionViewCellIncoming.h"
#import "JSQMessagesCollectionViewCellOutgoing.h"

#import "JSQMessagesTypingIndicatorFooterView.h"
#import "JSQMessagesLoadEarlierHeaderView.h"

#import "UIColor+JSQMessages.h"
#import "JSQMessagesCollectionViewFlowLayoutInvalidationContext.h"


@interface JSQMessagesCollectionView () <JSQMessagesLoadEarlierHeaderViewDelegate>
@property (assign, nonatomic) BOOL shouldDissmissCellAccessoryViewsOnScroll;


- (void)jsq_configureCollectionView;
@end


@implementation JSQMessagesCollectionView

@dynamic dataSource;
@dynamic delegate;
@dynamic collectionViewLayout;

#pragma mark - Initialization

- (void)jsq_configureCollectionView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];

    self.backgroundColor = [UIColor whiteColor];
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeNone;
    self.alwaysBounceVertical = YES;
    self.bounces = YES;
    
    [self registerNib:[JSQMessagesCollectionViewCellIncoming nib]
          forCellWithReuseIdentifier:[JSQMessagesCollectionViewCellIncoming cellReuseIdentifier]];
    
    [self registerNib:[JSQMessagesCollectionViewCellOutgoing nib]
          forCellWithReuseIdentifier:[JSQMessagesCollectionViewCellOutgoing cellReuseIdentifier]];
    
    [self registerNib:[JSQMessagesCollectionViewCellIncoming nib]
          forCellWithReuseIdentifier:[JSQMessagesCollectionViewCellIncoming mediaCellReuseIdentifier]];
    
    [self registerNib:[JSQMessagesCollectionViewCellOutgoing nib]
          forCellWithReuseIdentifier:[JSQMessagesCollectionViewCellOutgoing mediaCellReuseIdentifier]];
    
    [self registerNib:[JSQMessagesTypingIndicatorFooterView nib]
          forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
          withReuseIdentifier:[JSQMessagesTypingIndicatorFooterView footerReuseIdentifier]];
    
    [self registerNib:[JSQMessagesLoadEarlierHeaderView nib]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
          withReuseIdentifier:[JSQMessagesLoadEarlierHeaderView headerReuseIdentifier]];

    _typingIndicatorDisplaysOnLeft = YES;
    _typingIndicatorMessageBubbleColor = [UIColor jsq_messageBubbleLightGrayColor];
    _typingIndicatorEllipsisColor = [_typingIndicatorMessageBubbleColor jsq_colorByDarkeningColorWithValue:0.3f];

    _loadEarlierMessagesHeaderTextColor = [UIColor jsq_messageBubbleBlueColor];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self jsq_configureCollectionView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self jsq_configureCollectionView];
}

#pragma mark - Typing indicator

- (JSQMessagesTypingIndicatorFooterView *)dequeueTypingIndicatorFooterViewForIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesTypingIndicatorFooterView *footerView = [super dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                 withReuseIdentifier:[JSQMessagesTypingIndicatorFooterView footerReuseIdentifier]
                                                                                        forIndexPath:indexPath];

    [footerView configureWithEllipsisColor:self.typingIndicatorEllipsisColor
                        messageBubbleColor:self.typingIndicatorMessageBubbleColor
                       shouldDisplayOnLeft:self.typingIndicatorDisplaysOnLeft
                         forCollectionView:self];

    return footerView;
}

#pragma mark - Load earlier messages header

- (JSQMessagesLoadEarlierHeaderView *)dequeueLoadEarlierMessagesViewHeaderForIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesLoadEarlierHeaderView *headerView = [super dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                             withReuseIdentifier:[JSQMessagesLoadEarlierHeaderView headerReuseIdentifier]
                                                                                    forIndexPath:indexPath];

    headerView.loadButton.tintColor = self.loadEarlierMessagesHeaderTextColor;
    headerView.delegate = self;

    return headerView;
}

#pragma mark - Load earlier messages header delegate

- (void)headerView:(JSQMessagesLoadEarlierHeaderView *)headerView didPressLoadButton:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(collectionView:header:didTapLoadEarlierMessagesButton:)]) {
        [self.delegate collectionView:self header:headerView didTapLoadEarlierMessagesButton:sender];
    }
}

#pragma mark - Messages collection view cell delegate

- (void)messagesCollectionViewCellDidTapAvatar:(JSQMessagesCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath == nil) {
        return;
    }

    [self.delegate collectionView:self
            didTapAvatarImageView:cell.avatarContainerView.avatarImageView
                      atIndexPath:indexPath];
}

- (void)messagesCollectionViewCellDidTapMessageBubble:(JSQMessagesCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath == nil) {
        return;
    }
    
    [self.delegate collectionView:self didTapMessageBubbleAtIndexPath:indexPath];
}

- (void)messagesCollectionViewCellDidTapCell:(JSQMessagesCollectionViewCell *)cell atPosition:(CGPoint)position
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath == nil) {
        return;
    }

    [self.delegate collectionView:self
            didTapCellAtIndexPath:indexPath
                    touchLocation:position];
}


- (void)messagesCollectionViewCell:(JSQMessagesCollectionViewCell *)cell willShowBottomAccessoryView:(BOOL)showHide
                          animated:(BOOL)animated
      hideOtherCellsAccessoryViews:(BOOL)hideOtherCellsAccessoryViews
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath == nil) {
        return;
    }
    
    [self animateCell:cell willShowBottomAccessoryView:showHide animated:animated hideOtherCellsAccessoryViews:hideOtherCellsAccessoryViews indexPath:indexPath];
}


- (void)animateCell:(JSQMessagesCollectionViewCell *)cell willShowBottomAccessoryView:(BOOL)showHide
           animated:(BOOL)animated
hideOtherCellsAccessoryViews:(BOOL)hideOtherCellsAccessoryViews
          indexPath:(NSIndexPath *)indexPath
{
    
    BOOL isLastIndexPath = [self isLastIndexPath:indexPath];
    
    if (hideOtherCellsAccessoryViews) {
        CGFloat animationDuration = animated ? 0.25f : 0.0f;
        _dissmissCellAccessoryViewsOnScroll = NO;
        
        if (isLastIndexPath) {
            
            for (JSQMessagesCollectionViewCell *visibleCell in self.visibleCells) {
                if (![cell isEqual: visibleCell]) {
                    //                    visibleCell.showBottomAccessoryView = NO;
                    [visibleCell hideBottomAccessoryViews];
                }
            }
            
            [self performBatchUpdates:^{
                [self.collectionViewLayout invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
            } completion:^(BOOL finished) {

            }];

            [UIView animateWithDuration:animationDuration*2 animations:^{
                [self scrollToItemAtIndexPath:indexPath
                             atScrollPosition:UICollectionViewScrollPositionBottom
                                     animated:NO];
            } completion:^(BOOL finished){
                _dissmissCellAccessoryViewsOnScroll = _shouldDissmissCellAccessoryViewsOnScroll;
            }];
            
        } else {
            [UIView animateWithDuration:animationDuration*2 animations:^{
                //            [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
                
                
                [self scrollToItemAtIndexPath:indexPath
                             atScrollPosition:UICollectionViewScrollPositionCenteredVertically
                                     animated:NO];
            } completion:^(BOOL finished){
                _dissmissCellAccessoryViewsOnScroll = _shouldDissmissCellAccessoryViewsOnScroll;
            }];
            
            for (JSQMessagesCollectionViewCell *visibleCell in self.visibleCells) {
                if (![cell isEqual: visibleCell]) {
                    //                    visibleCell.showBottomAccessoryView = NO;
                    [visibleCell hideBottomAccessoryViews];
                }
            }
            
            [self performBatchUpdates:^{
                [self.collectionViewLayout invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
            } completion:^(BOOL finished) { }];
        }
    } else {
        [self performBatchUpdates:^{
            [self.collectionViewLayout invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
        } completion:^(BOOL finished) { }];
    }
}

- (void)messagesCollectionViewCell:(JSQMessagesCollectionViewCell *)cell didPerformAction:(SEL)action withSender:(id)sender
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath == nil) {
        return;
    }

    [self.delegate collectionView:self
                    performAction:action
               forItemAtIndexPath:indexPath
                       withSender:sender];
}

#pragma mark - Setters

- (void)setDissmissCellAccessoryViewsOnScroll:(BOOL)dissmissCellAccessoryViewsOnScroll
{
    _dissmissCellAccessoryViewsOnScroll = dissmissCellAccessoryViewsOnScroll;
    _shouldDissmissCellAccessoryViewsOnScroll = _dissmissCellAccessoryViewsOnScroll;
}


#pragma mark - Utilities

- (BOOL)isLastIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sectionsAmount = [self numberOfSections];
    NSInteger rowsAmount = [self numberOfItemsInSection:[indexPath section]];
    
    if ([indexPath section] == sectionsAmount - 1
        && [indexPath row] == rowsAmount - 1)
    {
        // This is the last index in the collectionView
        return YES;
    }
    
    return NO;
}

- (void)animateFlowLayout
{
    [self performBatchUpdates:^{
        [self.collectionViewLayout invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
    } completion:^(BOOL finished) { }];
}

@end
