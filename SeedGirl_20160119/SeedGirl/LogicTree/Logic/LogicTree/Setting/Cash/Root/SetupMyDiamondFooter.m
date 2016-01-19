//
//  SetupMyDiamondFooter.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupMyDiamondFooter.h"
#import "BankManager.h"
#import "BankRuleData.h"
@interface SetupMyDiamondFooter ()
@property (nonatomic, strong) UIButton *takeCashButton;
@end
@implementation SetupMyDiamondFooter
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
        self.backgroundColor = RGB(240, 242, 245);
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
    [self addSubview:self.takeCashButton];
}

#pragma mark    添加约束
- (void)addLimit{
    WeakSelf;
    [self.takeCashButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:115], [Adaptor returnAdaptorValue:44]));
        make.center.mas_equalTo(weakSelf.center);
    }];
}

#pragma mark    懒加载对象
- (UIButton *)takeCashButton{
    if (_takeCashButton == nil) {
        _takeCashButton = [[UIButton alloc] init];
        [_takeCashButton setTitle:@"申请提现" forState:UIControlStateNormal];
        _takeCashButton.layer.cornerRadius = 3;
        _takeCashButton.selected           = NO;
        _takeCashButton.titleLabel.font    = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _takeCashButton.backgroundColor    = RGB(255,90,81);
        [_takeCashButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        [_takeCashButton addTarget:self action:@selector(takeCashButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _takeCashButton;
}

#pragma mark    调用函数
- (void)takeCashButtonAction:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        _takeCashButton.backgroundColor    = RGB(228,68,59);
    }else{
        _takeCashButton.backgroundColor    = RGB(255,90,81);
    }
    
    if (self.localBlock) {
        self.localBlock();
    }
}
@end
