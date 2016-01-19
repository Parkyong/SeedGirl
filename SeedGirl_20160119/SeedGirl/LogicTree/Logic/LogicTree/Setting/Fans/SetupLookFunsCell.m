//
//  SetupLookFunsCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/25.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupLookFunsCell.h"
@interface SetupLookFunsCell ()
@property (nonatomic, strong) UIView *container;
@end
@implementation SetupLookFunsCell
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
    [self addSubview:self.headImageView];
    [self addSubview:self.container];
    [self.container addSubview:self.nickNameLabel];
    [self.container addSubview:self.spendDiamondLabel];
    [self addSubview:self.noteButton];
//    self.headImageView.backgroundColor = [UIColor redColor];
//    self.container.backgroundColor     = [UIColor greenColor];
//    self.noteButton.backgroundColor    = [UIColor blueColor];
//    self.nickNameLabel.backgroundColor = [UIColor purpleColor];
//    self.spendDiamondLabel.backgroundColor = [UIColor orangeColor];
}

#pragma mark    添加限制
- (void)addLimit{
    WeakSelf;
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:58], [Adaptor returnAdaptorValue:58]));
        make.left.equalTo(weakSelf.mas_left).with.offset(13);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@([Adaptor returnAdaptorValue:40]));
        make.left.equalTo(weakSelf.headImageView.mas_right).with.offset(14);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    [self.noteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:46], [Adaptor returnAdaptorValue:19]));
        make.left.equalTo(weakSelf.container.mas_right);
        make.right.equalTo(weakSelf.mas_right).with.offset(-13);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.container.mas_left);
        make.right.equalTo(weakSelf.container.mas_right);
        make.height.equalTo(@([Adaptor returnAdaptorValue:18]));
    }];
    [self.spendDiamondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nickNameLabel.mas_bottom).with.offset(13);
        make.left.equalTo(weakSelf.container.mas_left);
        make.right.equalTo(weakSelf.container.mas_right);
        make.bottom.equalTo(weakSelf.container.mas_bottom);
    }];
}

- (void)setCellData:(FansData *)data{
    self.nickNameLabel.text = data.fansName;
    self.spendDiamondLabel.text = [NSString stringWithFormat:@"贡献砖石数 %ld",data.fansContributionDiamond];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:data.fansIcon]];
}

#pragma mark    懒加载对象
- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.contentMode = UIViewContentModeScaleToFill;
        _headImageView.layer.cornerRadius = [Adaptor returnAdaptorValue:58]/2;
        _headImageView.clipsToBounds = YES;
    }
    return _headImageView;
}

- (UIView *)container{
    if (_container == nil) {
        _container = [[UIView alloc] init];
    }
    return _container;
}

- (UIButton *)noteButton{
    if (_noteButton == nil) {
        _noteButton = [[UIButton alloc] init];
        [_noteButton setTitle:@"纸条" forState:UIControlStateNormal];
        [_noteButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _noteButton.layer.borderColor = [UIColor redColor].CGColor;
        _noteButton.layer.borderWidth = 1;
        _noteButton.layer.cornerRadius = 8;
        _noteButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    }
    return _noteButton;
}

- (UILabel *)nickNameLabel{
    if (_nickNameLabel == nil) {
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.numberOfLines = 1;
        _nickNameLabel.font = [UIFont boldSystemFontOfSize:15];
        _nickNameLabel.textColor = RGB(51, 51, 51);
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nickNameLabel;
}

- (UILabel *)spendDiamondLabel{
    if (_spendDiamondLabel == nil) {
        _spendDiamondLabel = [[UILabel alloc] init];
        _spendDiamondLabel.numberOfLines = 1;
        _spendDiamondLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        _spendDiamondLabel.textColor = RGBA(51, 51, 51, 0.8);
        _spendDiamondLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _spendDiamondLabel;
}
@end
