//
//  OwnNewMessageImage.m
//  SeedGirl
//
//  Created by Admin on 16/1/11.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "OwnNewMessageImage.h"

@implementation OwnNewMessageImage

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //属性布局
        [self attributeLayout];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        //属性布局
        [self attributeLayout];
    }
    return self;
}

//属性布局
- (void)attributeLayout {
    self.backgroundColor = RGBA(244, 53, 49, 0.9);
    self.userInteractionEnabled = NO;
    self.layer.masksToBounds = YES;
    self.image = nil;
}

@end
