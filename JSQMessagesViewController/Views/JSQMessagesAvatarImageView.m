//
//  JSQMessagesAvatarImageView.m
//  JSQMessages
//
//  Created by Luke McDonald on 11/2/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "JSQMessagesAvatarImageView.h"
#import "SDWebImageManager.h"
#import "UIImageView+JSQMessagesImageViewUtils.h"
#import "UIImage+JSQMessageImageAnimatedGIF.h"

@interface UIImage (rounded)

+ (UIImage *)roundCorners:(UIImage *)img withRadius:(int)radius;

@end

@implementation UIImage (rounded)

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+ (UIImage *)roundCorners:(UIImage *)img withRadius:(int)radius {
    int w = img.size.width;
    int h = img.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    addRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return [UIImage imageWithCGImage:imageMasked];
}

@end


static UIImage *sPlaceholderImage;

@interface JSQMessagesAvatarImageView ()
- (void)setImageWithImage:(UIImage*)remoteImage URL:(NSURL*)URL;

- (void)notifyDelegateViewDidFinish;

- (void)setImage:(UIImage *)image fromUrl:(NSString *)fromUrl;

- (void)configureDefaults;
@end

@implementation JSQMessagesAvatarImageView

+ (UIImage *)imageAtURl:(NSString *)imageUrl
{
    // i don't agree we should do this, but it's for backwards compat
    
    __block UIImage *downloadedImage = nil;
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    NSURL *url = [NSURL URLWithString:imageUrl];
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url
                                                          options:0
                                                         progress:nil
                                                        completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                            downloadedImage = image;
                                                            dispatch_semaphore_signal(sem);
                                                        }];
    
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    
    return downloadedImage;
}

+ (void)initialize
{
    if (!sPlaceholderImage) {
//        NSDictionary *config = [OneUpServiceLibrary libAppConfig];
//        NSString *placeholderName = [config objectForKey:
//                                     @"OneUpImageViewPlaceholder"];
//        UIImage *placeholder = [UIImage imageNamed:placeholderName];
//        if (!placeholder) {
//            placeholder = [OneUpServiceLibrary
//                           bundleImageNamed:@"oneUpPlaceHolder"];
//        }
//        sPlaceholderImage = placeholder;
    }
}

+ (void)removeCachedImageAtURL:(NSString *)imageURL {
    NSURL *url = [NSURL URLWithString:imageURL];
    NSString *cacheKey = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    [[SDImageCache sharedImageCache] removeImageForKey:cacheKey];
}

@synthesize imageURL = _imageURL;
@synthesize showExpiredImage = _showExpiredImage;

