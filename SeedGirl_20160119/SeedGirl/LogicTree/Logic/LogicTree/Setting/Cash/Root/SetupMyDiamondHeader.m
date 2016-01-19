//
//  SetupMyDiamondHeader.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupMyDiamondHeader.h"
#import "BankManager.h"
#import "BankRuleData.h"
#import "UserData.h"
#import "UserManager.h"
@interface SetupMyDiamondHeader ()
@property (nonatomic, strong) UIView             *container;
@property (nonatomic, strong) UIImageView *diamondImageView;
@property (nonatomic, strong) UIView   *leftBottomContainer;
@property (nonatomic, strong) UIView  *rightBottomContainer;

@end
@implementation SetupMyDiamondHeader
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
        self.backgroundColor = RGB(240, 242, 245);
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self addViews];
    [self addLimit];
    [self addValues];
}

#pragma mark    设置数据
- (void)setSetupMyDiamondHeaderData{
    self.nickNameLabel.text = [NSString stringWithFormat:@"%@",
                               [[[UserManager manager] userData] userName]];
    
    self.haveDiamondCountLabel.text = [NSString stringWithFormat:@"拥有 %ld",
                                       [[[BankManager manager] bankRuleData] keep_diamond]];
    
    self.mentionedCountLabel.text = [NSString stringWithFormat:@"可提现 %ld",
                                     [[[BankManager manager] bankRuleData] fetch_cash]];
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.container];
    [self.container addSubview:self.nickNameLabel];
    [self.container addSubview:self.diamondImageView];
    [self.container addSubview:self.leftBottomContainer];
    [self.container addSubview:self.rightBottomContainer];
    [self.leftBottomContainer addSubview:self.haveDiamondCountLabel];
    [self.rightBottomContainer addSubview:self.mentionedCountLabel];

//    self.container.backgroundColor = [UIColor blueColor];
//    self.nickNameLabel.backgroundColor = [UIColor redColor];
//    self.leftBottomContainer.backgroundColor = [UIColor purpleColor];
//    self.rightBottomContainer.backgroundColor = [UIColor yellowColor];
}

#pragma mark    添加约束
- (void)addLimit{
    WeakSelf;
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:243], [Adaptor returnAdaptorValue:240]));
        make.center.mas_equalTo(weakSelf.center);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.container.mas_left);
        make.top.equalTo(weakSelf.container.mas_top);
        make.right.equalTo(weakSelf.container.mas_right);
        make.height.equalTo(@([Adaptor returnAdaptorValue:15]));
    }];
    
    [self.diamondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.container.mas_left);
        make.right.equalTo(weakSelf.container.mas_right);
        make.top.equalTo(weakSelf.nickNameLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:243], [Adaptor returnAdaptorValue:206]));
    }];
    
    [self.leftBottomContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.diamondImageView.mas_bottom);
        make.left.equalTo(weakSelf.container.mas_left);
        make.bottom.equalTo(weakSelf.container.mas_bottom);
        make.width.equalTo(weakSelf.rightBottomContainer.mas_width);
    }];
    
    [self.rightBottomContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.diamondImageView.mas_bottom);
        make.left.equalTo(weakSelf.leftBottomContainer.mas_right);
        make.right.equalTo(weakSelf.container.mas_right);
        make.bottom.equalTo(weakSelf.container.mas_bottom);
        make.width.mas_equalTo(weakSelf.leftBottomContainer.mas_width);
    }];
    
    [self.haveDiamondCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftBottomContainer.mas_left).with.offset(22);
        make.top.equalTo(weakSelf.leftBottomContainer.mas_top);
        make.right.equalTo(weakSelf.leftBottomContainer.mas_right);
        make.bottom.equalTo(weakSelf.leftBottomContainer.mas_bottom);
    }];
    
    [self.mentionedCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.rightBottomContainer.mas_left);
        make.top.equalTo(weakSelf.rightBottomContainer.mas_top);
        make.right.equalTo(weakSelf.rightBottomContainer.mas_right).with.offset(-22);
        make.bottom.equalTo(weakSelf.rightBottomContainer.mas_bottom);
    }];
}

#pragma mark    添加值
- (void)addValues{
    self.nickNameLabel.text = @"嘻哈打工族";
    self.haveDiamondCountLabel.text = @"拥有 500";
    self.mentionedCountLabel.text = @"可提现 400";
}

#pragma mark    懒加载对象
#pragma mark    懒加载对象
- (UIView *)container{
    if (_container == nil) {
        _container = [[UIView alloc] init];
    }
    return _container;
}

- (UILabel *)nickNameLabel{
    if (_nickNameLabel == nil) {
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.numberOfLines = 1;
        _nickNameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
        _nickNameLabel.textColor = [UIColor blackColor];
        _nickNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nickNameLabel;
}

- (UIImageView *)diamondImageView{
    if (_diamondImageView == nil) {
        _diamondImageView = [[UIImageView alloc] init];
        _diamondImageView.contentMode = UIViewContentModeScaleToFill;
        _diamondImageView.image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"setupMydiaomond_diamondBackground.png"]];
    }
    return _diamondImageView;
}

- (UILabel *)haveDiamondCountLabel{
    if (_haveDiamondCountLabel == nil) {
        _haveDiamondCountLabel = [[UILabel alloc] init];
        _haveDiamondCountLabel.numberOfLines = 1;
        _haveDiamondCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _haveDiamondCountLabel.textColor = RGB(255, 122, 147);
        _haveDiamondCountLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _haveDiamondCountLabel;
}

- (UILabel *)mentionedCountLabel{
    if (_mentionedCountLabel == nil) {
        _mentionedCountLabel = [[UILabel alloc] init];
        _mentionedCountLabel.numberOfLines = 1;
        _mentionedCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _mentionedCountLabel.textColor = RGB(255, 122, 147);
        _mentionedCountLabel.textAlignment = NSTextAlignmentRight;
    }
    return _mentionedCountLabel;
}

- (UIView *)leftBottomContainer{
    if (_leftBottomContainer == nil) {
        _leftBottomContainer = [[UIView alloc] init];
        _leftBottomContainer.backgroundColor = [UIColor clearColor];
    }
    return _leftBottomContainer;
}

- (UIView *)rightBottomContainer{
    if (_rightBottomContainer == nil) {
        _rightBottomContainer = [[UIView alloc] init];
        _rightBottomContainer.backgroundColor = [UIColor clearColor];
    }
    return _rightBottomContainer;
}
@end
