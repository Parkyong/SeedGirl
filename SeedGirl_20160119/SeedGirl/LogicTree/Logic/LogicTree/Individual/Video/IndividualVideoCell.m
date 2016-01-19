//
//  IndividualVideoCell.m
//  SeedGirl
//
//  Created by Admin on 16/1/11.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "IndividualVideoCell.h"
#import "OwnNewMessageImage.h"

@interface IndividualVideoCell ()
//类型图片
@property (nonatomic, strong) UIImageView *typeImage;
//类型标题
@property (nonatomic, strong) UILabel *titleLabel;
//视频请求新消息图片
@property (nonatomic, strong) OwnNewMessageImage *requestMessageImage;
@end

@implementation IndividualVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

//加载子视图
- (void)loadSubviews {
    [self.contentView addSubview:self.typeImage];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.requestMessageImage];
    [self.requestMessageImage setHidden:YES];
    
    [self addConstraint];
}
//设置约束
- (void)addConstraint {
    WeakSelf;
    //类型图片
    [self.typeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(12.0f);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15.0f, 15.0f));
    }];
    //类型标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typeImage.mas_right).with.offset(12.0f);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
    }];
    //视频请求新消息图片
    [self.requestMessageImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel).with.offset(-2.0f);
        make.left.equalTo(weakSelf.titleLabel.mas_right).with.offset(1.0f);
        make.size.mas_equalTo(CGSizeMake(6.0f, 6.0f));
    }];
    self.requestMessageImage.layer.cornerRadius = 3.0f;
}

#pragma mark - Main
//设置显示图片及标题
- (void)setShowPic:(UIImage *)image Title:(NSString *)title {
    [self.typeImage setImage:image];
    [self.titleLabel setText:title];
}
//显示视频新消息提醒
- (void)showRequestNewMessage:(BOOL)status {
    [self.requestMessageImage setHidden:!status];
}

#pragma mark - lazyload
//类型图片
- (UIImageView *)typeImage {
    if (_typeImage == nil) {
        _typeImage = [[UIImageView alloc] init];
        _typeImage.backgroundColor = [UIColor clearColor];
        _typeImage.contentMode = UIViewContentModeCenter;
    }
    return _typeImage;
}
//类型标题
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _titleLabel.textColor = RGB(51, 51, 51);
    }
    return _titleLabel;
}
//视频请求新消息图片
- (OwnNewMessageImage *)requestMessageImage {
    if (_requestMessageImage == nil) {
        _requestMessageImage = [[OwnNewMessageImage alloc] init];
    }
    return _requestMessageImage;
}

@end