- (id)init
{
    self = [super init];
    if (self) {
        [self configureDefaults];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureDefaults];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configureDefaults];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        [self configureDefaults];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    self = [super initWithImage:image highlightedImage:highlightedImage];
    if (self) {
        [self configureDefaults];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
           imageURL:(NSString *)imageURL
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureDefaults];
        [self setImageURL:imageURL];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
           imageURL:(NSString *)imageURL
     cacheInternval:(NSTimeInterval)cacheInterval
{
    self = [self initWithFrame:frame imageURL:imageURL];
    if (self) {
        [self configureDefaults];
        [self setImageURL:imageURL cacheInterval:cacheInterval];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
           imageURL:(NSString *)imageURL
     cacheInternval:(NSTimeInterval)cacheInterval
       cornerRadius:(CGFloat)cornerRadius
{
    self = [self initWithFrame:frame
                      imageURL:imageURL
                cacheInternval:cacheInterval];
    if (self) {
        [self configureDefaults];
        [self setImageURL:imageURL cacheInterval:cacheInterval];
    }
    return self;
}

- (void)configureDefaults
{
    _defaultContentMode = self.contentMode;
    _placeholderImage = sPlaceholderImage;
}

- (void)notifyDelegateViewDidFinish
{
    if ([self.delegate respondsToSelector:
         @selector(oneUpImageViewDidFinish:)]) {
        [self.delegate oneUpImageViewDidFinish:self];
    }
    
    if ([self.delegate respondsToSelector:
         @selector(oneUpImageViewDidFinish:atIndexPath:)]) {
        [self.delegate oneUpImageViewDidFinish:self
                                   atIndexPath:_indexPathInTableView];
    }
}

- (void)setImage:(UIImage *)image
{
    [self setImage:image fromUrl:nil];
}

- (void)setImage:(UIImage *)image fromUrl:(NSString *)fromUrl
{
    @synchronized(self) {
        [super setImage:image];
        
        if (image == _placeholderImage) {
            if (self.bounds.size.width > _placeholderImage.size.width) {
                self.contentMode = UIViewContentModeCenter;
            } else {
                self.contentMode = _defaultContentMode;
            }
        } else {
            self.contentMode = _defaultContentMode;
        }
        _imageURL = fromUrl;
    }
}

- (void)setImageURL:(NSString *)imageURL
{
    NSURL *url = [NSURL URLWithString:imageURL];
    
    [self sd_setImageWithURL:url
            placeholderImage:self.placeholderImage
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       if (error)
                       {
                           self.image = self.defaultImage;
                           if ([self.delegate respondsToSelector:@selector(oneUpImageView:didFailWithError:)]) {
                               [self.delegate oneUpImageView:self didFailWithError:error];
                           }
                           return;
                       }
                       
                       [self setImage:image fromUrl:imageURL.absoluteString];
                       
                       if ((cacheType == SDImageCacheTypeDisk || cacheType == SDImageCacheTypeMemory) &&
                           [self.delegate respondsToSelector:@selector(oneUpImageViewDidFinishWithDiskImage:)]) {
                           [self.delegate oneUpImageViewDidFinishWithDiskImage:self];
                           return;
                       }
                       
                       if ([self.delegate respondsToSelector:@selector(oneUpImageView:processImage:)]) {
                           [self.delegate oneUpImageView:self processImage:image];
                       }
                       
                       if ([self.delegate respondsToSelector:@selector(oneUpImageViewDidFinish:)]) {
                           [self.delegate oneUpImageViewDidFinish:self];
                       }
                       
                       if ([self.delegate respondsToSelector:@selector(oneUpImageViewDidFinish:atIndexPath:)]) {
                           [self.delegate oneUpImageViewDidFinish:self atIndexPath:self.indexPathInTableView];
                       }
                   }];
}

- (void)setImageURL:(NSString *)imageURL cacheInterval:(NSTimeInterval)cacheInterval
{
    [self setImageURL:imageURL];
}

- (void)setImageURL:(NSString *)imageURL
      cacheInterval:(NSTimeInterval)cacheInterval
        clearCached:(BOOL)clearCached
{
    if (clearCached) {
        NSURL *url = [NSURL URLWithString:imageURL];
        NSString *cacheKey = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
        [[SDImageCache sharedImageCache] removeImageForKey:cacheKey];
    }
    
    [self setImageURL:imageURL cacheInterval:cacheInterval];
}

- (void)overrideCachedImageForURL:(NSString *)imageURL withImage:(UIImage *)image
{
    if (imageURL) {
        NSURL *url = [NSURL URLWithString:imageURL];
        NSString *cacheKey = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
        [[SDImageCache sharedImageCache] storeImage:image forKey:cacheKey];
    }
    
    [self setImageWithImage:image URL:[NSURL URLWithString:imageURL]];
}

- (void)overrideCachedGIFForURL:(NSString *)imageURL withGIFData:(NSData *)gifData
{
    UIImage *image = [UIImage animatedImageWithAnimatedGIFData:gifData];
    
    [self setImageWithImage:image
                        URL:[NSURL URLWithString:imageURL]];
}

- (void)setImageWithImage:(UIImage *)image URL:(NSURL *)URL
{
    if ([image isKindOfClass:[UIImage class]]) {
        NSString *urlString = [URL absoluteString];
        
        if( [self.delegate respondsToSelector:@selector(oneUpImageView:processImage:)])
            image = [self.delegate oneUpImageView:self
                                     processImage:image];
        
        if (self.image == _placeholderImage) {
            [UIView
             transitionWithView:self
             duration:0.3f
             options:UIViewAnimationOptionTransitionCrossDissolve
             animations:^{
                 [self setImage:image fromUrl:urlString];
             } completion:nil];
        } else
        {
            [self setImage:image fromUrl:urlString];
        }
        [self notifyDelegateViewDidFinish];
    }
}


@end
