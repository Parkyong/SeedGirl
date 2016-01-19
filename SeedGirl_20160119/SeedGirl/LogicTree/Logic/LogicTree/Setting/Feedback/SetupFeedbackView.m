//
//  SetupFeedbackView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupFeedbackView.h"
@interface SetupFeedbackView ()
@property (nonatomic, strong) UILabel *placeholderLabel;
@end
@implementation SetupFeedbackView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
        self.backgroundColor = RGB(240, 242, 245);
    }
    return self;
}

- (void)initialize{
    [self addViews];
    [self addLimit];
}

#pragma mark    添加试图
- (void)addViews{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardAction:)]];
    [self addSubview:self.feedbackTextView];
    [self addSubview:self.placeholderLabel];
}

#pragma mark    添加约束
- (void)addLimit{
    WeakSelf;
    [self.feedbackTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@([Adaptor returnAdaptorValue:110]));
        make.top.equalTo(weakSelf.mas_top).with.offset(15+BarHeigthYULEI);
        make.left.equalTo(weakSelf.mas_left).with.offset(8);
        make.right.equalTo(weakSelf.mas_right).with.offset(-8);
    }];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.feedbackTextView.mas_left).with.offset(9);
        make.right.equalTo(weakSelf.feedbackTextView.mas_right).with.offset(-9);
        make.top.equalTo(weakSelf.feedbackTextView.mas_top).with.offset(9);
        make.height.mas_equalTo([Adaptor returnAdaptorValue:20]);
    }];
}

#pragma mark    懒加载对象
- (UITextView *)feedbackTextView{
    if (_feedbackTextView == nil) {
        _feedbackTextView = [[UITextView alloc] init];
        _feedbackTextView.showsHorizontalScrollIndicator = NO;
        _feedbackTextView.showsVerticalScrollIndicator   = YES;
        _feedbackTextView.delegate                       = self;
        _feedbackTextView.backgroundColor = [UIColor whiteColor];
        _feedbackTextView.layer.borderWidth  = 1;
        _feedbackTextView.layer.cornerRadius = 3;
        _feedbackTextView.layer.borderColor  = RGBA(0, 0, 0, 0.12).CGColor;
        _feedbackTextView.autoresizesSubviews = NO;
        _feedbackTextView.contentInset = UIEdgeInsetsMake([Adaptor returnAdaptorValue:9],
                                                          [Adaptor returnAdaptorValue:9],
                                                          -[Adaptor returnAdaptorValue:9],
                                                          -[Adaptor returnAdaptorValue:9]);
    }
    return _feedbackTextView;
}

- (UILabel *)placeholderLabel{
    if (_placeholderLabel == nil) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.enabled = NO;
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.textColor = RGB(205, 205, 205);
        _placeholderLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _placeholderLabel.text = @"您的宝贵意见与建议是我们前进的动力～！";
    }
    return _placeholderLabel;
}

#pragma mark    delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView.text.length == 0 && self.feedbackTextView.isFirstResponder == NO) {
        self.placeholderLabel.text = @"您的宝贵意见与建议是我们前进的动力～！";
    }else{
        self.placeholderLabel.text = @"";
    }
}

- (void)dismissKeyboardAction:(UITapGestureRecognizer *)tapGR{
    if (self.feedbackTextView.text.length == 0) {
        self.placeholderLabel.text = @"您的宝贵意见与建议是我们前进的动力～！";
    }
    [self.feedbackTextView resignFirstResponder];
}


@end
