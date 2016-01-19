//
//  OwnTipView.m
//  SeedGirl
//
//  Created by Admin on 15/12/29.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "OwnTipView.h"

@interface OwnTipView ()
//提示文本
@property (nonatomic, strong) UILabel *tipLabel;
@end

@implementation OwnTipView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //属性布局
        [self attributeLayout];
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

//属性布局
- (void)attributeLayout {
    self.backgroundColor = RGB(240, 242, 245);
    self.userInteractionEnabled = YES;
}

//加载子视图
- (void)loadSubviews {
    [self addSubview:self.tipLabel];
}

#pragma mark - Main
//设置提示文本
- (void)setTipText:(NSString *)text {
    [self.tipLabel setText:text];
    
    CGSize size = [self.tipLabel contentSizeWithMaxSize:self.bounds.size];
    [self.tipLabel setFrame:CGRectMake(0, 0, size.width, size.height)];
    [self.tipLabel setCenter:CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2)];
}

#pragma mark - lazyload
//提示文本
- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = RGBA(51, 51, 51, 0.9);
        _tipLabel.font = [UIFont systemFontOfSize:15.0f];
        _tipLabel.numberOfLines = 0;
        _tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _tipLabel;
}

@end
