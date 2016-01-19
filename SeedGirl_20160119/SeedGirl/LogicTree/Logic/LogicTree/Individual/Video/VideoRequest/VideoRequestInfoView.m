//
//  VideoRequestInfoView.m
//  SeedGirl
//
//  Created by Admin on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "VideoRequestInfoView.h"
#import "VideoRequestData.h"

@interface VideoRequestInfoView ()

//来源
@property (nonatomic, strong) UILabel *fromLabel;
//头像背景
@property (nonatomic, strong) UIImageView *iconBgImage;
//头像
@property (nonatomic, strong) UIImageView *iconImage;
//昵称
@property (nonatomic, strong) UILabel *nameLabel;
//附加消息
@property (nonatomic, strong) UILabel *messageTipLabel;
@property (nonatomic, strong) UILabel *messageLabel;
//钻石
@property (nonatomic, strong) UILabel *costTipLabel;
@property (nonatomic, strong) UILabel *costLabel;
//状态
@property (nonatomic, strong) UILabel *statusLabel;
//接受按钮
@property (nonatomic, strong) UIButton *button_accept;
//拒绝按钮
@property (nonatomic, strong) UIButton *button_refuse;

@end

@implementation VideoRequestInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

//加载子视图
- (void)loadSubviews {
    [self addSubview:self.fromLabel];
    [self addSubview:self.iconBgImage];
    [self addSubview:self.iconImage];
    [self addSubview:self.nameLabel];
    //附加消息
    [self addSubview:self.messageTipLabel];
    [self addSubview:self.messageLabel];
    //钻石
    [self addSubview:self.costTipLabel];
    [self addSubview:self.costLabel];
    //状态
    [self addSubview:self.statusLabel];
    //接收按钮
    [self addSubview:self.button_accept];
    //拒绝按钮
    [self addSubview:self.button_refuse];
    
    [self addConstraint];
    
    [self.statusLabel setHidden:YES];
    [self.button_accept setHidden:YES];
    [self.button_refuse setHidden:YES];
}

//添加约束
- (void)addConstraint {
    WeakSelf;
    //来源
    [self.fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(25.0f);
        make.left.equalTo(weakSelf.iconBgImage.mas_left).with.offset(-5.0f);
        make.right.equalTo(weakSelf.mas_right);
    }];
    //头像背景
    [self.iconBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.fromLabel.mas_bottom).with.offset(15.0f);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(110.0f, 110.0f));
    }];
    //头像
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.iconBgImage);
        make.size.mas_equalTo(CGSizeMake(100.0f, 100.0f));
    }];
    self.iconImage.layer.cornerRadius = 50.0f;
    //昵称
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconBgImage.mas_bottom).with.offset(30.0f);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    //附加消息
    [self.messageTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).with.offset(8.0f);
        make.left.equalTo(weakSelf.mas_left);
        make.width.equalTo(weakSelf.mas_width).multipliedBy(0.5);
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.messageTipLabel.mas_centerY);
        make.left.equalTo(weakSelf.messageTipLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right);
    }];
    //钻石
    [self.costTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.messageLabel.mas_bottom).with.offset(8.0f);
        make.left.equalTo(weakSelf);
        make.width.equalTo(weakSelf.mas_width).multipliedBy(0.5);
    }];
    [self.costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.costTipLabel.mas_centerY);
        make.left.equalTo(weakSelf.costTipLabel.mas_right);
        make.right.equalTo(weakSelf);
    }];
    //状态
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.costLabel.mas_bottom).with.offset(35.0f);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    //接受按钮
    [self.button_accept mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.costLabel.mas_bottom).with.offset(35.0f);
        make.centerX.equalTo(weakSelf.mas_centerX).with.offset(-68.5f);
        make.size.mas_equalTo(CGSizeMake(112.0f, 44.0f));
    }];
    //拒绝按钮
    [self.button_refuse mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.button_accept.mas_centerY);
        make.left.equalTo(weakSelf.button_accept.mas_right).with.offset(25.0f);
        make.size.mas_equalTo(CGSizeMake(112.0f, 44.0f));
    }];
}

#pragma mark - Main

