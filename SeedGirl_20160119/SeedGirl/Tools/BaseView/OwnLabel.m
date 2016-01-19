//
//  OwnLabel.m
//  SeedSocial
//
//  Created by Admin on 15/6/18.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import "OwnLabel.h"

@implementation OwnLabel
@synthesize contentEdgeInsets = _contentEdgeInsets;
@synthesize verticalAlignment = _verticalAlignment;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        self.contentEdgeInsets = UIEdgeInsetsZero;
        self.verticalAlignment = TextVerticalAlignmentMiddle;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.contentEdgeInsets = UIEdgeInsetsZero;
        self.verticalAlignment = TextVerticalAlignmentMiddle;
    }
    return self;
}

//设置内容边距
- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
    _contentEdgeInsets = contentEdgeInsets;
    [self setNeedsDisplay];
}

//设置上下显示方式
- (void)setVerticalAlignment:(TextVerticalAlignment)verticalAlignment {
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case TextVerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case TextVerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case TextVerticalAlignmentMiddle:
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

- (void)drawTextInRect:(CGRect)rect {
    CGRect actualRect = [self textRectForBounds:UIEdgeInsetsInsetRect(rect, self.contentEdgeInsets) limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end
