//
//  JSQMessagesAvatarImageView.h
//  JSQMessages
//
//  Created by Luke McDonald on 11/2/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OneUpImageViewCacheIntervalTeamLogos            (60 * 60 * 24 * 90)
#define OneUpImageViewCacheIntervalPlayerImages         (60 * 60 * 24 * 30)
#define OneUpImageViewCacheIntervalUserImages           (60 * 60)
#define OneUpImageViewCacheIntervalCampaignImages       (60 * 60 * 24 * 10)

@protocol JSQMessagesAvatarImageViewDelegate;

@interface JSQMessagesAvatarImageView : UIImageView

@property (weak, nonatomic) id <JSQMessagesAvatarImageViewDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPathInTableView;
@property (nonatomic, readonly) NSString *imageURL;

//! When showing the placeholder image, the contentMode will change to
//! UIViewContentModeCenter. Once the actual image loads, the contentMode
//! will change back to defaultContentMode.
@property (nonatomic) UIViewContentMode defaultContentMode;

@property (nonatomic, strong) UIImage *placeholderImage;
// Image to fall back to if the download fails
@property (nonatomic, strong) UIImage *defaultImage;
@property (nonatomic, strong) NSData *imageData;

//! Defaults to NO
@property (nonatomic) BOOL showExpiredImage;

+ (UIImage *)imageAtURl:(NSString *)imageUrl;
+ (void)removeCachedImageAtURL:(NSString *)imageURL;

- (id)initWithFrame:(CGRect)frame
           imageURL:(NSString *)imageURL;

- (id)initWithFrame:(CGRect)frame
           imageURL:(NSString *)imageURL
     cacheInternval:(NSTimeInterval)cacheInterval;

- (id)initWithFrame:(CGRect)frame
           imageURL:(NSString *)imageURL
     cacheInternval:(NSTimeInterval)cacheInterval
       cornerRadius:(CGFloat)cornerRadius;

- (void)setImageURL:(NSString *)imageURL
      cacheInterval:(NSTimeInterval)cacheInterval;

- (void)setImageURL:(NSString *)imageURL
      cacheInterval:(NSTimeInterval)cacheInterval
        clearCached:(BOOL)clearCached;

- (void)overrideCachedImageForURL:(NSString *)imageURL
                        withImage:(UIImage *)image;

- (void)overrideCachedGIFForURL:(NSString *)imageURL
                    withGIFData:(NSData *)gifData;

@end


@protocol JSQMessagesAvatarImageViewDelegate <NSObject>

@optional
- (void)oneUpImageViewDidFinishWithDiskImage:(JSQMessagesAvatarImageView *)imageView;

- (void)oneUpImageViewDidFinish:(JSQMessagesAvatarImageView *)imageView;

- (void)oneUpImageViewDidFinish:(JSQMessagesAvatarImageView *)imageView
                    atIndexPath:(NSIndexPath *)indexPath;

- (void)oneUpImageView:(JSQMessagesAvatarImageView *)imageView didFailWithError:(NSError *)error;

- (UIImage *) oneUpImageView:(JSQMessagesAvatarImageView *)imageView
                processImage:(UIImage *)inputImage;
@end
