//
//  SquareDynamicHeaderView.m
//  SeedGirl
//
//  Created by Admin on 16/1/6.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "SquareDynamicHeaderView.h"

@interface SquareDynamicHeaderView ()
//头像背景
@property (nonatomic, strong) UIImageView *iconBgImage;
//头像
@property (nonatomic, strong) UIImageView *iconImage;
//昵称
@property (nonatomic, strong) UILabel *nameLabel;
//等级
@property (nonatomic, strong) UILabel *levelLabel;
//时间图片
@property (nonatomic, strong) UIImageView *timeImage;
//时间
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation SquareDynamicHeaderView

- (instancetype)init {
    if (self = [super init]) {
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

//加载子视图
- (void)loadSubviews {
    [self addSubview:self.iconBgImage];
    [self addSubview:self.iconImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.levelLabel];
    [self addSubview:self.timeImage];
    [self addSubview:self.timeLabel];
    
    [self addConstraints];
}
//添加约束
- (void)addConstraints {
    WeakSelf;
    //头像相关
    [self.iconBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(74.0f, 74.0f));
    }];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.iconBgImage);
        make.size.mas_equalTo(CGSizeMake(64.0f, 64.0f));
    }];
    _iconImage.layer.cornerRadius = 64.0f/2;
    //昵称
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconBgImage.mas_right).with.offset(15);
        make.bottom.equalTo(weakSelf.iconBgImage.mas_bottom).with.offset(-43.0f);
    }];
    //等级
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLabel.mas_right).with.offset(2);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20);
        make.centerY.equalTo(weakSelf.nameLabel.mas_centerY);
    }];
    //时间相关
    [self.timeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconBgImage.mas_top).with.offset(43.0f);
        make.left.equalTo(weakSelf.iconBgImage.mas_right).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.timeImage.mas_right).with.offset(6);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20.0f);
        make.centerY.equalTo(weakSelf.timeImage.mas_centerY);
    }];
}

#pragma mark - Main
//设置个人信息
- (void)setUserIcon:(NSString *)url name:(NSString *)name level:(NSInteger)level {
    NSURL *iconURL = [NSURL URLWithString:url];
    [_iconImage sd_setImageWithURL:iconURL placeholderImage:[UIImage imageNamed:@"icon_girl.png"]];
    [_nameLabel setText:name];
    [_levelLabel setText:[NSString stringWithFormat:@"LV.%ld",(long)level]];
}
//设置记录时间
- (void)setRecordTime:(NSString *)time {
    [_timeLabel setText:time];
}

#pragma mark - lazyload
//头像背景
- (UIImageView *)iconBgImage {
    if (_iconBgImage == nil) {
        _iconBgImage = [[UIImageView alloc] init];
        _iconBgImage.backgroundColor = [UIColor clearColor];
        _iconBgImage.image = [UIImage imageWithContentOfFile:@"record_userIcon.png"];
    }
    return _iconBgImage;
}
//头像
- (UIImageView *)iconImage {
    if (_iconImage == nil) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.backgroundColor = [UIColor clearColor];
        _iconImage.contentMode = UIViewContentModeScaleAspectFill;
        _iconImage.layer.masksToBounds = YES;
    }
    return _iconImage;
}
//昵称
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = RGB(51, 51, 51);
        _nameLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _nameLabel.numberOfLines = 1;
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLabel;
}
//等级
- (UILabel *)levelLabel {
    if (_levelLabel == nil) {
        _levelLabel = [[UILabel alloc] init];
        _levelLabel.backgroundColor = [UIColor clearColor];
        _levelLabel.textAlignment = NSTextAlignmentRight;
        _levelLabel.textColor = RGB(172, 172, 172);
        _levelLabel.font = [UIFont systemFontOfSize:16.0f];
        _levelLabel.numberOfLines = 1;
        _levelLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _levelLabel;
}
//时间图片
- (UIImageView *)timeImage {
    if (_timeImage == nil) {
        _timeImage = [[UIImageView alloc] init];
        _timeImage.backgroundColor = [UIColor clearColor];
        _timeImage.image = [UIImage imageWithContentOfFile:@"record_time.png"];
    }
    return _timeImage;
}
//时间
- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = RGB(172, 172, 172);
        _timeLabel.font = [UIFont systemFontOfSize:16.0f];
        _timeLabel.numberOfLines = 1;
        _timeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _timeLabel;
}

@end
