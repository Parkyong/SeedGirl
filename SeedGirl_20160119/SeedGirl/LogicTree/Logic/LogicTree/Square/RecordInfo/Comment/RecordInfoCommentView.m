//
//  RecordInfoCommentView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/9.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "RecordInfoCommentView.h"
@interface RecordInfoCommentView ()<UITextViewDelegate>
@property (nonatomic, strong) UILabel *placeholderLabel;
@end
@implementation RecordInfoCommentView

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
    [self addSubview:self.commentTextView];
    [self addSubview:self.placeholderLabel];
}

#pragma mark    添加约束
- (void)addLimit{
    WeakSelf;
    [self.commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@([Adaptor returnAdaptorValue:110]));
        make.top.equalTo(weakSelf.mas_top).with.offset(15+BarHeigthYULEI);
        make.left.equalTo(weakSelf.mas_left).with.offset(8);
        make.right.equalTo(weakSelf.mas_right).with.offset(-8);
    }];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.commentTextView.mas_left).with.offset(9);
        make.right.equalTo(weakSelf.commentTextView.mas_right).with.offset(-9);
        make.top.equalTo(weakSelf.commentTextView.mas_top).with.offset(9);
        make.height.mas_equalTo([Adaptor returnAdaptorValue:20]);
    }];
}

#pragma mark    懒加载对象
- (UITextView *)commentTextView{
    if (_commentTextView == nil) {
        _commentTextView = [[UITextView alloc] init];
        _commentTextView.showsHorizontalScrollIndicator = NO;
        _commentTextView.showsVerticalScrollIndicator   = YES;
        _commentTextView.delegate                       = self;
        _commentTextView.contentInset                   = UIEdgeInsetsMake([Adaptor returnAdaptorValue:9],
                                                                           [Adaptor returnAdaptorValue:9],
                                                                           -[Adaptor returnAdaptorValue:9],
                                                                           -[Adaptor returnAdaptorValue:9]);
        _commentTextView.backgroundColor = [UIColor whiteColor];
        _commentTextView.layer.borderWidth  = 1;
        _commentTextView.layer.cornerRadius = 3;
        _commentTextView.layer.borderColor  = RGBA(0, 0, 0, 0.12).CGColor;
        _commentTextView.autoresizesSubviews = NO;
        _commentTextView.font = [UIFont systemFontOfSize:16];
        
    }
    return _commentTextView;
}

- (UILabel *)placeholderLabel{
    if (_placeholderLabel == nil) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.enabled = NO;
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.textColor = RGB(205, 205, 205);
        _placeholderLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _placeholderLabel.text = @"写评论！";
    }
    return _placeholderLabel;
}

#pragma mark    delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView.text.length == 0 && self.commentTextView.isFirstResponder == NO) {
        self.placeholderLabel.text = @"写评论";
    }else{
        self.placeholderLabel.text = @"";
    }
}

- (void)dismissKeyboardAction:(UITapGestureRecognizer *)tapGR{
    if (self.commentTextView.text.length == 0) {
        self.placeholderLabel.text = @"写评论";
    }
    [self.commentTextView resignFirstResponder];
}
@end
