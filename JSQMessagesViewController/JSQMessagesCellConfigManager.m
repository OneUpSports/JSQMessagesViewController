//
//  JSQMessagesCellConfigManager.m
//  JSQMessages
//
//  Created by Luke McDonald on 11/6/15.
//  Copyright © 2015 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCellConfigManager.h"

@implementation JSQMessagesCellConfigManager

+ (instancetype)sharedManager
{
    static JSQMessagesCellConfigManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [JSQMessagesCellConfigManager new];
    });
    
    return sharedInstance;
}

@end