//设置显示数据
- (void)setShowData:(VideoRequestData *)data {
    if (data == nil) {
        return ;
    }

    NSURL *pic_url = [NSURL URLWithString:data.userIcon];
    [_iconImage sd_setImageWithURL:pic_url placeholderImage:[UIImage imageNamed:@"icon_boy.jpg"]];
    
    [_nameLabel setText:data.userName];
    [_messageLabel setText:data.requestMessage];
    [_costLabel setText:[NSString stringWithFormat:@"%ld颗",(long)data.requestCost]];
    
    //状态 : 0 等待回复中；1已回复；－1已拒绝；－2已取消
    switch (data.requestStatus) {
        case 0:
            [self.statusLabel setHidden:YES];
            [self.button_accept setHidden:NO];
            [self.button_refuse setHidden:NO];
            break;
        case 1:
            [self.statusLabel setHidden:NO];
            [self.statusLabel setText:[NSString stringWithFormat:@"已回复，获得钻石%ld颗",(long)data.requestCost]];
            [self.button_accept setHidden:YES];
            [self.button_refuse setHidden:YES];
            break;
        case -1:
            [self.statusLabel setHidden:NO];
            [self.statusLabel setText:[NSString stringWithFormat:@"已拒绝，理由：%@",data.requestRefuseReason]];
            [self.button_accept setHidden:YES];
            [self.button_refuse setHidden:YES];
            break;
        case -2:
            [self.statusLabel setHidden:NO];
            [self.statusLabel setText:@"已取消"];
            [self.button_accept setHidden:YES];
            [self.button_refuse setHidden:YES];
            break;
        default:
            break;
    }
}

#pragma mark - UIResponse Event
//接受按钮点击事件
- (void)acceptButtonClick:(id)sender {
    if (self.acceptBlock) {
        self.acceptBlock();
    }
}
//拒绝按钮点击事件
- (void)refuseButtonClick:(id)sender {
    if (self.refuseBlock) {
        self.refuseBlock();
    }
}

#pragma mark - lazyload
//来源
- (UILabel *)fromLabel {
    if (_fromLabel == nil) {
        _fromLabel = [[UILabel alloc] init];
        _fromLabel.backgroundColor = [UIColor clearColor];
        _fromLabel.textAlignment = NSTextAlignmentLeft;
        _fromLabel.textColor = RGB(51, 51, 51);
        _fromLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        _fromLabel.numberOfLines = 1;
        _fromLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _fromLabel.text = @"来自";
    }
    return _fromLabel;
}
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
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = RGB(51, 51, 51);
        _nameLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _nameLabel.numberOfLines = 1;
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLabel;
}
//附加消息
- (UILabel *)messageTipLabel {
    if (_messageTipLabel == nil) {
        _messageTipLabel = [[UILabel alloc] init];
        _messageTipLabel.backgroundColor = [UIColor clearColor];
        _messageTipLabel.textAlignment = NSTextAlignmentRight;
        _messageTipLabel.textColor = RGB(51, 51, 51);
        _messageTipLabel.font = [UIFont systemFontOfSize:13.0f];
        _messageTipLabel.text = @"附加消息：";
    }
    return _messageTipLabel;
}
- (UILabel *)messageLabel {
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.textColor = RGB(51, 51, 51);
        _messageLabel.font = [UIFont systemFontOfSize:13.0f];
        _messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _messageLabel;
}
//钻石
- (UILabel *)costTipLabel {
    if (_costTipLabel == nil) {
        _costTipLabel = [[UILabel alloc] init];
        _costTipLabel.backgroundColor = [UIColor clearColor];
        _costTipLabel.textAlignment = NSTextAlignmentRight;
        _costTipLabel.textColor = RGB(51, 51, 51);
        _costTipLabel.font = [UIFont systemFontOfSize:13.0f];
        _costTipLabel.text = @"钻石提供：";
    }
    return _costTipLabel;
}
- (UILabel *)costLabel {
    if (_costLabel == nil) {
        _costLabel = [[UILabel alloc] init];
        _costLabel.backgroundColor = [UIColor clearColor];
        _costLabel.textAlignment = NSTextAlignmentLeft;
        _costLabel.textColor = RGB(51, 51, 51);
        _costLabel.font = [UIFont systemFontOfSize:13.0f];
        _costLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _costLabel;
}
//状态
- (UILabel *)statusLabel {
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.textColor = RGB(51, 51, 51);
        _statusLabel.font = [UIFont systemFontOfSize:15.0f];
        _statusLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _statusLabel;
}
//接受按钮
- (UIButton *)button_accept {
    if (_button_accept == nil) {
        _button_accept = [[UIButton alloc] init];
        UIImage *bgImage = [UIImage imageWithContentOfFile:@"video_button_accept.png"];
        [_button_accept setBackgroundImage:[bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 3.5f, 0, 3.5f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        [_button_accept setTitle:@"接受" forState:UIControlStateNormal];
        [_button_accept setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button_accept.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        _button_accept.adjustsImageWhenHighlighted = NO;
        [_button_accept addTarget:self action:@selector(acceptButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_accept;
}
//拒绝按钮
- (UIButton *)button_refuse {
    if (_button_refuse == nil) {
        _button_refuse = [[UIButton alloc] init];
        UIImage *bgImage = [UIImage imageWithContentOfFile:@"video_button_refuse.png"];
        [_button_refuse setBackgroundImage:[bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 3.5f, 0, 3.5f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        [_button_refuse setTitle:@"拒绝" forState:UIControlStateNormal];
        [_button_refuse setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button_refuse.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        _button_refuse.adjustsImageWhenHighlighted = NO;
        [_button_refuse addTarget:self action:@selector(refuseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_refuse;
}

@end
