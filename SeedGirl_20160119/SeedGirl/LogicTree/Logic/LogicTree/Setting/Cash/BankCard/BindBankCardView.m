//
//  BindBankCardView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/25.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "BindBankCardView.h"
@interface BindBankCardView () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UIButton             *bindButton;
@property (nonatomic, strong) UIPickerView         *pickerView;
@property (nonatomic, strong) NSArray                *bankName;
@property (nonatomic, strong) NSArray               *bankImage;
@end
@implementation BindBankCardView
#pragma mark    初始化
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
    [self setParameter];
    [self addFunction];
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.accountRow];
    [self addSubview:self.bankRow];
    [self addSubview:self.nameRow];
    [self addSubview:self.mobilePhoneNum];
    [self addSubview:self.bindButton];
}

#pragma mark    添加限制
- (void)addLimit{
    WeakSelf;
    [self.accountRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(6+64);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(@([Adaptor returnAdaptorValue:48]));
    }];
    
    [self.bankRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.accountRow.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(weakSelf.accountRow.mas_height);
    }];
    [self.nameRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bankRow.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(weakSelf.accountRow.mas_height);
    }];
    
    [self.mobilePhoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameRow.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(weakSelf.accountRow.mas_height);
    }];
    
    [self.bindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mobilePhoneNum.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:98], [Adaptor returnAdaptorValue:38]));
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
}

#pragma mark    设置属性
- (void)setParameter{
    self.accountRow.inputTitleLabel.text               = @"卡号";
    self.accountRow.inputContentTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    self.accountRow.inputContentTextFiled.placeholder  = @"请输入14位至24位银行卡帐号";
    self.accountRow.inputContentTextFiled.delegate     = self;
    
    self.bankRow.inputTitleLabel.text                  = @"银行";
    self.bankRow.inputContentTextFiled.placeholder     = @"选择发卡行";
    self.bankRow.inputContentTextFiled.delegate        = self;
    
    self.nameRow.inputTitleLabel.text                  = @"持卡人";
    self.nameRow.inputContentTextFiled.placeholder     = @"请输入持卡人姓名";
    self.nameRow.inputContentTextFiled.keyboardType    = UIKeyboardTypeNamePhonePad;
    self.nameRow.inputContentTextFiled.delegate        = self;
    
    self.mobilePhoneNum.inputTitleLabel.text               = @"手机号码";
    self.mobilePhoneNum.inputContentTextFiled.placeholder  = @"请输入手机号码";
    self.mobilePhoneNum.inputContentTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    self.mobilePhoneNum.inputContentTextFiled.delegate     = self;
    
    self.bankName = @[@"中国工商银行",    @"中国农业银行",
                      @"中国银行",       @"中国建设银行",
                      @"交通银行",       @"上海银行",
                      @"招商银行",       @"平安银行",
                      @"中国民生银行",    @"中信银行",
                      @"中国光大银行",    @"浦发银行",
                      @"广发银行",        @"兴业银行",
                      @"中国邮政储蓄银行", @"北京银行"];
}

#pragma mark    添加功能
- (void)addFunction{
    WeakSelf;
    self.bankRow.bankBlock = ^(){
        [weakSelf resignFirstResponderAction];
        [weakSelf addSubview:weakSelf.pickerView];
        [weakSelf.pickerView reloadAllComponents];
    };
}

#pragma mark    懒加载对象
- (BindBankCard *)accountRow{
    if (_accountRow == nil) {
        _accountRow = [[BindBankCard alloc] init];
    }
    return _accountRow;
}

- (BindBankCard_M *)bankRow{
    if (_bankRow == nil) {
        _bankRow = [[BindBankCard_M alloc] init];
    }
    return _bankRow;
}

- (BindBankCard *)nameRow{
    if (_nameRow == nil) {
        _nameRow = [[BindBankCard alloc] init];
    }
    return _nameRow;
}

- (BindBankCard *)mobilePhoneNum{
    if (_mobilePhoneNum == nil) {
        _mobilePhoneNum = [[BindBankCard alloc] init];
    }
    return _mobilePhoneNum;
}

