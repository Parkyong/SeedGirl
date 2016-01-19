//
//  VideoManagementCell.m
//  SeedGirl
//
//  Created by Admin on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "VideoManagementCell.h"
#import "SystemVideoData.h"

@interface VideoManagementCell ()
//背景前图
@property (strong, nonatomic) UIImageView *iconFrontImage;
//图片
@property (strong, nonatomic) UIImageView *iconImage;
//文本区域
@property (strong, nonatomic) UIView *textView;
//标签
@property (strong, nonatomic) UILabel *tagLabel;
//价格
@property (strong, nonatomic) UILabel *priceLabel;
//播放次数
@property (strong, nonatomic) UILabel *playCountLabel;
//添加按钮
@property (strong, nonatomic) UIButton *button_add;
//修改按钮
@property (strong, nonatomic) UIButton *button_modify;
//删除按钮
@property (strong, nonatomic) UIButton *button_delete;
//线条
@property (strong, nonatomic) UIImageView *bottomLine;
@end

@implementation VideoManagementCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

//加载子视图
- (void)loadSubviews {
    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.iconFrontImage];
    
    [self.contentView addSubview:self.textView];
    [self.textView addSubview:self.tagLabel];
    [self.textView addSubview:self.priceLabel];
    [self.textView addSubview:self.playCountLabel];
    
    [self.contentView addSubview:self.button_add];
    [self.contentView addSubview:self.button_modify];
    [self.contentView addSubview:self.button_delete];
    
    [self.contentView addSubview:self.bottomLine];
    
    [self addConstraints];
}

//设置约束
- (void)addConstraints {
    WeakSelf;
    //图片
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(10.0f);
        make.size.mas_equalTo(CGSizeMake(63.0f, 63.0f));
    }];
    //背景前图
    [self.iconFrontImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.iconImage.mas_centerX);
        make.centerY.equalTo(weakSelf.iconImage.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(63.0f, 63.0f));
    }];
    //文本区域
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.left.equalTo(weakSelf.iconImage.mas_right).with.offset(10.0f);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-88.0f);
    }];
    //标签
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(weakSelf.textView.mas_top);
        make.left.equalTo(weakSelf.textView.mas_left);
        make.bottom.equalTo(weakSelf.priceLabel.mas_top).with.offset(-4.0f);
        make.right.equalTo(weakSelf.textView.mas_right);
        make.width.lessThanOrEqualTo(weakSelf.textView.mas_width);
    }];
    //价格
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.textView.mas_centerY);
        make.left.equalTo(weakSelf.textView.mas_left);
        make.right.equalTo(weakSelf.textView.mas_right);
        make.width.lessThanOrEqualTo(weakSelf.textView.mas_width);
    }];
    //播放次数
    [self.playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.priceLabel.mas_bottom).with.offset(4.0f);
        make.left.equalTo(weakSelf.textView.mas_left);
        make.bottom.greaterThanOrEqualTo(weakSelf.textView.mas_bottom);
        make.right.equalTo(weakSelf.textView.mas_right);
        make.width.lessThanOrEqualTo(weakSelf.textView.mas_width);
    }];
    //添加按钮
    [self.button_add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        //make.left.equalTo(weakSelf.textView.mas_right).with.offset(54);
        make.right.equalTo(weakSelf.contentView.mas_right);//.with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(44.0f, 44.0f));
    }];
    //修改按钮
    [self.button_modify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        //make.left.equalTo(weakSelf.textView.mas_right);//.with.offset(10);
        make.right.equalTo(weakSelf.button_delete.mas_left);
        make.size.mas_equalTo(CGSizeMake(44.0f, 44.0f));
    }];
    //删除按钮
    [self.button_delete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        //make.left.equalTo(weakSelf.textView.mas_right).with.offset(44);
        make.right.equalTo(weakSelf.contentView.mas_right);//.with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(44.0f, 44.0f));
    }];
    //线
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.right.equalTo(weakSelf.contentView.mas_right);
        make.height.mas_equalTo(1.0f);
    }];
}

#pragma mark - Main
//设置显示数据
- (void)setShowData:(SystemVideoData *)data {
    if (data.videoStatus == 1) {
        [_iconFrontImage setBackgroundColor:RGBA(0, 0, 0, 0.3)];
        [_iconFrontImage setImage:[UIImage imageWithContentOfFile:@"video_button_play.png"]];
        
        if (data.videoThumbnail != nil && ![data.videoThumbnail isEqualToString:@""]) {
            NSURL *picURL = [NSURL URLWithString:data.videoThumbnail];
            [_iconImage sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"default_pic.jpg"]];
        }
        
        [_button_add setHidden:YES];
        [_button_modify setHidden:NO];
        [_button_delete setHidden:NO];
    } else {
        [_iconFrontImage setBackgroundColor:[UIColor clearColor]];
        [_iconFrontImage setImage:[UIImage imageWithContentOfFile:@"video_button_hand.png"]];
        [_iconImage setImage:nil];
        
        [_button_add setHidden:NO];
        [_button_modify setHidden:YES];
        [_button_delete setHidden:YES];
    }
    _tagLabel.text = [NSString stringWithFormat:@"标签：%@",data.videoTitle];
    _priceLabel.text = [NSString stringWithFormat:@"价格：%ld钻",(long)data.videoPrice];
    _playCountLabel.text = [NSString stringWithFormat:@"播放次数：%ld",(long)data.videoPlayCount];
}

