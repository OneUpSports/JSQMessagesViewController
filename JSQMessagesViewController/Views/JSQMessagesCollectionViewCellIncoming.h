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

#import <Foundation/Foundation.h>
#import "JSQMessagesCollectionViewCell.h"

@protocol JSQMessagesCollectionViewCellIncomingConfigurationDataSource;

/**
 *  A `JSQMessagesCollectionViewCellIncoming` object is a concrete instance 
 *  of `JSQMessagesCollectionViewCell` that represents an incoming message data item.
 */
@interface JSQMessagesCollectionViewCellIncoming : JSQMessagesCollectionViewCell

+ (void)setIncomingConfigurationDataSource:(id<JSQMessagesCollectionViewCellIncomingConfigurationDataSource>)dataSource;

@end

@protocol JSQMessagesCollectionViewCellIncomingConfigurationDataSource <NSObject>
@optional
- (AvatarBorder)incomingCellAvatarBorder:(JSQMessagesCollectionViewCellIncoming *)cell;
@end