//
//  SettingPersonalInfoCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/22.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SettingPersonalInfoCell.h"
#import "UserData.h"
#import "UserManager.h"
#import "SettingExprienceBar.h"

@interface SettingPersonalInfoCell () 
@property (nonatomic, strong) UIImageView *settingBackgroundImageView;
@property (nonatomic, strong) UIImageView   *profilePictureBackground;
@property (nonatomic, strong) UIImageView    *profilePictureImageView;
@property (nonatomic, strong) UIView                   *containerView;
@property (nonatomic, strong) UILabel                  *nickNameLabel;
@property (nonatomic, strong) UILabel                     *levelLabel;
@property (nonatomic, strong) UILabel                  *funCountLabel;
@property (nonatomic, strong) UIButton                    *dataButton;
@property (nonatomic, strong) SettingExprienceBar       *exprienceBar;
@end
@implementation SettingPersonalInfoCell
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
    [self addSubview:self.settingBackgroundImageView];
    [self.settingBackgroundImageView addSubview:self.profilePictureBackground];
    [self.settingBackgroundImageView addSubview:self.containerView];
    [self.settingBackgroundImageView addSubview:self.exprienceBar];
    [self.profilePictureBackground addSubview:self.profilePictureImageView];
    [self.containerView addSubview:self.nickNameLabel];
    [self.containerView addSubview:self.levelLabel];
    [self.containerView addSubview:self.funCountLabel];
    [self.containerView addSubview:self.dataButton];
    
//    self.profilePictureImageView.backgroundColor = [UIColor redColor];
//    self.containerView.backgroundColor = [UIColor greenColor];
//    self.dataButton.backgroundColor = [UIColor blueColor];
//    self.nickNameLabel.backgroundColor = [UIColor orangeColor];
//    self.levelLabel.backgroundColor    = [UIColor purpleColor];
//    self.funCountLabel.backgroundColor = [UIColor redColor];
}

- (void)setSettingPersonalInfoCellData{
    if (![[UserManager manager] isLogined]) {
        //默认值
        self.nickNameLabel.text = @"芦花";
        self.levelLabel.text    = [NSString stringWithFormat:@"LV.1"];
        self.funCountLabel.text = [NSString stringWithFormat:@"粉丝数 0"];
        [self.profilePictureImageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.jf258.com/uploads/2014-08-31/062813878.jpg"]];
    }else{
        self.nickNameLabel.text = [[[UserManager manager] userData] userName];
        self.levelLabel.text    = [NSString stringWithFormat:@"LV.%ld",[[[UserManager manager] userData] userLevel]];
        self.funCountLabel.text = [NSString stringWithFormat:@"粉丝数 %ld",[[[UserManager manager] userData] userFans]];
        [self.profilePictureImageView sd_setImageWithURL:[NSURL URLWithString:[[[UserManager manager] userData] userIcon]]];
        [self.exprienceBar setShowExperience:25 withUpdateExperience:50];
    }
}

#pragma mark    添加约束
- (void)addLimit{
    WeakSelf;
    CGSize profilePictureBackgroundSize = CGSizeMake([Adaptor returnAdaptorValue:83], [Adaptor returnAdaptorValue:83]);
    CGSize profilePictureImageViewSize  = CGSizeMake([Adaptor returnAdaptorValue:74], [Adaptor returnAdaptorValue:74]);
    CGSize dataButtonSize               = CGSizeMake([Adaptor returnAdaptorValue:80], [Adaptor returnAdaptorValue:44]);
    CGFloat containerViewHeight         = [Adaptor returnAdaptorValue:60];
    CGFloat nickNameLabelHeight         = [Adaptor returnAdaptorValue:16];
    CGFloat levelLabelHeight            = [Adaptor returnAdaptorValue:40];
    CGFloat levelLabelTop               = [Adaptor returnAdaptorValue:13];
    CGFloat funCountLabelTop            = [Adaptor returnAdaptorValue:13];
    
    [self.settingBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.profilePictureBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.settingBackgroundImageView.mas_left).with.offset(22);
        make.size.mas_equalTo(profilePictureBackgroundSize);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.profilePictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(profilePictureImageViewSize);
        make.centerY.equalTo(weakSelf.profilePictureBackground);
        make.centerX.equalTo(weakSelf.profilePictureBackground);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.profilePictureBackground.mas_right).with.offset(19);
        make.right.equalTo(weakSelf.settingBackgroundImageView.mas_right).with.offset(-7);
        make.height.equalTo(@(containerViewHeight));
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.containerView.mas_left);
        make.top.equalTo(weakSelf.containerView.mas_top);
        make.height.equalTo(@(nickNameLabelHeight));
    }];
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nickNameLabel.mas_bottom).with.offset(levelLabelTop);
        make.left.equalTo(weakSelf.nickNameLabel.mas_left);
        make.bottom.equalTo(weakSelf.containerView.mas_bottom);
        make.width.equalTo(@(levelLabelHeight));
    }];
    
    [self.funCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nickNameLabel.mas_bottom).with.offset(funCountLabelTop);
        make.left.equalTo(weakSelf.levelLabel.mas_right);
        make.bottom.equalTo(weakSelf.containerView.mas_bottom);
        make.right.equalTo(weakSelf.dataButton.mas_left);
    }];
    
    [self.dataButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(weakSelf.nickNameLabel.mas_right);
        make.size.mas_equalTo(dataButtonSize);
        make.right.equalTo(weakSelf.containerView.mas_right);
        make.centerY.mas_equalTo(weakSelf.containerView);
    }];
    
    [self.exprienceBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.settingBackgroundImageView.mas_left);
        make.right.equalTo(weakSelf.settingBackgroundImageView.mas_right);
        make.bottom.equalTo(weakSelf.settingBackgroundImageView.mas_bottom);
        make.height.mas_equalTo(9);
    }];
}