#pragma mark - UIResponse Event
//添加按钮点击事件
- (void)addButtonClick:(id)sender {
    if (self.addBlock) {
        self.addBlock();
    }
}
//修改按钮点击事件
- (void)modifyButtonClick:(id)sender {
    if (self.modifyBlock) {
        self.modifyBlock();
    }
}
//删除按钮点击事件
- (void)deleteButtonClick:(id)sender {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

#pragma mark - lazyload
//图片
- (UIImageView *)iconImage {
    if (_iconImage == nil) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.backgroundColor = RGB(255, 122, 147);
        _iconImage.contentMode = UIViewContentModeScaleToFill;
        _iconImage.layer.cornerRadius = 15.0f;
        _iconImage.layer.masksToBounds = YES;
    }
    return _iconImage;
}
//背景前图
- (UIImageView *)iconFrontImage {
    if (_iconFrontImage == nil) {
        _iconFrontImage = [[UIImageView alloc] init];
        _iconFrontImage.backgroundColor = [UIColor clearColor];
        _iconFrontImage.contentMode = UIViewContentModeCenter;
        _iconFrontImage.layer.cornerRadius = 15.0f;
        _iconFrontImage.layer.masksToBounds = YES;
    }
    return _iconFrontImage;
}
//文本区域
- (UIView *)textView {
    if (_textView == nil) {
        _textView = [[UIView alloc] init];
        _textView.backgroundColor = [UIColor clearColor];
    }
    return _textView;
}
//标签
- (UILabel *)tagLabel {
    if (_tagLabel == nil) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.backgroundColor = [UIColor clearColor];
        _tagLabel.textAlignment = NSTextAlignmentLeft;
        _tagLabel.numberOfLines = 1;
        _tagLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _tagLabel.textColor = RGB(51, 51, 51);
        _tagLabel.font = [UIFont systemFontOfSize:14];
        _tagLabel.text = @"标签：";
    }
    return _tagLabel;
}
//价格
- (UILabel *)priceLabel {
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.numberOfLines = 1;
        _priceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _priceLabel.textColor = RGBA(51, 51, 51, 0.8);
        _priceLabel.font = [UIFont systemFontOfSize:12];
        _priceLabel.text = @"价格：";
    }
    return _priceLabel;
}
//播放次数
- (UILabel *)playCountLabel {
    if (_playCountLabel == nil) {
        _playCountLabel = [[UILabel alloc] init];
        _playCountLabel.backgroundColor = [UIColor clearColor];
        _playCountLabel.textAlignment = NSTextAlignmentLeft;
        _playCountLabel.numberOfLines = 1;
        _playCountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _playCountLabel.textColor = RGBA(51, 51, 51, 0.8);
        _playCountLabel.font = [UIFont systemFontOfSize:12];
        _playCountLabel.text = @"播放次数：";
    }
    return _playCountLabel;
}
//添加按钮
- (UIButton *)button_add {
    if (_button_add == nil) {
        _button_add = [[UIButton alloc] init];
        _button_add.backgroundColor = [UIColor clearColor];
        [_button_add setImage:[UIImage imageWithContentOfFile:@"video_button_add.png"] forState:UIControlStateNormal];
        _button_add.adjustsImageWhenHighlighted = NO;
        [_button_add addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_add;
}
//修改按钮
- (UIButton *)button_modify {
    if (_button_modify == nil) {
        _button_modify = [[UIButton alloc] init];
        _button_modify.backgroundColor = [UIColor clearColor];
        [_button_modify setImage:[UIImage imageWithContentOfFile:@"video_button_modify.png"] forState:UIControlStateNormal];
        _button_modify.adjustsImageWhenHighlighted = NO;
        [_button_modify addTarget:self action:@selector(modifyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_modify;
}
//删除按钮
- (UIButton *)button_delete {
    if (_button_delete == nil) {
        _button_delete = [[UIButton alloc] init];
        _button_delete.backgroundColor = [UIColor clearColor];
        [_button_delete setImage:[UIImage imageWithContentOfFile:@"video_button_delete.png"] forState:UIControlStateNormal];
        _button_delete.adjustsImageWhenHighlighted = NO;
        [_button_delete addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_delete;
}
//线条
- (UIImageView *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIImageView alloc] init];
        _bottomLine.backgroundColor = RGB(218, 220, 223);
        _bottomLine.userInteractionEnabled = NO;
    }
    return _bottomLine;
}

@end
