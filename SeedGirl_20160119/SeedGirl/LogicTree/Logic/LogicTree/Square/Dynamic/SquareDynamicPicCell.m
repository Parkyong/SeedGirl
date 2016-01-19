//
//  SquareDynamicPicCell.m
//  SeedGirl
//
//  Created by Admin on 15/11/25.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "SquareDynamicPicCell.h"

@interface SquareDynamicPicCell ()
//背景图片
@property (nonatomic, strong) UIImageView *picImage;
//播放按钮图片
@property (nonatomic, strong) UIImageView *videoPlayImage;
//图片总数量
@property (nonatomic, strong) UILabel *imageCountLabel;
@end

@implementation SquareDynamicPicCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

//加载子视图
- (void)loadSubviews {
    [self addSubview:self.picImage];
    
    [self addSubview:self.videoPlayImage];
    [self.videoPlayImage setHidden:YES];
    
    [self addSubview:self.imageCountLabel];
    [self.imageCountLabel setHidden:YES];
    
    [self addConstraints];
}

//添加约束
- (void)addConstraints {
    WeakSelf;
    //背景图片
    [self.picImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsZero);
    }];
    //播放按钮图片
    [self.videoPlayImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(44.0f, 44.0f));
    }];
}

#pragma mark - Main
//设置图片数据以及是否是视频
- (void)setShowPic:(NSString *)data isVideo:(BOOL)status {
    [self.imageCountLabel setHidden:YES];
    if (data == nil || [data isEqualToString:@""]) {
        [self.picImage setImage:nil];
        [self.videoPlayImage setHidden:YES];
        return ;
    }
    
    NSURL *picURL = [NSURL URLWithString:data];
    [self.picImage sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"default_pic.jpg"]];
    [self.videoPlayImage setHidden:!status];
}
//设置图片总数量
- (void)setPicMaxCount:(NSInteger)count {
    [self.imageCountLabel setHidden:YES];
    if (count > 4) {
        [self.imageCountLabel setHidden:NO];
        [self.imageCountLabel setText:[NSString stringWithFormat:@"%ld张",(long)count]];
        
        CGSize size = [self.imageCountLabel contentSizeWithMaxSize:CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        CGFloat width = size.width+8.0f;
        CGFloat height = size.height+8.0f;
        CGRect rect = CGRectMake(CGRectGetWidth(self.bounds)-width, CGRectGetHeight(self.bounds)-height, width, height);
        [self.imageCountLabel setFrame:rect];
    }
}

#pragma mark - lazyload
//背景图片
- (UIImageView *)picImage {
    if (_picImage == nil) {
        _picImage = [[UIImageView alloc] init];
        _picImage.backgroundColor = [UIColor clearColor];
        _picImage.layer.masksToBounds = YES;
        _picImage.layer.cornerRadius = 3.0f;
        _picImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _picImage;
}
//播放按钮图片
- (UIImageView *)videoPlayImage {
    if (_videoPlayImage == nil) {
        _videoPlayImage = [[UIImageView alloc] init];
        _videoPlayImage.backgroundColor = [UIColor clearColor];
        _videoPlayImage.image = [UIImage imageWithContentOfFile:@"video_button_play.png"];
    }
    return _videoPlayImage;
}
//图片总数量
- (UILabel *)imageCountLabel {
    if (_imageCountLabel == nil) {
        _imageCountLabel = [[UILabel alloc] init];
        _imageCountLabel.backgroundColor = RGBA(111, 113, 113, 0.9);
        _imageCountLabel.textAlignment = NSTextAlignmentCenter;
        _imageCountLabel.font = [UIFont systemFontOfSize:13.0f];
        _imageCountLabel.textColor = [UIColor whiteColor];
    }
    return _imageCountLabel;
}
@end
