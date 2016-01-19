//
//  UIView+Expand.m
//  SeedGirl
//
//  Created by Admin on 15/11/10.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "UIView+Expand.h"

@implementation UIView (Expand)

//添加阴影
- (void)addShadowEffect {
    [self.layer setShadowColor:RGB(218, 220, 223).CGColor];
    [self.layer setShadowOffset:CGSizeMake(0, 1.0f)];
    [self.layer setShadowOpacity:0.85f];
    [self.layer setShadowRadius:0];
}

@end
