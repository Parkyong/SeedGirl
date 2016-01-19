//
//  VideoManagementHeaderView.m
//  SeedGirl
//
//  Created by Admin on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "VideoManagementHeaderView.h"

@interface VideoManagementHeaderView ()

//标题
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation VideoManagementHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

//加载子视图
- (void)loadSubviews {
    [self addSubview:self.titleLabel];
    
    [self addConstraints];
}

//添加约束
- (void)addConstraints {
    WeakSelf;
    //标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(14, 0, 10, 0));
    }];
}

#pragma mark - lazyload
//标题
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 1;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textColor = RGB(51, 51, 51);
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _titleLabel.text = @"管理制式视频";
    }
    return _titleLabel;
}

@end
