//
//  SettingSignUpCell.m
//  SeedGirl
//
//  Created by ParkHunter on 16/1/13.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "SettingSignUpCell.h"
@interface SettingSignUpCell ()
@property (nonatomic, strong) UILabel *statusLabel;
@end
@implementation SettingSignUpCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self addViews];
    [self addLimit];
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.symbolImageView];
    [self addSubview:self.contentLabel];
    [self addSubview:self.statusLabel];
    //    self.symbolImageView.backgroundColor    = [UIColor redColor];
    //    self.contentLabel.backgroundColor       = [UIColor yellowColor];
    //    self.entranceImageView.backgroundColor  = [UIColor blueColor];
}

#pragma mark    添加约束
- (void)addLimit{
    WeakSelf;
    [self.symbolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(7);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.centerY.equalTo(weakSelf);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.symbolImageView.mas_right);
        make.centerY.equalTo(weakSelf);
        make.height.equalTo(weakSelf.symbolImageView.mas_height);
        make.width.mas_equalTo([Adaptor returnAdaptorValue:80]);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentLabel.mas_right);
        make.centerY.equalTo(weakSelf);
        make.height.equalTo(weakSelf.symbolImageView.mas_height);
        make.right.equalTo(weakSelf.mas_right);
    }];
}

#pragma mark    懒加载对象
- (UIImageView *)symbolImageView{
    if (_symbolImageView == nil) {
        _symbolImageView = [[UIImageView alloc] init];
        _symbolImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _symbolImageView;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 1;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = RGB(51, 51, 51);
        _contentLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    }
    return _contentLabel;
}

- (UILabel *)statusLabel{
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.numberOfLines = 1;
        _statusLabel.textAlignment = NSTextAlignmentLeft;
        _statusLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    }
    return _statusLabel;
}

- (void)setIsSignUp:(BOOL)isSignUp{
    _isSignUp = isSignUp;
    if (isSignUp) {
        self.statusLabel.text = @"已签到";
        self.statusLabel.textColor = RGB(218, 133, 72);
    }else{
        self.statusLabel.text = @"未签到";
        self.statusLabel.textColor = RGB(224, 224, 224);
    }
}
@end
