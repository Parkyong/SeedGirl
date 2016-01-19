//
//  VideoManagementFooterView.m
//  SeedGirl
//
//  Created by Admin on 15/11/16.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "VideoManagementFooterView.h"

@interface VideoManagementFooterView ()

//提示
@property (strong, nonatomic) UILabel *tipLabel;

@end

@implementation VideoManagementFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

//加载子视图
- (void)loadSubviews {
    [self addSubview:self.tipLabel];
    
    [self addConstraints];
}

//添加约束
- (void)addConstraints {
    WeakSelf;
    //提示
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(18.0f);
        make.left.equalTo(weakSelf.mas_left);//.with.offset(8.0f);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10.0f);
        make.right.equalTo(weakSelf.mas_right);//.with.offset(-8.0f);
    }];
}

#pragma mark - Main

#pragma mark - lazyload

//标题
- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.numberOfLines = 1;
        _tipLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _tipLabel.textColor = RGB(163, 163, 163);
        _tipLabel.font = [UIFont systemFontOfSize:12.0f];
        _tipLabel.text = @"未添加制式视频的制式请求会被发送至视频请求中";
    }
    return _tipLabel;
}

@end
