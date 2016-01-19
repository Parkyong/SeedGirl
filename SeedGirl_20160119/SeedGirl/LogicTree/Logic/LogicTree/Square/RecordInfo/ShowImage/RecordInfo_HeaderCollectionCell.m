//
//  RecordInfo_HeaderCollectionCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/18.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "RecordInfo_HeaderCollectionCell.h"

@implementation RecordInfo_HeaderCollectionCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addViews];
        [self addLimits];
    }
    return self;
}

#pragma mark    添加试图
- (void)addViews{
    [self.contentView addSubview:self.headImageView];
}

#pragma mark    添加限制
- (void)addLimits{
    WeakSelf;
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.right.equalTo(weakSelf.mas_right);
    }];
}

- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.userInteractionEnabled = YES;
        _headImageView.layer.masksToBounds    = YES;
        _headImageView.layer.cornerRadius     = 3.0f;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImageView;
}
@end
