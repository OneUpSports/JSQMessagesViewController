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

#import "JSQMessagesCollectionViewCellOutgoing.h"

id<JSQMessagesCollectionViewCellOutgoingConfigurationDataSource> outgoingConfigDataSource = nil;

@interface JSQMessagesCollectionViewCellOutgoing ()
@property (assign, nonatomic) AvatarBorder avatarBorder;
@end

@implementation JSQMessagesCollectionViewCellOutgoing

+ (void)setOutgoingConfigurationDataSource:(id<JSQMessagesCollectionViewCellOutgoingConfigurationDataSource>)dataSource
{
    outgoingConfigDataSource = dataSource;
    NSLog(@"...");
}

#pragma mark - Overrides

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.messageBubbleTopLabel.textAlignment = NSTextAlignmentRight;
    self.cellBottomLabel.textAlignment = NSTextAlignmentRight;
    
    if ([outgoingConfigDataSource respondsToSelector:@selector(outgoingCellAvatarBorder:)]) {
        AvatarBorder border = [outgoingConfigDataSource outgoingCellAvatarBorder:self];
        if ([self isAvatarBorderInvalid:border]) {
            self.avatarBorder = border;

//            UIBezierPath *maskPath = [UIBezierPath bezierPathWithOvalInRect:self.avatarContainerView.bounds];
//            
//            CAShapeLayer *maskLayer = [CAShapeLayer layer];
//            maskLayer.frame = self.avatarContainerView.bounds;
//            maskLayer.path = maskPath.CGPath;
//            
//            self.avatarContainerView.layer.mask = maskLayer;
//            
//            CAShapeLayer *stroke = [CAShapeLayer layer];
//            stroke.frame = self.avatarContainerView.bounds;
//            stroke.path = maskPath.CGPath;
//            stroke.lineWidth = 4.0f;
//            stroke.strokeColor = [UIColor lightGrayColor].CGColor;
//            stroke.fillColor = [UIColor clearColor].CGColor;
//            [self.avatarContainerView.layer addSublayer:stroke];
            
            
//            CAShapeLayer *shape = [CAShapeLayer layer];
//            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.avatarContainerView.center radius:(self.avatarContainerView.bounds.size.width / 2) startAngle:0 endAngle:(2 * M_PI) clockwise:YES];
//            shape.path = path.CGPath;
//            shape.strokeColor = [UIColor redColor].CGColor;
//            shape.strokeStart = 0;
//            shape.strokeEnd = 1;
//            shape.lineWidth = 2.0;
//            self.avatarContainerView.layer.mask = shape;
            
//            self.avatarContainerView.avatarImageView.layer.cornerRadius = 30;
//            self.avatarContainerView.layer.cornerRadius = 30;
//            self.avatarContainerView.layer.masksToBounds = YES;
//            self.avatarContainerView.layer.borderWidth = _avatarBorder.width;
//            UIColor *borderColor = [UIColor redColor];
//      
//            
//            self.avatarContainerView.layer.borderColor = borderColor.CGColor;
        }
    }
    
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    if ([outgoingConfigDataSource respondsToSelector:@selector(outgoingCellAvatarBorder:)]) {
        AvatarBorder border = [outgoingConfigDataSource outgoingCellAvatarBorder:self];
        if ([self isAvatarBorderInvalid:border]) {
            _avatarBorder = border;
            
            if (!CGSizeEqualToSize(self.avatarContainerView.avatarImageView.frame.size, CGSizeZero)) {
                self.avatarContainerView.avatarImageView.layer.mask = nil;
                if (self.avatarContainerView.avatarImageView.layer.sublayers.count > 0) {
                    [self.avatarContainerView.avatarImageView.layer.sublayers[0] removeFromSuperlayer];
                }
                UIBezierPath *maskPath = [UIBezierPath bezierPathWithOvalInRect:self.avatarContainerView.avatarImageView.bounds];
                
                CAShapeLayer *maskLayer = [CAShapeLayer layer];
                maskLayer.frame = self.avatarContainerView.avatarImageView.bounds;
                maskLayer.path = maskPath.CGPath;
                
                self.avatarContainerView.avatarImageView.layer.mask = maskLayer;
                
                CAShapeLayer *stroke = [CAShapeLayer layer];
                stroke.frame = self.avatarContainerView.avatarImageView.bounds;
                stroke.path = maskPath.CGPath;
                stroke.lineWidth = _avatarBorder.width;
                
                UIColor *strokeColor = _avatarBorder.color;
                stroke.strokeColor = strokeColor.CGColor;
                stroke.fillColor = [UIColor clearColor].CGColor;
                
                [self.avatarContainerView.avatarImageView.layer addSublayer:stroke];
            }
        }
    }
}

//- (void)setAvatarBorder:(AvatarBorder)avatarBorder
//{
//    _avatarBorder = avatarBorder;
//    self.avatarContainerView.layer.cornerRadius = _avatarBorder.cornerRadius;
//    self.avatarContainerView.layer.masksToBounds = YES;
//    self.avatarContainerView.layer.borderWidth = _avatarBorder.width;
//    UIColor *borderColor = [UIColor colorWithRed:_avatarBorder.r
//                                           green:_avatarBorder.g
//                                            blue:_avatarBorder.b
//                                           alpha:_avatarBorder.a];
//    
//    self.avatarContainerView.layer.borderColor = borderColor.CGColor;
//}

@end
