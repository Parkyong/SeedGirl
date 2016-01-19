//
//  SetupLookFunsHeader.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/25.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupLookFunsHeader.h"
@interface SetupLookFunsHeader ()
@property (nonatomic, strong) UILabel      *nameLable;
@property (nonatomic, strong) UILabel *funsCountLabel;
@end
@implementation SetupLookFunsHeader
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self addViews];
    [self addLimit];
    [self addValues];
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.nameLable];
    [self addSubview:self.funsCountLabel];
}

#pragma mark    添加限制
- (void)addLimit{
    WeakSelf;
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(weakSelf.mas_left).with.offset(9);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(weakSelf.funsCountLabel.mas_width);
    }];
    
    [self.funsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(weakSelf.nameLable.mas_height);
        make.left.equalTo(weakSelf.nameLable.mas_right);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(weakSelf.nameLable.mas_width);
        make.right.equalTo(weakSelf.mas_right).with.offset(-9);
    }];
}

#pragma mark    添加值
- (void)addValues{
    self.nameLable.text = @"粉丝排行";
    self.funsCountLabel.text = @"粉丝数：0";
}

#pragma mark    设置粉丝数
- (void)setData:(NSInteger)fansCount{
    self.funsCountLabel.text =[NSString stringWithFormat:@"粉丝数：%ld", (long)fansCount];
}

- (UILabel *)nameLable{
    if (_nameLable == nil) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.numberOfLines = 1;
        _nameLable.font = [UIFont boldSystemFontOfSize:15];
        _nameLable.textColor = RGB(51, 51, 51);
        _nameLable.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLable;
}

-(UILabel *)funsCountLabel{
    if (_funsCountLabel == nil) {
        _funsCountLabel = [[UILabel alloc] init];
        _funsCountLabel.numberOfLines = 1;
        _funsCountLabel.font = [UIFont boldSystemFontOfSize:15];
        _funsCountLabel.textColor = RGB(51, 51, 51);
        _funsCountLabel.textAlignment = NSTextAlignmentRight;
    }
    return _funsCountLabel;
}
@end
