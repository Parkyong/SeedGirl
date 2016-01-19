//
//  SetupBasicSignInfoView.m
//  SeedGirl
//
//  Created by ParkHunter on 16/1/4.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "SetupBasicSignInfoView.h"
@interface SetupBasicSignInfoView ()<UITextViewDelegate>
@property (nonatomic, strong) UILabel          *titileLabel;
@property (nonatomic, strong) UITextView   *contentTextView;

@end
@implementation SetupBasicSignInfoView
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
    [self addSubview:self.contentTextView];
}

#pragma mark    添加约束
- (void)addLimits{
    WeakSelf;
    //标题
    [self.titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left).with.offset(8);
        make.height.mas_equalTo([Adaptor returnAdaptorValue:36]);
        make.width.mas_equalTo(@76);
    }];
    
   [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(weakSelf.titileLabel.mas_bottom);
       make.left.equalTo(weakSelf.mas_left).with.offset(8);
       make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-8);
       make.right.equalTo(weakSelf.mas_right).with.offset(-8);
   }];
    
//    self.titileLabel.backgroundColor     = [UIColor redColor];
//    self.contentTextView.backgroundColor = [UIColor greenColor];
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
- (UITextView *)contentTextView{
    if (_contentTextView == nil) {
        _contentTextView = [[UITextView alloc] init];
        _contentTextView.backgroundColor = RGBA(200, 200, 200,0.2);
        _contentTextView.textColor = [UIColor whiteColor];
        _contentTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        _contentTextView.userInteractionEnabled = YES;
        _contentTextView.delegate = self;
    }
    return _contentTextView;
}

#pragma mark    -setter
- (void)setName:(NSString *)name{
    _name = name;
    self.titileLabel.text = name;
}

- (void)setContentText:(NSString *)contentText{
    _contentText = contentText;
    self.contentTextView.text = contentText;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
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

- (void)textViewDidEndEditing:(UITextView *)textView{
    self.contentText = textView.text;
}

- (void)textViewDidChange:(UITextView *)textView{
    self.contentText = textView.text;
}


- (void)editedStatus{
    [self.contentTextView resignFirstResponder];
}
@end
