//
//  ExperienceCell.m
//  SeedGirl
//
//  Created by ParkHunter on 16/1/14.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "ExperienceCell.h"
#define MARGIN  [Adaptor returnAdaptorValue:7]
@interface ExperienceCell ()
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation ExperienceCell
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
}

#pragma mark    添加限制
- (void)addLimits{
    WeakSelf;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top);
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(MARGIN);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
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

#pragma mark    设置数据
- (void)setExperienceCellData:(NSString *)data{
    self.contentLabel.text = data;
}
@end
