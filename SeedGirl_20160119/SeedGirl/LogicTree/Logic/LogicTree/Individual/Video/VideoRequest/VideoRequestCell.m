//
//  VideoRequestCell.m
//  SeedGirl
//
//  Created by Admin on 15/10/14.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "VideoRequestCell.h"
#import "VideoRequestData.h"
#import "OwnNewMessageImage.h"

@interface VideoRequestCell ()
//头像
@property (strong, nonatomic) UIImageView *iconImage;
//昵称
@property (strong, nonatomic) UILabel *nameLabel;
//时间
@property (strong, nonatomic) UILabel *timeLabel;
//消息
@property (strong, nonatomic) UILabel *messageLabel;
//状态
@property (strong, nonatomic) UILabel *statusLabel;
//状态按钮
@property (strong, nonatomic) UIButton *button_status;
//线条
@property (strong, nonatomic) UIImageView *bottomLine;
//视频请求新消息图片
@property (strong, nonatomic) OwnNewMessageImage *requestMessageImage;
//请求数据
@property (strong, nonatomic) VideoRequestData *requestData;
@end

@implementation VideoRequestCell

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
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.messageLabel];
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.button_status];
    [self.contentView addSubview:self.bottomLine];
    [self.contentView addSubview:self.requestMessageImage];
    [self.requestMessageImage setHidden:YES];

    [self addConstraints];
}

//设置约束
- (void)addConstraints {
    WeakSelf;
    //头像
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).with.offset(10.0f);
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(10.0f);
        make.size.mas_equalTo(CGSizeMake(68.0f, 68.0f));
    }];
    self.iconImage.layer.cornerRadius = 34.0f;
    //昵称
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconImage.mas_top).with.offset(7.0f);
        make.left.equalTo(weakSelf.iconImage.mas_right).with.offset(9.0f);
    }];
    //时间
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.nameLabel.mas_centerY);
        make.left.equalTo(weakSelf.nameLabel.mas_right).with.offset(2.0f);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-10);
    }];
    //消息
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).with.offset(6.0f);
        make.left.equalTo(weakSelf.nameLabel.mas_left);
        make.right.equalTo(weakSelf.button_status.mas_left).with.offset(2.0f);
    }];
    //状态
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.messageLabel.mas_bottom).with.offset(5.0f);
        make.left.equalTo(weakSelf.nameLabel.mas_left);
        make.right.equalTo(weakSelf.button_status.mas_left).with.offset(2.0f);
    }];
    //状态按钮
    [self.button_status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timeLabel.mas_bottom).with.offset(8.0f);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-14.0f);
        make.size.mas_equalTo(CGSizeMake(50.0f, 44.0f));
    }];
    //线
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.right.equalTo(weakSelf.contentView.mas_right);
        make.height.mas_equalTo(1.0f);
    }];
    //视频请求新消息图片
    [self.requestMessageImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconImage).with.offset(5.0f);
        make.right.equalTo(weakSelf.iconImage).with.offset(-5.0f);
        make.size.mas_equalTo(CGSizeMake(10.0f, 10.0f));
    }];
    self.requestMessageImage.layer.cornerRadius = 5.0f;
}

