//
//  SetupMyDiamondLCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupMyDiamondLCell.h"
#import "BankManager.h"
#import "BankRuleData.h"
@interface SetupMyDiamondLCell ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *container;
@end
@implementation SetupMyDiamondLCell
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
    [self.container addSubview:self.diamondCount];
    [self addSubview:self.mentionAmount];
    
//    self.container.backgroundColor = [UIColor blueColor];
//    self.mentionAmount.backgroundColor = [UIColor redColor];
//    self.contentLabel.backgroundColor = [UIColor redColor];
//    self.markImageView.backgroundColor = [UIColor greenColor];
}

#pragma mark    添加约束
- (void)addLimit{
    WeakSelf;
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(7);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@20);
    }];
    
    [self.mentionAmount mas_makeConstraints:^(MASConstraintMaker *make) {
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

    [self.diamondCount mas_makeConstraints:^(MASConstraintMaker *make) {
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
    }
    return _container;
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
        _markImageView.image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"setupMydiaomond_diamond.png"]];
    }
    return _markImageView;
}

- (UITextField *)diamondCount{
    if (_diamondCount == nil) {
        _diamondCount = [[UITextField alloc] init];
        _diamondCount.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _diamondCount.textColor = RGB(51, 51, 51);
        _diamondCount.textAlignment = NSTextAlignmentLeft;
        _diamondCount.delegate = self;
        _diamondCount.placeholder = @"请输入提取金额";
        _diamondCount.returnKeyType = UIReturnKeyDone;
        _diamondCount.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _diamondCount;
}

- (UILabel *)mentionAmount{
    if (_mentionAmount == nil) {
        _mentionAmount = [[UILabel alloc] init];
        _mentionAmount.numberOfLines = 1;
        _mentionAmount.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _mentionAmount.textColor = RGB(51, 51, 51);
        _mentionAmount.textAlignment = NSTextAlignmentRight;
    }
    return _mentionAmount;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([[[BankManager manager] bankRuleData] isBind]) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark    textfield
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger fetch_cash   = [[[BankManager manager] bankRuleData] fetch_cash];
    NSInteger keep_diamond = [[[BankManager manager] bankRuleData] keep_diamond];
    NSInteger fetch_cash_count = [[[BankManager manager] bankRuleData] fetch_cash_count];
    NSInteger low_requirement  = [[[BankManager manager] bankRuleData] low_requirement];
    NSInteger inputMoney =[textField.text integerValue];
    if (inputMoney >= keep_diamond ) {
        NSLog(@"拥有钻石数不足，目前拥有钻石数为：%ld", (long)keep_diamond);
        self.diamondCount.text  = [NSString stringWithFormat:@"0"];
        self.mentionAmount.text = [NSString stringWithFormat:@"0.00元"];
        return;
    }

    if (inputMoney > fetch_cash) {
        NSLog(@"不能超过可提现额：%ld", (long)fetch_cash);
        self.diamondCount.text  = [NSString stringWithFormat:@"0"];
        self.mentionAmount.text = [NSString stringWithFormat:@"0.00元"];
        return;
    }
    
    if (keep_diamond >= low_requirement) {
        NSLog(@"钻石总数量未达到提现标准");
    }
    
    if (fetch_cash_count <= 0) {
        NSLog(@"已经超过每月可提现额度");
        return;
    }
    
    self.mentionAmount.text = [NSString stringWithFormat:@"%.2f元", [[[BankManager manager] bankRuleData] proportion] *inputMoney];
    if (self.delegate && [self.delegate respondsToSelector:@selector(setupMyDiamondLCellDisPlayMoneyCount:withMoney:)]) {
        [self.delegate setupMyDiamondLCellDisPlayMoneyCount:self withMoney:inputMoney];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.diamondCount resignFirstResponder];
    return YES;
}

- (void)resignFocusAction{
    self.diamondCount.userInteractionEnabled = NO;
}
@end