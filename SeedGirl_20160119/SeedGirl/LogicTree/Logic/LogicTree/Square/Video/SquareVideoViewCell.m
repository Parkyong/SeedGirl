//
//  SquareVideoViewCell.m
//  SeedGirl
//
//  Created by Admin on 15/11/2.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "SquareVideoViewCell.h"
#import "VideoData.h"

@interface SquareVideoViewCell ()

//视频图片
@property (nonatomic, strong) UIImageView *videoImage;
//播放按钮
@property (nonatomic, strong) UIImageView *playImage;
//底部视图
@property (nonatomic, strong) UIView *bottomView;
//用户昵称
@property (nonatomic, strong) UILabel *nameLabel;
//观看图片
@property (nonatomic, strong) UIImageView *watchImage;
//观看总数
@property (nonatomic, strong) UILabel *watchCountLabel;

@end

@implementation SquareVideoViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //加载子视图
        [self layoutSubviews];
    }
    return self;
}

#pragma mark - Main

//加载子视图
- (void)layoutSubviews {
    [self.contentView addSubview:self.videoImage];
    [self.contentView addSubview:self.playImage];
    
    [self.contentView addSubview:self.bottomView];
    [self.bottomView addSubview:self.nameLabel];
    [self.bottomView addSubview:self.watchImage];
    [self.bottomView addSubview:self.watchCountLabel];
    
    [self addConstraints];
}

//添加约束
- (void)addConstraints {
    WeakSelf;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsZero);
    }];
    
    [self.videoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView).insets(UIEdgeInsetsMake(0, 0, 40.0f, 0));
    }];
    
    [self.playImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.videoImage.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(42.0f, 42.0f));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.videoImage.mas_bottom);
        make.left.and.bottom.and.right.equalTo(weakSelf.contentView);
    }];

    [self.watchCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.nameLabel.mas_centerY);
        make.left.equalTo(weakSelf.watchImage.mas_right).with.offset(6.0f);
        make.right.equalTo(weakSelf.bottomView.mas_right).with.offset(-8.0f);
    }];
    
    [self.watchImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.nameLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(13.0f, 13.0f));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(weakSelf.bottomView);
        make.left.equalTo(weakSelf.bottomView.mas_left).with.offset(8.0f);
        make.right.lessThanOrEqualTo(weakSelf.watchImage.mas_left).with.offset(-2.0f);
    }];
}

//设置数据
- (void)setShowData:(VideoData *)_data {
    NSURL *videoURL = [NSURL URLWithString:_data.videoThumbnail];
    [_videoImage sd_setImageWithURL:videoURL placeholderImage:[UIImage imageNamed:@"default_pic.jpg"]];
    [_nameLabel setText:_data.userName];
    [_watchCountLabel setText:[NSString stringWithFormat:@"%ld",(long)_data.watchCount]];
}

#pragma mark - lazyload
//视频图片
- (UIImageView *)videoImage {
    if (_videoImage == nil) {
        _videoImage = [[UIImageView alloc] init];
        _videoImage.backgroundColor = [UIColor clearColor];
        _videoImage.contentMode = UIViewContentModeScaleToFill;
        _videoImage.clipsToBounds = YES;
    }
    return _videoImage;
}
//播放按钮
- (UIImageView *)playImage {
    if (_playImage == nil) {
        _playImage = [[UIImageView alloc] init];
        _playImage.backgroundColor = [UIColor clearColor];
        _playImage.image = [UIImage imageWithContentOfFile:@"record_play.png"];
    }
    return _playImage;
}
//底部视图
- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
//用户昵称
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = RGB(51, 51, 51);
        _nameLabel.font = [UIFont systemFontOfSize:13.0f];
        _nameLabel.numberOfLines = 1;
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLabel;
}
//观看图片
- (UIImageView *)watchImage {
    if (_watchImage == nil) {
        _watchImage = [[UIImageView alloc] init];
        _watchImage.backgroundColor = [UIColor clearColor];
        _watchImage.image = [UIImage imageWithContentOfFile:@"square_watch.png"];
    }
    return _watchImage;
}
//观看总数
- (UILabel *)watchCountLabel {
    if (_watchCountLabel == nil) {
        _watchCountLabel = [[UILabel alloc] init];
        _watchCountLabel.backgroundColor = [UIColor clearColor];
        _watchCountLabel.textAlignment = NSTextAlignmentRight;
        _watchCountLabel.textColor = RGBA(51, 51, 51, 0.5);
        _watchCountLabel.font = [UIFont systemFontOfSize:13.0f];
        _watchCountLabel.numberOfLines = 1;
        _watchCountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _watchCountLabel;
}

@end
