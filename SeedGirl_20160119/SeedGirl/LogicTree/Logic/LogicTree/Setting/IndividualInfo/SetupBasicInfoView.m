//
//  SetupBasicInfoView.m
//  SeedGirl
//
//  Created by ParkHunter on 16/1/4.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "SetupBasicInfoView.h"
#import "BaseSubLineView.h"
@interface SetupBasicInfoView () <UITextFieldDelegate>
@property (nonatomic, strong) UILabel          *titileLabel;
@property (nonatomic, strong) BaseSubLineView    *container;
@property (nonatomic, strong) UITextField *contentTextfiled;
@property (nonatomic, strong) UIImageView         *markView;
@end
@implementation SetupBasicInfoView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addViews];
        [self addLimits];
    }
    return self;
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.titileLabel];
    [self addSubview:self.container];
    [self.container addSubview:self.contentTextfiled];
    [self addSubview:self.markView];
}

#pragma mark    添加约束
- (void)addLimits{
    WeakSelf;
    //标题
    [self.titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left).with.offset(8);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.mas_equalTo(@76);
    }];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.titileLabel.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.contentTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.container.mas_top);
        make.left.equalTo(weakSelf.container.mas_left);
        make.bottom.equalTo(weakSelf.container.mas_bottom);
        make.right.equalTo(weakSelf.container.mas_right);
    }];
    
    [self.markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.container.mas_right);
        make.right.equalTo(weakSelf.mas_right).with.offset(-8);
        make.size.mas_equalTo(CGSizeMake(38, 38));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
}

#pragma mark    懒加载对象
//标题
- (UILabel *)titileLabel
{
    if (_titileLabel == nil) {
        _titileLabel = [[UILabel alloc] init];
        _titileLabel.numberOfLines = 1;
        _titileLabel.textColor = [UIColor whiteColor];
        _titileLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
        _titileLabel.textAlignment = NSTextAlignmentLeft;
        _titileLabel.backgroundColor = [UIColor clearColor];
    }
    return _titileLabel;
}

//编辑内容
- (UITextField *)contentTextfiled{
    if (_contentTextfiled == nil) {
        _contentTextfiled = [[UITextField alloc] init];
        _contentTextfiled.textColor = [UIColor whiteColor];
        _contentTextfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _contentTextfiled.backgroundColor = [UIColor clearColor];
        _contentTextfiled.delegate        = self;
        _contentTextfiled.userInteractionEnabled    = YES;
        _contentTextfiled.adjustsFontSizeToFitWidth = YES;
    }
    return _contentTextfiled;
}

- (UIImageView *)markView{
    if (_markView == nil) {
        _markView = [[UIImageView alloc] init];
        UIImage *defaultImage = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"pen.png"]];
        _markView.userInteractionEnabled = YES;
        [_markView setImage:defaultImage];
        [_markView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(hideKeyboardAction)]];
    }
    return _markView;
}

- (BaseSubLineView *)container{
    if (_container == nil) {
        _container = [[BaseSubLineView alloc] initWithFrame:CGRectZero withStartX:0 withEndX:0 withLineColor:[UIColor whiteColor]];
        _container.userInteractionEnabled = YES;
        _container.hidden = NO;
    }
    return _container;
}

#pragma mark    - setter
- (void)setName:(NSString *)name{
    _name = name;
    self.titileLabel.text = name;
}

- (void)setContentText:(NSString *)contentText{
    _contentText = contentText;
    self.contentTextfiled.text = contentText;
}

#pragma mark    －代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self edittingStatus];
    if (self.isShowKeyboard) {
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(textFieldActionWithIndexPath:)]) {
            [self.delegate textFieldActionWithIndexPath:self.index];
        }
        return YES;
    }else{
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(pickerViewActionWithIndexPath:)]) {
            [self.delegate pickerViewActionWithIndexPath:self.index];
        }
        return NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self editedStatus];
    self.contentText = self.contentTextfiled.text;
}

#pragma mark    编辑开始状态
- (void)edittingStatus{
    UIImage *selectImage = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"pen_s.png"]];
    self.markView.image = selectImage;
    self.contentTextfiled.textColor = RGB(255,122,147);
    [self.container changeColor:RGB(255,122,147)];
}

#pragma mark    编辑结束状态
- (void)editedStatus{
    UIImage *defaultImage = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"pen.png"]];
    self.markView.image = defaultImage;
    self.contentTextfiled.textColor = [UIColor whiteColor];
    [self.container changeColor:[UIColor whiteColor]];
    [self.contentTextfiled endEditing:YES];
}

#pragma mark    隐藏键盘
- (void)hideKeyboardAction{
    [self editedStatus];
}
@end
