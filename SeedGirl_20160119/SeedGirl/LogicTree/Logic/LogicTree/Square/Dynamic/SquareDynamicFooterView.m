//
//  SquareDynamicFooterView.m
//  SeedGirl
//
//  Created by Admin on 16/1/6.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "SquareDynamicFooterView.h"
#import "SquareDynamicButtonView.h"

@interface SquareDynamicFooterView ()
//按钮区域
@property (nonatomic, strong) UIView *buttonView;
//观看视图
@property (nonatomic, strong) SquareDynamicButtonView *watchView;
//评论视图
@property (nonatomic, strong) SquareDynamicButtonView *commentView;
//点赞视图
@property (nonatomic, strong) SquareDynamicButtonView *praiseView;
//底部线条
@property (nonatomic, strong) UIImageView *bottomLine;
@end

@implementation SquareDynamicFooterView

- (instancetype)init {
    if (self = [super init]) {
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

//加载子视图
- (void)loadSubviews {
    //按钮区域
    [self addSubview:self.buttonView];
    //观看
    [self.buttonView addSubview:self.watchView];
    //评论
    [self.buttonView addSubview:self.commentView];
    //点赞
    [self.buttonView addSubview:self.praiseView];
    //底部线条
    [self addSubview:self.bottomLine];

    [self addConstraints];
}
//添加约束
- (void)addConstraints {
    WeakSelf;
    //按钮区域
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(weakSelf);
        make.height.mas_equalTo(45.0f);
    }];
    //观看
    [self.watchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(weakSelf.buttonView);
        make.right.equalTo(weakSelf.commentView.mas_left).with.offset(-1.0f);
        make.height.mas_equalTo(44.0f);
    }];
    //评论
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.buttonView.mas_top);
        make.right.equalTo(weakSelf.praiseView.mas_left).with.offset(-1.0f);
        make.width.and.height.equalTo(weakSelf.watchView);
    }];
    //点赞
    [self.praiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.equalTo(weakSelf.buttonView);
        make.width.and.height.equalTo(weakSelf.watchView);
    }];
    //底部线条
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.buttonView.mas_bottom);
        make.left.and.bottom.and.right.equalTo(weakSelf);
    }];
}

#pragma mark - Main
//设置观看、评论、点赞数据
- (void)setWatchCount:(NSInteger)watch commentCount:(NSInteger)comment praiseCount:(NSInteger)praise {
    [self.watchView setTotalCount:[NSString stringWithFormat:@"%ld",(long)watch]];
    [self.commentView setTotalCount:[NSString stringWithFormat:@"%ld",(long)comment]];
    [self.praiseView setTotalCount:[NSString stringWithFormat:@"%ld",(long)praise]];
}

#pragma mark - lazyload
//按钮区域
- (UIView *)buttonView {
    if (_buttonView == nil) {
        _buttonView = [[UIView alloc] init];
        _buttonView.backgroundColor = RGB(227, 228, 232);
    }
    return _buttonView;
}
//观看视图
- (SquareDynamicButtonView *)watchView {
    if (_watchView == nil) {
        _watchView = [[SquareDynamicButtonView alloc] init];
        [_watchView setLineColor:RGB(252, 110, 81) ButtonImageName:@"record_watch.png"];
    }
    return _watchView;
}
//评论视图
- (SquareDynamicButtonView *)commentView {
    if (_commentView == nil) {
        _commentView = [[SquareDynamicButtonView alloc] init];
        [_commentView setLineColor:RGB(72, 207, 173) ButtonImageName:@"record_comment.png"];
    }
    return _commentView;
}
//点赞视图
- (SquareDynamicButtonView *)praiseView {
    if (_praiseView == nil) {
        _praiseView = [[SquareDynamicButtonView alloc] init];
        [_praiseView setLineColor:RGB(172, 146, 236) ButtonImageName:@"record_praise.png"];
    }
    return _praiseView;
}
//底部线条
- (UIImageView *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIImageView alloc] init];
        _bottomLine.backgroundColor = RGB(240, 242, 245);
    }
    return _bottomLine;
}

@end
