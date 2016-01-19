//
//  TellStoryView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/17.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "TellStoryView.h"
@interface TellStoryView ()<UITextViewDelegate>
@property (nonatomic, strong) UILabel *tipLabel;
@end
@implementation TellStoryView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addViews];
        [self addLimits];
        self.backgroundColor = RGB(240, 242, 245);
    }
    return self;
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.textArea];
    [self addSubview:self.tipLabel];
    [self addSubview:self.downCollectionView];
//    [self addGestureRecognizer:self.tapGR];
}

#pragma mark    添加限制
- (void)addLimits{
    WeakSelf;
    [self.textArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset([Adaptor returnAdaptorValue:6+BarHeigthYULEI]);
        make.left.equalTo(weakSelf.mas_left).with.offset([Adaptor returnAdaptorValue:8]);
        make.height.mas_equalTo(@([Adaptor returnAdaptorValue:96]));
        make.right.equalTo(weakSelf.mas_right).with.offset(-[Adaptor returnAdaptorValue:8]);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.textArea.mas_bottom).with.offset([Adaptor returnAdaptorValue:13]);
        make.left.equalTo(weakSelf.textArea.mas_left);
        make.height.mas_equalTo(@([Adaptor returnAdaptorValue:20]));
        make.right.equalTo(weakSelf.textArea.mas_right);
    }];
    
    [self.downCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tipLabel.mas_bottom).with.offset([Adaptor returnAdaptorValue:15]);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}

- (UITextView *)textArea{
    if (_textArea == nil) {
        _textArea = [[UITextView alloc] initWithFrame:CGRectZero];
        _textArea.autoresizesSubviews = NO;
        _textArea.showsHorizontalScrollIndicator = NO;
        _textArea.showsVerticalScrollIndicator   = YES;
        _textArea.delegate                       = self;
        _textArea.contentInset = UIEdgeInsetsMake([Adaptor returnAdaptorValue:9],
                                                  [Adaptor returnAdaptorValue:9],
                                                  -[Adaptor returnAdaptorValue:9],
                                                  -[Adaptor returnAdaptorValue:9]);
        _textArea.font = [UIFont systemFontOfSize:16];
    }
    return _textArea;
}

- (UILabel *)tipLabel{
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _tipLabel.textColor = [UIColor grayColor];
        _tipLabel.text = @"添加多张图片或单独的视频";
    }
    return _tipLabel;
}

- (UICollectionView *)downCollectionView{
    if (_downCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _downCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _downCollectionView.showsHorizontalScrollIndicator = YES;
        _downCollectionView.showsVerticalScrollIndicator   = YES;
        _downCollectionView.userInteractionEnabled         = YES;
        _downCollectionView.backgroundColor = [UIColor clearColor];
    }
    return _downCollectionView;
}

- (UITapGestureRecognizer *)tapGR{
    if (_tapGR == nil) {
        _tapGR = [[UITapGestureRecognizer alloc] init];
    }
    return _tapGR;
}
@end