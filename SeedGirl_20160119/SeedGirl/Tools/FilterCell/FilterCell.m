//
//  FilterCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/11.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "FilterCell.h"
#define NameLabel_NormalColor        RGB(255, 255, 255)
#define NameLabel_SelectedColor      RGB(255, 122, 147)
#define BottomLine_SelectedColor     RGB(255, 122, 147)
#define BackgroundColor              RGB(18, 17, 24)
@interface FilterCell ()
@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) UILabel         *nameLabel;
@property (nonatomic, strong) UIView         *bottomLine;
@end
@implementation FilterCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _type = FilterCellNormal;
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self addViews];
    [self addLimit];
}

#pragma mark 添加试图
- (void)addViews{
    [self addSubview:self.showImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.bottomLine];
}

#pragma mark 添加限制
- (void)addLimit{
    WeakSelf;
    [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:52], [Adaptor returnAdaptorValue:52]));
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showImageView.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.bottomLine.mas_top);
    }];

    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(@2);
    }];
}

#pragma mark    懒加载对象
- (UIImageView *)showImageView{
    if (_showImageView == nil) {
        _showImageView = [[UIImageView alloc] init];
        _showImageView.contentMode = UIViewContentModeScaleAspectFill;
        _showImageView.clipsToBounds = YES;
    }
    return _showImageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.numberOfLines = 1;
        _nameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        _nameLabel.textColor = NameLabel_NormalColor;
    }
    return _nameLabel;
}

- (UIView *)bottomLine{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = BottomLine_SelectedColor;
        _bottomLine.alpha = 0;
    }
    return _bottomLine;
}

- (void)setType:(FilterCellType)type{
    if (type == FilterCellNormal) {
        _nameLabel.textColor = NameLabel_NormalColor;
        _bottomLine.alpha    = 0;
    }else{
        _nameLabel.textColor = NameLabel_SelectedColor;
        _bottomLine.alpha    = 1;
    }
    _type = type;
}

- (void)setName:(NSString *)name{
    if (name != nil) {
        _nameLabel.text = name;
        _name = name;
    }
}

- (void)setImage:(UIImage *)image{
    if (image != nil) {
        _showImageView.image = image;
        _image = image;
    }
}
@end
