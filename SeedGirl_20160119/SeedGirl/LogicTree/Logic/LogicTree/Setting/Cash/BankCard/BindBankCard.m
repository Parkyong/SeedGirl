//
//  BindBankCard_T.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/25.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "BindBankCard.h"
@interface BindBankCard ()
@property (nonatomic, strong) UIView *baseLine;
@end
@implementation BindBankCard
- (instancetype)init{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self addViews];
    [self addLimit];
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.inputTitleLabel];
    [self addSubview:self.inputContentTextFiled];
    [self addSubview:self.baseLine];
    self.backgroundColor = [UIColor whiteColor];
}

#pragma mark    添加约束
- (void)addLimit{
    WeakSelf;
    [self.inputTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(15);
        make.height.mas_equalTo([Adaptor returnAdaptorValue:48]);
        make.width.equalTo(@70);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [self.inputContentTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.inputTitleLabel.mas_right);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(weakSelf.inputTitleLabel.mas_height);
        make.right.equalTo(weakSelf.mas_right);
    }];
    
    [self.baseLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(15);
        make.right.equalTo(weakSelf.mas_right).with.offset(-15);
        make.height.mas_equalTo(@1);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}

#pragma mark    懒加载对象
- (UILabel *)inputTitleLabel{
    if (_inputTitleLabel == nil) {
        _inputTitleLabel = [[UILabel alloc] init];
        _inputTitleLabel.textAlignment = NSTextAlignmentLeft;
        _inputTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _inputTitleLabel.textColor = RGB(51, 51, 51);
        _inputTitleLabel.numberOfLines = 1;
    }
    return _inputTitleLabel;
}

- (UITextField *)inputContentTextFiled{
    if (_inputContentTextFiled == nil) {
        _inputContentTextFiled = [[UITextField alloc] init];
        _inputContentTextFiled.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _inputContentTextFiled.clearsOnBeginEditing = YES;
    }
    return _inputContentTextFiled;
}

- (UIView *)baseLine{
    if (_baseLine == nil) {
        _baseLine = [[UIView alloc] init];
        _baseLine.backgroundColor = RGBA(0, 0, 0, 0.12);
    }
    return _baseLine;
}
@end
