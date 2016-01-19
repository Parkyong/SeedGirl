//
//  UILabel+Expand.m
//  SeedSocial
//
//  Created by Admin on 15/4/27.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import "UILabel+Expand.h"

@implementation UILabel (Expand)

//计算文本尺寸
- (CGSize)contentSizeWithMaxSize:(CGSize)maxSize {
    NSMutableParagraphStyle *paragraphStype = [[NSMutableParagraphStyle alloc] init];
    [paragraphStype setLineBreakMode:self.lineBreakMode];
    [paragraphStype setAlignment:self.textAlignment];
    
    NSDictionary *contentDict = @{NSFontAttributeName : self.font,
                                  NSParagraphStyleAttributeName : paragraphStype};
    CGSize size = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:contentDict context:nil].size;
    return size;
}

//添加阴影
- (void)addShadowEffect {
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOffset:CGSizeMake(2.0f, 2.0f)];
    [self.layer setShadowOpacity:0.6f];
    [self.layer setShadowRadius:2.0f];
}

@end
