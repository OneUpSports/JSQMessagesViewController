//
//  JSQMessagesCellConfigManager.h
//  JSQMessages
//
//  Created by Luke McDonald on 11/6/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JSQMessagesCellConfigManager : NSObject
+ (instancetype)sharedManager;

@property (strong, nonatomic) UIColor *cellBoarderColor;
@property (assign, nonatomic) CGFloat cellBoarderWidth;

@end
