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

#import "JSQMessagesCollectionViewLayoutAttributes.h"


@interface JSQMessagesCollectionViewLayoutAttributes ()

- (CGSize)jsq_correctedAvatarSizeFromSize:(CGSize)size;

- (CGFloat)jsq_correctedLabelHeightForHeight:(CGFloat)height;

@property (assign, nonatomic) CGFloat cellBottomAccessoryViewHeight;
@end


@implementation JSQMessagesCollectionViewLayoutAttributes

#pragma mark - Lifecycle

- (void)dealloc
{
    _messageBubbleFont = nil;
}

#pragma mark - Setters

- (void)setMessageBubbleFont:(UIFont *)messageBubbleFont
{
    NSParameterAssert(messageBubbleFont != nil);
    _messageBubbleFont = messageBubbleFont;
}

- (void)setMessageBubbleContainerViewWidth:(CGFloat)messageBubbleContainerViewWidth
{
    NSParameterAssert(messageBubbleContainerViewWidth > 0.0f);
    _messageBubbleContainerViewWidth = ceilf(messageBubbleContainerViewWidth);
}

- (void)setIncomingAvatarViewSize:(CGSize)incomingAvatarViewSize
{
    NSParameterAssert(incomingAvatarViewSize.width >= 0.0f && incomingAvatarViewSize.height >= 0.0f);
    _incomingAvatarViewSize = [self jsq_correctedAvatarSizeFromSize:incomingAvatarViewSize];
}

- (void)setOutgoingAvatarViewSize:(CGSize)outgoingAvatarViewSize
{
    NSParameterAssert(outgoingAvatarViewSize.width >= 0.0f && outgoingAvatarViewSize.height >= 0.0f);
    _outgoingAvatarViewSize = [self jsq_correctedAvatarSizeFromSize:outgoingAvatarViewSize];
}

- (void)setCellTopLabelHeight:(CGFloat)cellTopLabelHeight
{
    NSParameterAssert(cellTopLabelHeight >= 0.0f);
    _cellTopLabelHeight = [self jsq_correctedLabelHeightForHeight:cellTopLabelHeight];
}

- (void)setMessageBubbleTopLabelHeight:(CGFloat)messageBubbleTopLabelHeight
{
    NSParameterAssert(messageBubbleTopLabelHeight >= 0.0f);
    _messageBubbleTopLabelHeight = [self jsq_correctedLabelHeightForHeight:messageBubbleTopLabelHeight];
}

- (void)setCellBottomLabelHeight:(CGFloat)cellBottomLabelHeight
{
    NSParameterAssert(cellBottomLabelHeight >= 0.0f);
    _cellBottomLabelHeight = [self jsq_correctedLabelHeightForHeight:cellBottomLabelHeight];
}

- (void)setMessageBubbleBottomLabelHeight:(CGFloat)messageBubbleBottomLabelHeight
{
    NSParameterAssert(messageBubbleBottomLabelHeight >= 0.0f);
    _messageBubbleBottomLabelHeight = [self jsq_correctedLabelHeightForHeight:messageBubbleBottomLabelHeight];
}

/* Cell Accessory Views */
- (void)setBottomAccessoryViewHeight:(CGFloat)bottomAccessoryViewHeight
{
    NSParameterAssert(bottomAccessoryViewHeight >= 0.0f);
    _cellBottomAccessoryViewHeight = [self jsq_correctedLabelHeightForHeight:bottomAccessoryViewHeight];
}

/* Cell Subview Spacers */
- (void)setBottomLabelsSpacerHeight:(CGFloat)bottomLabelsSpacerHeight
{
    NSParameterAssert(bottomLabelsSpacerHeight >= 0.0f);
    _bottomLabelsSpacerHeight = [self jsq_correctedLabelHeightForHeight:bottomLabelsSpacerHeight];
}

- (void)setBottomAccessorySpacerHeight:(CGFloat)bottomAccessorySpacerHeight
{
    NSParameterAssert(bottomAccessorySpacerHeight >= 0.0f);
    _bottomAccessorySpacerHeight = [self jsq_correctedLabelHeightForHeight:bottomAccessorySpacerHeight];
}

- (void)setBottomCellSpacerHeight:(CGFloat)bottomCellSpacerHeight
{
    NSParameterAssert(bottomCellSpacerHeight >= 0.0f);
    _bottomCellSpacerHeight = [self jsq_correctedLabelHeightForHeight:bottomCellSpacerHeight];
}

- (void)setMessageBubbleAvatarSpacing:(CGFloat)messageBubbleAvatarSpacing
{
    NSParameterAssert(messageBubbleAvatarSpacing >= 0.0f);
    _messageBubbleAvatarSpacing = [self jsq_correctedLabelHeightForHeight:messageBubbleAvatarSpacing];
}

- (void)setBottomLabelLeftSpacer:(CGFloat)bottomLabelLeftSpacer
{
    _bottomLabelLeftSpacer = [self jsq_correctedLabelHeightForHeight:bottomLabelLeftSpacer];
}

- (void)setBottomLabelRightSpacer:(CGFloat)bottomLabelRightSpacer
{
    _bottomLabelRightSpacer = [self jsq_correctedLabelHeightForHeight:bottomLabelRightSpacer];
}