- (UIButton *)bindButton{
    if (_bindButton == nil) {
        _bindButton = [[UIButton alloc] init];
        [_bindButton setTitle:@"绑定" forState:UIControlStateNormal];
        _bindButton.backgroundColor = RGB(0, 214, 112);
        _bindButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _bindButton.layer.cornerRadius = 3;
        [_bindButton addTarget:self action:@selector(bindBankCardAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bindButton;
}

- (UIPickerView *)pickerView{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-160, SCREEN_WIDTH, 160)];
        _pickerView.delegate   = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}

#pragma mark    绑定按钮事件
- (void)bindBankCardAction:(UIButton *)sender{
    if (0 == self.accountRow.inputContentTextFiled.text.length) {
        [self showMessage:@"请输入银行卡号"];
        [self.accountRow.inputContentTextFiled becomeFirstResponder];
        return;
    }
    
    if (0 == self.bankRow.inputContentTextFiled.text.length) {
        [self showMessage:@"请选择银行类型"];
        return;
    }
    
    if(0 == self.nameRow.inputContentTextFiled.text.length){
        [self showMessage:@"请输入持卡人姓名"];
        [self.nameRow.inputContentTextFiled becomeFirstResponder];
        return;
    }
    
    if (0 == self.mobilePhoneNum.inputContentTextFiled.text.length) {
        [self showMessage:@"请输入持卡人手机号"];
        [self.mobilePhoneNum.inputContentTextFiled becomeFirstResponder];
        return;
    }
    
    if ([ValidateTool validateBankcardNum:self.accountRow.inputContentTextFiled.text]) {
        APPLog(@"bankcard Yes");
    }else{
        [self showMessage:@"银行卡号不正确"];
        [self.accountRow.inputContentTextFiled becomeFirstResponder];
        return;
    }
    
    if ([ValidateTool validateMobile:self.mobilePhoneNum.inputContentTextFiled.text]) {
        NSLog(@"mobilePhoneNum Yes");
    }else{
        [self showMessage:@"手机号码格式不正确"];
        [self.mobilePhoneNum.inputContentTextFiled becomeFirstResponder];
        return;
    }
    
    if (self.localBlock) {
        self.localBlock();
    }
}

#pragma mark    获取信息
- (NSString *)getConfirmMessage{
    NSMutableString *confirmMessage = [NSMutableString string];
    [confirmMessage appendString:@"银行卡号:"];
    [confirmMessage appendString:self.accountRow.inputContentTextFiled.text];
    [confirmMessage appendString:@"\n"];
    
    [confirmMessage appendString:@"银行类型:"];
    [confirmMessage appendString:self.bankRow.inputContentTextFiled.text];
    [confirmMessage appendString:@"\n"];
    
    [confirmMessage appendString:@"持卡人姓名:"];
    [confirmMessage appendString:self.nameRow.inputContentTextFiled.text];
    [confirmMessage appendString:@"\n"];
    
    [confirmMessage appendString:@"手机号码:"];
    [confirmMessage appendString:self.mobilePhoneNum.inputContentTextFiled.text];
    
    return confirmMessage;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.bankName.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.bankName objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.bankRow.inputContentTextFiled.text = [self.bankName objectAtIndex:row];
    [self resignFirstResponderAction];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.pickerView != nil) {
        [self.pickerView removeFromSuperview];
        self.pickerView = nil;
    }
}

- (void)showMessage:(NSString *)message{
    OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [progressHUD showText:message];
    [progressHUD hide:YES afterDelay:1];
}

#pragma mark
- (void)resignFirstResponderAction{
    [self.accountRow.inputContentTextFiled resignFirstResponder];
    [self.bankRow.inputContentTextFiled resignFirstResponder];
    [self.nameRow.inputContentTextFiled resignFirstResponder];
    [self.mobilePhoneNum.inputContentTextFiled resignFirstResponder];
}
@end