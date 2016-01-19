//
//  ExperienceLevelCell.m
//  SeedGirl
//
//  Created by ParkHunter on 16/1/14.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "LevelCell.h"

@interface LevelCell ()
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation LevelCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self addViews];
    [self addLimits];
}

#pragma mark    添加试图
- (void)addViews{
    [self.textLabel removeFromSuperview];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.titleLabel];
}

#pragma mark    添加限制
- (void)addLimits{
    WeakSelf;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top);
        make.left.equalTo(weakSelf.contentView.mas_left);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.width.mas_equalTo([Adaptor returnAdaptorValue:60]);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_top);
        make.left.equalTo(weakSelf.titleLabel.mas_right);
        make.bottom.equalTo(weakSelf.titleLabel.mas_bottom);
        make.right.equalTo(weakSelf.contentView.mas_right);
    }];
}

#pragma mark    懒加载对象
- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines  = 0;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:14];
    }
    return _contentLabel;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines  = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

#pragma mark    设置数据
- (void)setLevelCellData:(NSString *)data withIndex:(NSInteger)index{
    self.titleLabel.text = [NSString stringWithFormat:@"等级%ld", index+1];
    self.contentLabel.text = data;
}
@end
