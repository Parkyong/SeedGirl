//
//  SquareDynamicButtonView.m
//  SeedGirl
//
//  Created by Admin on 15/11/26.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "SquareDynamicButtonView.h"

@interface SquareDynamicButtonView ()
//线条
@property (nonatomic, strong) UIImageView *lineImage;
//按钮图片
@property (nonatomic, strong) UIImageView *buttonImage;
//总数
@property (nonatomic, strong) UILabel *countLabel;
@end

@implementation SquareDynamicButtonView

- (instancetype)init {
    if (self = [super init]) {
        [self loadSubviews];
    }
    return self;
}

//加载子视图
- (void)loadSubviews {
    [self setBackgroundColor:RGB(247, 246, 250)];

    [self addSubview:self.lineImage];
    [self addSubview:self.buttonImage];
    [self addSubview:self.countLabel];

    [self addConstraints];
}
//添加约束
- (void)addConstraints {
    WeakSelf;
    //线条
    [self.lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(weakSelf);
        make.height.mas_equalTo(1.5f);
    }];
    //按钮图片
    [self.buttonImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.countLabel.mas_left).with.offset(-8.0f);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(18.0f, 18.0f));
    }];
    //总数
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.lessThanOrEqualTo(weakSelf.mas_width).with.offset(-28.0f);
        make.centerX.equalTo(weakSelf.mas_centerX).with.offset(14.0f);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
}

#pragma mark - Main
//设置线条颜色及按钮图
- (void)setLineColor:(UIColor *)color ButtonImageName:(NSString *)image {
    self.lineImage.backgroundColor = color;
    self.buttonImage.image = [UIImage imageWithContentOfFile:image];
}
//设置数量
- (void)setTotalCount:(NSString *)count {
    [self.countLabel setText:count];
}

#pragma mark - lazyload
//点赞线条
- (UIImageView *)lineImage {
    if (_lineImage == nil) {
        _lineImage = [[UIImageView alloc] init];
    }
    return _lineImage;
}
//点赞图片
- (UIImageView *)buttonImage {
    if (_buttonImage == nil) {
        _buttonImage = [[UIImageView alloc] init];
    }
    return _buttonImage;
}
//点赞总数
- (UILabel *)countLabel {
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.backgroundColor = [UIColor clearColor];
        _countLabel.textAlignment = NSTextAlignmentLeft;
        _countLabel.textColor = RGBA(51, 51, 51, 0.5);
        _countLabel.font = [UIFont systemFontOfSize:16.0f];
        _countLabel.numberOfLines = 1;
        _countLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _countLabel;
}

@end