#pragma mark    懒加载对象
- (UIImageView *)settingBackgroundImageView{
    if (_settingBackgroundImageView == nil) {
        _settingBackgroundImageView = [[UIImageView alloc] init];
        _settingBackgroundImageView.contentMode = UIViewContentModeScaleToFill;
        _settingBackgroundImageView.image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"settingBackground.png"]];
        _settingBackgroundImageView.userInteractionEnabled = YES;
    }
    return _settingBackgroundImageView;
}

- (UIImageView *)profilePictureBackground{
    if (_profilePictureBackground == nil) {
        _profilePictureBackground = [[UIImageView alloc] init];
        _profilePictureBackground.contentMode = UIViewContentModeScaleToFill;
        _profilePictureBackground.image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"profileBackground.png"]];
        _profilePictureBackground.layer.cornerRadius = _profilePictureBackground.frame.size.height/2;
    }
    return _profilePictureBackground;
}
- (UIImageView *)profilePictureImageView{
    if (_profilePictureImageView == nil) {
        _profilePictureImageView = [[UIImageView alloc] init];
        _profilePictureImageView.contentMode = UIViewContentModeScaleAspectFill;
        _profilePictureImageView.layer.masksToBounds = YES;
        _profilePictureImageView.layer.cornerRadius = [Adaptor returnAdaptorValue:74]/2.0;
    }
    return _profilePictureImageView;
}

- (UIView *)containerView{
    if (_containerView == nil) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (UILabel *)nickNameLabel{
    if (_nickNameLabel == nil) {
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.numberOfLines = 1;
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
        _nickNameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        _nickNameLabel.textColor = RGB(255, 255, 255);
    }
    return _nickNameLabel;
}

- (UILabel *)levelLabel{
    if (_levelLabel == nil) {
        _levelLabel = [[UILabel alloc] init];
        _levelLabel.numberOfLines = 1;
        _levelLabel.textAlignment = NSTextAlignmentLeft;
        _levelLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
        _levelLabel.textColor = RGB(255, 255, 255);
    }
    return _levelLabel;
}

- (UILabel *)funCountLabel{
    if (_funCountLabel == nil) {
        _funCountLabel = [[UILabel alloc] init];
        _funCountLabel.numberOfLines = 1;
        _funCountLabel.textAlignment = NSTextAlignmentLeft;
        _funCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
        _funCountLabel.textColor = RGB(255, 255, 255);
    }
    return _funCountLabel;
}

- (UIButton *)dataButton{
    if (_dataButton == nil) {
        _dataButton = [[UIButton alloc] init];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"personalData.png"]];
        [_dataButton setTitle:@"资料" forState:UIControlStateNormal];
        _dataButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        [_dataButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        [_dataButton setBackgroundImage:image forState:UIControlStateNormal];
        [_dataButton setBackgroundImage:image forState:UIControlStateHighlighted];
        [_dataButton addTarget:self action:@selector(changeToPersonalDataPageAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dataButton;
}

- (SettingExprienceBar *)exprienceBar{
    if (_exprienceBar == nil) {
        _exprienceBar = [SettingExprienceBar getInstance];
    }
    return _exprienceBar;
}

#pragma mark    行为
- (void)changeToPersonalDataPageAction:(UIButton *)sender{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(changeToPersonalInfoPage:)]) {
        [self.delegate changeToPersonalInfoPage:self];
    }
}
@end
