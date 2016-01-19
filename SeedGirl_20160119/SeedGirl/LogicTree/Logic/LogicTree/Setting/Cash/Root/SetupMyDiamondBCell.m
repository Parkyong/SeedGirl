//
//  SetupMyDiamondBCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupMyDiamondBCell.h"
#import "BankRuleData.h"
#import "BankManager.h"
@interface SetupMyDiamondBCell ()
@property (nonatomic, strong) UIView *container;
@end
@implementation SetupMyDiamondBCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    [self addSubview:self.container];
    [self.container addSubview:self.contentLabel];
    [self.container addSubview:self.markImageView];
    [self.container addSubview:self.bankCardAccount];
    [self addSubview:self.bindingButton];
}

- (void)setSetupMyDiamondBCellData{
    self.bankCardAccount.text = [[[BankManager manager] bankRuleData] card_number];
    if ([[[BankManager manager] bankRuleData] card_number] != nil &&
        [[[BankManager manager] bankRuleData] card_number].length != 0) {
        NSMutableString *cardNum = [NSMutableString stringWithString:[[[BankManager manager] bankRuleData] card_number]];
        NSRange range;
        range.location = 4;
        range.length   = cardNum.length-8;
        [cardNum replaceCharactersInRange:range withString:@"**** ****"];
        self.bankCardAccount.text = cardNum;
    }
    
    if ([[[[BankManager manager] bankRuleData] card_number] length] == 0 ) {
        [self.bindingButton setTitle:@"绑定" forState:UIControlStateNormal];
        self.bindingButton.tag = 200;
    }else{
        [self.bindingButton setTitle:@"解绑" forState:UIControlStateNormal];
        self.bindingButton.tag = 300;
    }
}

#pragma mark    添加约束
- (void)addLimit{
    WeakSelf;
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(7);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@20);
    }];

    [self.bindingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.container.mas_right);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.right.equalTo(weakSelf.mas_right).with.offset(-7);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.container.mas_top);
        make.left.equalTo(weakSelf.container.mas_left);
        make.bottom.equalTo(weakSelf.container.mas_bottom);
        make.width.equalTo(@80);
    }];
    
    [self.markImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(weakSelf.container.mas_centerY);
        make.left.equalTo(weakSelf.contentLabel.mas_right).with.offset(5);
    }];
    
    [self.bankCardAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.markImageView.mas_right).with.offset(5);
        make.top.equalTo(weakSelf.container.mas_top);
        make.bottom.equalTo(weakSelf.container.mas_bottom);
        make.right.equalTo(weakSelf.container.mas_right);
    }];
}

#pragma mark    懒加载对象
- (UIView *)container{
    if (_container == nil) {
        _container = [[UIView alloc] init];
        _container.backgroundColor = [UIColor clearColor];
    }
    return _container;
}

- (UIButton *)bindingButton{
    if (_bindingButton == nil) {
        _bindingButton = [[UIButton alloc] init];
        [_bindingButton setTitle:@"+添加/解绑" forState:UIControlStateNormal];
        _bindingButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        [_bindingButton setTitleColor:RGB(30, 178, 254) forState:UIControlStateNormal];
        [_bindingButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_bindingButton addTarget:self action:@selector(bindingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bindingButton;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 1;
        _contentLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _contentLabel.textColor = RGB(51, 51, 51);
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLabel;
}

- (UIImageView *)markImageView{
    if (_markImageView == nil) {
        _markImageView = [[UIImageView alloc] init];
        _markImageView.contentMode = UIViewContentModeScaleToFill;
        _markImageView.image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"zhaoshangyinhang.png"]];
    }
    return _markImageView;
}

- (UILabel *)bankCardAccount{
    if (_bankCardAccount == nil) {
        _bankCardAccount = [[UILabel alloc] init];
        _bankCardAccount.numberOfLines = 1;
        _bankCardAccount.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _bankCardAccount.textColor = RGB(51, 51, 51);
        _bankCardAccount.textAlignment = NSTextAlignmentLeft;
//        _bankCardAccount.adjustsFontSizeToFitWidth = YES;
    }
    return _bankCardAccount;
}

#pragma mark    绑定
- (void)bindingButtonAction:(UIButton *)sender{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(bindBankCardAction: withIsBindStatus:)]) {
        if (sender.tag == 200) {
            [self.delegate bindBankCardAction:self withIsBindStatus:YES];
        }else{
            [self.delegate bindBankCardAction:self withIsBindStatus:NO];
        }
    }
}
@end
