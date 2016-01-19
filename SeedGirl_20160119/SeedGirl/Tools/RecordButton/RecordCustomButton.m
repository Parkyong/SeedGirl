//
//  RecordCustomButton.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/6.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "RecordCustomButton.h"
@interface RecordCustomButton ()
@property (nonatomic, strong) UIImageView                      *symbolImageView;
@property (nonatomic, strong) UILabel                               *countLabel;
@property (nonatomic, strong) UIImageView                  *backgroundImageView;
@property (nonatomic, strong) UIView                                 *container;
@property (nonatomic, copy) RecordCustomButtonActionBlockType buttonActionBlock;
@end
@implementation RecordCustomButton
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addViews];
        [self addLimits];
    }
    return self;
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.container];
    [self.container addSubview:self.symbolImageView];
    [self.container addSubview:self.countLabel];
}

#pragma mark    添加约束
- (void)addLimits{
    WeakSelf;
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.right.equalTo(weakSelf.mas_right);
    }];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.backgroundImageView.mas_centerX);
        make.centerY.equalTo(weakSelf.backgroundImageView.mas_centerY);
    }];
    
    [self.symbolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.container.mas_left);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(weakSelf.container.mas_centerY);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.container.mas_top);
        make.left.equalTo(weakSelf.symbolImageView.mas_right);
        make.bottom.equalTo(weakSelf.container.mas_bottom);
        make.right.equalTo(weakSelf.container.mas_right);
    }];
    
//    self.container.backgroundColor = [UIColor redColor];
//    self.backgroundColor = [UIColor purpleColor];
//    self.symbolImageView.backgroundColor = [UIColor yellowColor];
}

#pragma mark    懒加载对象
- (UIView *)container{
    if (_container == nil) {
        _container = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _container;
}

- (UIImageView *)symbolImageView{
    if (_symbolImageView == nil) {
        _symbolImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _symbolImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _symbolImageView;
}

- (UILabel *)countLabel{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _countLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        _countLabel.textColor = [UIColor whiteColor];
    }
    return _countLabel;
}

- (UIImageView *)backgroundImageView{
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _backgroundImageView;
}

#pragma mark    setter
- (void)setBackgroundImagePath:(NSString *)backgroundImagePath{
    if (backgroundImagePath != nil) {
        _backgroundImageView.image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:backgroundImagePath]];
    }
}

- (void)setText:(NSString *)text{
    if (text != nil) {
        _countLabel.text = text;
    }
}

- (void)setSymbolImagePath:(NSString *)symbolImagePath{
    if (symbolImagePath != nil) {
        _symbolImageView.image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:symbolImagePath]];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.buttonActionBlock != nil) {
        self.buttonActionBlock();
    }
}

- (void)addActionBlock:(RecordCustomButtonActionBlockType)block{
    if (block != nil) {
        self.buttonActionBlock = [block copy];
    }
}
@end