#pragma mark - Main
//设置显示数据
- (void)setShowData:(VideoRequestData *)data {
    if (data == nil) {
        return ;
    }
    
    _requestData = data;
    
    NSURL *pic_url = [NSURL URLWithString:_requestData.userIcon];
    [_iconImage sd_setImageWithURL:pic_url placeholderImage:[UIImage imageNamed:@"icon_boy.jpg"]];
    
    [_nameLabel setText:_requestData.userName];
    [_timeLabel setText:_requestData.requestTime];
    [_messageLabel setText:[NSString stringWithFormat:@"附加信息：%@",_requestData.requestMessage]];
    
    //状态 : 0 等待回复中；1已回复；－1已拒绝；－2已取消
    NSString *statusText = @"";
    NSString *statusButtonText = @"";
    NSMutableAttributedString *combinString = nil;
    switch (_requestData.requestStatus) {
        case 0:
        default:
            statusText = @"正在等待回复中";
            statusButtonText = @"查看";
            break;
        case 1:
            statusText = @"已回复";
            statusButtonText = @"删除";

            break;
        case -1:
            statusText = @"已拒绝";
            statusButtonText = @"删除";
            break;
        case -2:
            statusText = @"已取消";
            statusButtonText = @"删除";
            break;
    }
    combinString = [self getcontent:[NSString stringWithFormat:@"状态：%@",statusText]
                         withStatus:_requestData.requestStatus];
    [_statusLabel setAttributedText:combinString];
    [_button_status setTitle:statusButtonText forState:UIControlStateNormal];
}
- (NSMutableAttributedString *)getcontent:(NSString *)string withStatus:(NSInteger)status{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
    UIColor *textColor = nil;
    switch (status) {
        case -2:
            textColor = [UIColor grayColor];
            break;
        case -1:
            textColor = [UIColor blackColor];
            break;
        case 0:
            textColor = [UIColor redColor];
            break;
        case 1:
            textColor = [UIColor greenColor];
            break;
        default:
            break;
    }
    // 设置数字为红色
    [attri addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(3, string.length-3)];
    return attri;
}
//显示视频新消息提醒
- (void)showRequestNewMessage:(BOOL)status {
    [self.requestMessageImage setHidden:!status];
}

#pragma mark - UIResponse Event
//状态按钮点击事件
- (void)statusButtonClick:(id)sender {
    if (_requestData == nil) {
        return ;
    }
    
    //status : 0 查看；1/－1/－2 删除
    if (_requestData.requestStatus == 0) {
        if (self.showBlock) {
            self.showBlock();
        }
    } else {
        if (self.deleteBlock) {
            self.deleteBlock();
        }
    }
}

#pragma mark - lazyload
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
        _nameLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _nameLabel.numberOfLines = 1;
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLabel;
}
//时间
- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = RGBA(51, 51, 51, 0.7);
        _timeLabel.font = [UIFont systemFontOfSize:12.0f];
        _timeLabel.numberOfLines = 1;
        _timeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _timeLabel;
}
//消息
- (UILabel *)messageLabel {
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.textColor = RGBA(51, 51, 51, 0.7);
        _messageLabel.font = [UIFont systemFontOfSize:12.0f];
        _messageLabel.numberOfLines = 1;
        _messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _messageLabel;
}
//状态
- (UILabel *)statusLabel {
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textAlignment = NSTextAlignmentLeft;
        _statusLabel.textColor = RGBA(51, 51, 51, 0.7);
        _statusLabel.font = [UIFont systemFontOfSize:12.0f];
        _statusLabel.numberOfLines = 1;
        _statusLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _statusLabel;
}
//状态按钮
- (UIButton *)button_status {
    if (_button_status == nil) {
        _button_status = [[UIButton alloc] init];
        _button_status.backgroundColor = [UIColor clearColor];
        [_button_status setBackgroundImage:[UIImage imageWithContentOfFile:@"video_button_status_up.png"] forState:UIControlStateNormal];
        [_button_status setBackgroundImage:[UIImage imageWithContentOfFile:@"video_button_status_down.png"] forState:UIControlStateHighlighted];
        [_button_status addTarget:self action:@selector(statusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_button_status setTitle:@"查看" forState:UIControlStateNormal];
        [_button_status setTitleColor:RGB(255, 122, 147) forState:UIControlStateNormal];
        [_button_status.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    }
    return _button_status;
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
//视频请求新消息图片
- (OwnNewMessageImage *)requestMessageImage {
    if (_requestMessageImage == nil) {
        _requestMessageImage = [[OwnNewMessageImage alloc] init];
    }
    return _requestMessageImage;
}

@end
