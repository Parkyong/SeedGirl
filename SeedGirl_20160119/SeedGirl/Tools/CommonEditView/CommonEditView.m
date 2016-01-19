//
//  CommonEditView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/8.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "CommonEditView.h"
@interface CommonEditView ()

@end
@implementation CommonEditView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor  = [RGB(183, 186, 191) CGColor];
        self.layer.borderWidth  = 1;
        self.layer.cornerRadius = 3;
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self addViews];
    [self addLimit];
    //    self.headButton.backgroundColor = [UIColor yellowColor];
    //    self.editArea.backgroundColor   = [UIColor blueColor];
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.headButton];
    [self addSubview:self.editArea];
}

#pragma mark    添加限制
- (void)addLimit{
    WeakSelf;
    [self.headButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.mas_equalTo(45.0f);
        //        make.width.equalTo(@([Adaptor returnAdaptorValue:38]));
    }];
    
    [self.editArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.headButton.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.right.equalTo(weakSelf.mas_right);
    }];
}

#pragma mark    代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.layer.borderColor = [RGB(255, 122, 147) CGColor];
    self.headButton.selected        = YES;
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.layer.borderColor = [RGB(183, 186, 191) CGColor];
    self.headButton.selected        = NO;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark    懒加载对象
- (UIButton *)headButton{
    if (_headButton == nil) {
        _headButton = [[UIButton alloc] init];
        _headButton.adjustsImageWhenHighlighted = NO;
    }
    return _headButton;
}

- (UITextField *)editArea{
    if (_editArea == nil) {
        _editArea = [[SGTextField alloc] init];
        _editArea.clearsOnBeginEditing = YES;
        _editArea.backgroundColor      = [UIColor whiteColor];
        _editArea.delegate             = self;
    }
    return _editArea;
}

@end
