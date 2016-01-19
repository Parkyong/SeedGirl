//
//  AlbumItemCell.m
//  RecordingTest
//
//  Created by ParkHunter on 15/8/7.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "AlbumItemCell.h"
@interface AlbumItemCell ()
@property (nonatomic, strong) UIImageView *markView;
@end
@implementation AlbumItemCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addViews];
    }
    return self;
}

#pragma mark     添加试图
- (void)addViews{
    [self.contentView addSubview:self.photoImageView];
    [self.contentView addSubview:self.markView];
}

- (UIImageView *)photoImageView
{
    if (_photoImageView == nil) {
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _photoImageView;
}

#pragma mark    小图标
- (UIImageView *)markView{
    if (_markView == nil) {
        _markView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,
                                                                  self.frame.size.width,
                                                                  self.frame.size.height)];
        _markView.image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"overlay.png"]];
        _markView.hidden = YES;
    }
    return _markView;
}

#pragma mark    设置封面
- (void)setIsPhotoImageSelected:(BOOL)isPhotoImageSelected{
    _isPhotoImageSelected = isPhotoImageSelected;
    if (isPhotoImageSelected) {
        _markView.hidden = NO;
    }else{
        _markView.hidden = YES;
    }
}
@end
