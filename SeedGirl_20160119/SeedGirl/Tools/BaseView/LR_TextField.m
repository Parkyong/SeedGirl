//
//  LR_TextField.m
//  SeedGirl
//
//  Created by Admin on 15/12/24.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "LR_TextField.h"

@interface LR_TextField () <UITextFieldDelegate>

//左填充视图
@property (nonatomic, strong) UIView *leftPaddingView;
//头图片
@property (nonatomic, strong) UIImageView *headImage;
//头正常图片名称
@property (nonatomic, strong) UIImage *headNormalImage;
//头高亮图片名称
@property (nonatomic, strong) UIImage *headLightedImage;
//右填充视图
@property (nonatomic, strong) UIView *rightPaddingView;

@end

@implementation LR_TextField

- (instancetype)init {
    if (self = [super init]) {
        //属性布局
        [self attributeLayout];
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

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
    self.layer.cornerRadius = 4.0f;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = RGB(183, 186, 191).CGColor;
    
    self.delegate = self;
}
//加载子视图
- (void)loadSubviews {
    //左填充视图
    [self.leftPaddingView addSubview:self.headImage];
    [self setLeftView:self.leftPaddingView];
    [self setLeftViewMode:UITextFieldViewModeAlways];
    //右填充视图
    [self setRightView:self.rightPaddingView];
    [self setRightViewMode:UITextFieldViewModeAlways];
}

#pragma mark - Main
//设置填充高度
- (void)setPaddingHeight:(CGFloat)height {
    [self.leftPaddingView setFrame:CGRectMake(0, 0, 62.0f, height)];
    [self.headImage setFrame:CGRectMake(0, 0, 45.0f, height)];
    [self.rightPaddingView setFrame:CGRectMake(0, 0, 17.0f, height)];
}

//设置头图片
- (void)setHeadImage:(UIImage *)normalImage highlightedImage:(UIImage *)lightedImage {
    self.headNormalImage = normalImage;
    self.headLightedImage = lightedImage;
    [self.headImage setImage:normalImage];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.layer.borderColor = RGB(255, 122, 147).CGColor;
    if (self.headLightedImage != nil) {
        [self.headImage setImage:self.headLightedImage];
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    self.layer.borderColor = RGB(183, 186, 191).CGColor;
    if (self.headNormalImage != nil) {
        [self.headImage setImage:self.headNormalImage];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - lazyload
//左填充视图
- (UIView *)leftPaddingView {
    if (_leftPaddingView == nil) {
        _leftPaddingView = [[UIView alloc] init];
        _leftPaddingView.backgroundColor = [UIColor clearColor];
        _leftPaddingView.userInteractionEnabled = NO;
    }
    return _leftPaddingView;
}
//头部图片
- (UIImageView *)headImage {
    if (_headImage == nil) {
        _headImage = [[UIImageView alloc] init];
        _headImage.backgroundColor = RGB(247, 246, 250);
        _headImage.contentMode = UIViewContentModeCenter;
    }
    return _headImage;
}
//右填充视图
- (UIView *)rightPaddingView {
    if (_rightPaddingView == nil) {
        _rightPaddingView = [[UIView alloc] init];
        _rightPaddingView.backgroundColor = [UIColor clearColor];
        _rightPaddingView.userInteractionEnabled = NO;
    }
    return _rightPaddingView;
}

@end
