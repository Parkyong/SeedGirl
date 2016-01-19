//
//  SettingInfoCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/23.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SettingInfoCell.h"
@interface SettingInfoCell ()
@end
@implementation SettingInfoCell
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
    [self addSubview:self.entranceImageView];
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
    }];
    [self.entranceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentLabel.mas_right);
        make.right.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.centerY.equalTo(weakSelf);
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

- (UIImageView *)entranceImageView{
    if (_entranceImageView == nil) {
        _entranceImageView = [[UIImageView alloc] init];
        _entranceImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _entranceImageView;
}
@end
