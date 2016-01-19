//
//  SetupMSCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupMSCell.h"
@interface SetupMSCell ()
@end
@implementation SetupMSCell
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
    [self addSubview:self.contentLabel];
    [self addSubview:self.settingSwitch];
}

#pragma mark    添加约束
- (void)addLimit{
    WeakSelf;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(15);
        make.centerY.equalTo(weakSelf);
        make.height.equalTo(@44);
    }];
    [self.settingSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right).with.offset(-15);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(51, 31));
    }];
}

#pragma mark    懒加载对象
- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 1;
        _contentLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _contentLabel.textColor = RGB(51, 51, 51);
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLabel;
}

- (UISwitch *)settingSwitch{
    if (_settingSwitch == nil) {
        _settingSwitch = [[UISwitch alloc] init];
        _settingSwitch.on = YES;
        [_settingSwitch addTarget:self action:@selector(switchButtonAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _settingSwitch;
}

#pragma mark
- (void)switchButtonAction:(UISwitch *)sender{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(changeMessageSettingWithSetupMSCell:withSwitch:)]) {
        [self.delegate changeMessageSettingWithSetupMSCell:self withSwitch:sender.on];
    }
}
@end