- (void)setAvatarCellSpacer:(CGFloat)avatarCellSpacer
{
    _avatarCellSpacer = [self jsq_correctedLabelHeightForHeight:avatarCellSpacer];
}

/* Show Hide Accessory Views */

- (void)setShowBottomCellAccessoryView:(BOOL)showBottomCellAccessoryView
{
    _showBottomCellAccessoryView = showBottomCellAccessoryView;
}

#pragma mark - Getters

- (CGFloat)bottomAccessoryViewHeight
{
    return _showBottomCellAccessoryView ? _cellBottomAccessoryViewHeight : 0.0f;
}

#pragma mark - Utilities

- (CGSize)jsq_correctedAvatarSizeFromSize:(CGSize)size
{
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

- (CGFloat)jsq_correctedLabelHeightForHeight:(CGFloat)height
{
    return ceilf(height);
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    if (self.representedElementCategory == UICollectionElementCategoryCell) {
        JSQMessagesCollectionViewLayoutAttributes *layoutAttributes = (JSQMessagesCollectionViewLayoutAttributes *)object;
        
        if (![layoutAttributes.messageBubbleFont isEqual:self.messageBubbleFont]
            || !UIEdgeInsetsEqualToEdgeInsets(layoutAttributes.textViewFrameInsets, self.textViewFrameInsets)
            || !UIEdgeInsetsEqualToEdgeInsets(layoutAttributes.textViewTextContainerInsets, self.textViewTextContainerInsets)
            || !CGSizeEqualToSize(layoutAttributes.incomingAvatarViewSize, self.incomingAvatarViewSize)
            || !CGSizeEqualToSize(layoutAttributes.outgoingAvatarViewSize, self.outgoingAvatarViewSize)
            || (int)layoutAttributes.messageBubbleContainerViewWidth != (int)self.messageBubbleContainerViewWidth
            || (int)layoutAttributes.cellTopLabelHeight != (int)self.cellTopLabelHeight
            || (int)layoutAttributes.messageBubbleTopLabelHeight != (int)self.messageBubbleTopLabelHeight
            || (int)layoutAttributes.cellBottomLabelHeight != (int)self.cellBottomLabelHeight
            || (int)layoutAttributes.messageBubbleBottomLabelHeight != (int)self.messageBubbleBottomLabelHeight
            || (int)layoutAttributes.bottomLabelsSpacerHeight != (int)self.bottomLabelsSpacerHeight
            || (int)layoutAttributes.cellBottomAccessoryViewHeight != (int)self.cellBottomAccessoryViewHeight
            || (int)layoutAttributes.bottomAccessoryViewHeight != (int)self.bottomAccessoryViewHeight
            || (int)layoutAttributes.bottomAccessorySpacerHeight != (int)self.bottomAccessorySpacerHeight
            || (int)layoutAttributes.bottomCellSpacerHeight != (int)self.bottomCellSpacerHeight
            || layoutAttributes.showBottomCellAccessoryView != self.showBottomCellAccessoryView
            || layoutAttributes.messageBubbleAvatarSpacing != self.messageBubbleAvatarSpacing
            || layoutAttributes.bottomLabelLeftSpacer != self.bottomLabelLeftSpacer
            || layoutAttributes.avatarCellSpacer != self.avatarCellSpacer
            || layoutAttributes.bottomLabelRightSpacer != self.bottomLabelRightSpacer) {
            
            return NO;
        }
    }
    
    return [super isEqual:object];
}

- (NSUInteger)hash
{
    return [self.indexPath hash];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQMessagesCollectionViewLayoutAttributes *copy = [super copyWithZone:zone];
    
    if (copy.representedElementCategory != UICollectionElementCategoryCell) {
        return copy;
    }
    
    copy.messageBubbleFont = self.messageBubbleFont;
    copy.messageBubbleContainerViewWidth = self.messageBubbleContainerViewWidth;
    copy.textViewFrameInsets = self.textViewFrameInsets;
    copy.textViewTextContainerInsets = self.textViewTextContainerInsets;
    copy.incomingAvatarViewSize = self.incomingAvatarViewSize;
    copy.outgoingAvatarViewSize = self.outgoingAvatarViewSize;
    copy.cellTopLabelHeight = self.cellTopLabelHeight;
    copy.messageBubbleTopLabelHeight = self.messageBubbleTopLabelHeight;
    copy.cellBottomLabelHeight = self.cellBottomLabelHeight;
    copy.messageBubbleBottomLabelHeight = self.messageBubbleBottomLabelHeight;
    copy.bottomLabelsSpacerHeight = self.bottomLabelsSpacerHeight;
    copy.cellBottomAccessoryViewHeight = self.cellBottomAccessoryViewHeight;
    copy.bottomAccessoryViewHeight = self.bottomAccessoryViewHeight;
    copy.bottomAccessorySpacerHeight = self.bottomAccessorySpacerHeight;
    copy.bottomCellSpacerHeight = self.bottomCellSpacerHeight;
    copy.showBottomCellAccessoryView = self.showBottomCellAccessoryView;
    copy.messageBubbleAvatarSpacing = self.messageBubbleAvatarSpacing;
    copy.bottomLabelLeftSpacer = self.bottomLabelLeftSpacer;
    copy.bottomLabelRightSpacer = self.bottomLabelRightSpacer;
    copy.avatarCellSpacer = self.avatarCellSpacer;
    

    
    return copy;
}

@end
