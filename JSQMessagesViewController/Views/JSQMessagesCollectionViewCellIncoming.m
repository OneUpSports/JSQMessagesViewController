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

#import "JSQMessagesCollectionViewCellIncoming.h"

id<JSQMessagesCollectionViewCellIncomingConfigurationDataSource> incomingConfigDataSource = nil;

@interface JSQMessagesCollectionViewCellIncoming ()
@property (assign, nonatomic) AvatarBorder avatarBorder;
@end

@implementation JSQMessagesCollectionViewCellIncoming

+ (void)setIncomingConfigurationDataSource:(id<JSQMessagesCollectionViewCellIncomingConfigurationDataSource>)dataSource
{
    incomingConfigDataSource = dataSource;
}

#pragma mark - Overrides

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.messageBubbleTopLabel.textAlignment = NSTextAlignmentLeft;
    self.cellBottomLabel.textAlignment = NSTextAlignmentLeft;
    self.messageBubbleBottomLabel.textAlignment = NSTextAlignmentLeft;

    
    if ([incomingConfigDataSource respondsToSelector:@selector(incomingCellAvatarBorder:)]) {
        AvatarBorder border = [incomingConfigDataSource incomingCellAvatarBorder:self];
        if ([self isAvatarBorderInvalid:border]) {
            _avatarBorder = border;

            
      
            
            
//            CAShapeLayer *shape = [CAShapeLayer layer];
//            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.avatarContainerView.center radius:(self.avatarContainerView.bounds.size.width / 2) startAngle:0 endAngle:(2 * M_PI) clockwise:YES];
//            shape.path = path.CGPath;
//            shape.strokeColor = [UIColor redColor].CGColor;
//            shape.strokeStart = 0;
//            shape.strokeEnd = 1;
//            shape.lineWidth = 2.0;
//            shape.fillColor = nil;
//            self.avatarContainerView.layer.mask = shape;
            
//            self.avatarContainerView.avatarImageView.layer.cornerRadius = 30.0f;
//            //self.avatarContainerView.avatarImageView.frame.size.width/2;
//            self.avatarContainerView.layer.cornerRadius = 30.0f;
//            //self.avatarContainerView.avatarImageView.frame.size.width/2;
//            self.avatarContainerView.layer.masksToBounds = YES;
//            self.avatarContainerView.avatarImageView.layer.masksToBounds = YES;
//            self.avatarContainerView.avatarImageView.layer.borderWidth = _avatarBorder.width;
//            UIColor *borderColor = [UIColor redColor];
//            /*[UIColor colorWithRed:_avatarBorder.r/255.0f
//                                                   green:_avatarBorder.g/255.0f
//                                                    blue:_avatarBorder.b/255.0f
//                                                   alpha:_avatarBorder.a];*/
//            
//            self.avatarContainerView.avatarImageView.layer.borderColor = borderColor.CGColor;
        }
    }
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    
    if ([incomingConfigDataSource respondsToSelector:@selector(incomingCellAvatarBorder:)]) {
        AvatarBorder border = [incomingConfigDataSource incomingCellAvatarBorder:self];
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
                
                UIColor *strokeColor = _avatarBorder.color;//[UIColor colorWithRed:_avatarBorder.r/255.0f green:_avatarBorder.g/255.0f blue:_avatarBorder.b/255.0f alpha:1];
                
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
//
//    self.avatarContainerView.layer.cornerRadius = _avatarBorder.cornerRadius;
//    self.avatarContainerView.layer.masksToBounds = YES;
//    self.avatarContainerView.layer.borderWidth = _avatarBorder.width;
//    UIColor *borderColor = [UIColor colorWithRed:_avatarBorder.r
//                                           green:_avatarBorder.g
//                                            blue:_avatarBorder.b
//                                           alpha:_avatarBorder.a];
//    self.avatarContainerView.layer.borderColor = borderColor.CGColor;
//}

@end
