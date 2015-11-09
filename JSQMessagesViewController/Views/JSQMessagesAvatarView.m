//
//  JSQMessagesAvatarView.m
//  JSQMessages
//
//  Created by Luke McDonald on 11/2/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "JSQMessagesAvatarView.h"
//#import "OneUpAppConfig+UI.h"
@interface JSQMessagesAvatarView () <JSQMessagesAvatarImageViewDelegate>
@property (weak, nonatomic) IBOutlet JSQMessagesAvatarImageView *avatarImageView;
@property (nonatomic, strong) JSQMessagesAvatarImageView *teamLogo;
@end

@implementation JSQMessagesAvatarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    
    self.avatarImageView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    self.avatarImageView.defaultContentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.delegate = self;
    
    /*
     CGFloat offset = -8;
     CGFloat size = CGRectGetWidth(self.bounds) * 0.5;
     self.teamLogo = [[OneUpImageView alloc] initWithFrame:CGRectMake(offset, CGRectGetHeight(self.bounds) - size - offset, size, size)];
     self.teamLogo.backgroundColor = [UIColor clearColor];
     self.teamLogo.defaultContentMode = UIViewContentModeScaleAspectFill;
     self.teamLogo.delegate = self;
     self.teamLogo.alpha = 0;
     [self addSubview:self.teamLogo];
     */
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithOvalInRect:self.avatarImageView.bounds];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.avatarImageView.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.avatarImageView.layer.mask = maskLayer;
    
    CAShapeLayer *stroke = [CAShapeLayer layer];
    stroke.frame = self.avatarImageView.bounds;
    stroke.path = maskPath.CGPath;
    stroke.lineWidth = 4.0f;
    stroke.strokeColor = [UIColor lightGrayColor].CGColor;
    stroke.fillColor = [UIColor clearColor].CGColor;
    [self.avatarImageView.layer addSublayer:stroke];
}

// TODO: Make category
/*- (void)setUser:(OUSUser *)user {
    _user = user;
    
    if([user.avatar.url.absoluteString length])
    {
        [self.imageView setImageURL:[user.avatar.url absoluteString]
                      cacheInterval:kAvatarCache];
    }
    else
    {
        [self.imageView setImage:[UIImage imageNamed:@"chatAvatar"]];
        
    }
    // NSString *teamID = [[[OneUpAppConfig sharedAppConfig] configForKey:@"TeamIDs"] firstObject];
    // NSString *URL = [NSString stringWithFormat:@"%@/%@.png", [OneUpAppConfig teamImageURL], teamID];
    // [self.teamLogo setImageURL:URL cacheInterval:OneUpImageViewCacheIntervalTeamLogos];
}*/

- (void)setShowEditButton:(BOOL)showEditButton {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 30, CGRectGetWidth(self.avatarImageView.bounds), 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor blackColor];
    label.text = [NSLocalizedString(@"edit", nil) uppercaseString];
    // TODO: Fix the font where it can be passed in.
//    label.font = [UIFont fontWithName:[OneUpAppConfig demiBoldFontName] size:12];
    label.font = [UIFont systemFontOfSize:12];

    label.textColor = [UIColor whiteColor];
    label.alpha = 0.65;
    [self.avatarImageView addSubview:label];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithOvalInRect:self.avatarImageView.bounds];
    
    CAShapeLayer *stroke = [CAShapeLayer layer];
    stroke.frame = self.avatarImageView.bounds;
    stroke.path = maskPath.CGPath;
    stroke.lineWidth = 4.0f;
    stroke.strokeColor = [UIColor lightGrayColor].CGColor;
    stroke.fillColor = [UIColor clearColor].CGColor;
    [self.avatarImageView.layer addSublayer:stroke];
}

#pragma park - Delegate: JSQMessagesAvatarImageViewDelegate

- (void)oneUpImageViewDidFinishWithDiskImage:(JSQMessagesAvatarImageView *)imageView {
    //    self.imageView.alpha = 1;
    //    self.teamLogo.alpha = 1;
}

- (void)oneUpImageViewDidFinish:(JSQMessagesAvatarImageView *)imageView {
    if (self.avatarImageView.alpha == 0) {
        [UIView animateWithDuration:0.15
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.avatarImageView.alpha = 1;
                             //                             self.teamLogo.alpha = 1;
                         } completion:^(BOOL finished) {
                             
                         }];
    }
}

#pragma mark - Public

// TODO: Fix for pass in defaults.
- (void)refreshCurrentUserImage {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *filePath = [defaults objectForKey:OUSUserDefaultsAvatarImagePathKey];
//    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
//    UIImage *image = [UIImage imageWithData:imageData];
//    if (image) {
//        self.avatarImageView.image = image;
//    }
}

- (void)updateImage:(UIImage *)image withURL:(NSURL *)URL {
    self.avatarImageView.image = image;
    [self.avatarImageView overrideCachedImageForURL:[URL absoluteString] withImage:image];
}
@end

