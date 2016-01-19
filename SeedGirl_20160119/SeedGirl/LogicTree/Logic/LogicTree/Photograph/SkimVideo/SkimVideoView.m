//
//  SkimVideoView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/14.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SkimVideoView.h"

@interface SkimVideoView ()
@property (nonatomic, strong) UIView                 *upContainer;
@property (nonatomic, strong) UILabel                 *titleLabel;
@property (nonatomic, strong) UIView               *downContainer;
@property (nonatomic, strong) UILabel                *filterLabel;
@property (nonatomic, strong) UIButton           *playVideoButton;
@end
@implementation SkimVideoView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
        self.backgroundColor = RGB(27, 27, 35);
//        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self addViews];
    [self addLimit];
//    [self addFunction];
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.upContainer];
    [self addSubview:self.showVideoArea];
    [self addSubview:self.downContainer];
    
    [self.upContainer addSubview:self.returnButton];
    [self.upContainer addSubview:self.titleLabel];
    [self.upContainer addSubview:self.finishButton];
    
    [self.showVideoArea addSubview:self.playVideoButton];
    
    [self.downContainer addSubview:self.filterLabel];
    [self.downContainer addSubview:self.coverImageView];
    [self.downContainer addSubview:self.selectCoverImageButton];
}

#pragma mark    添加限制
- (void)addLimit{
    WeakSelf;
    [self.upContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.mas_top).with.offset(20);
        make.height.equalTo(@44);
    }];
    
    [self.showVideoArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.upContainer.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(@([Adaptor returnAdaptorValue:346]));
    }];
    
    [self.playVideoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.showVideoArea.mas_centerX);
        make.centerY.equalTo(weakSelf.showVideoArea.mas_centerY);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:69], [Adaptor returnAdaptorValue:69]));
    }];
    
    [self.downContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showVideoArea.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.returnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.upContainer.mas_centerY);
        make.left.equalTo(weakSelf.upContainer.mas_left).with.offset(6);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.upContainer.mas_centerY);
        make.right.equalTo(weakSelf.upContainer.mas_right).with.offset(-6);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.upContainer.mas_top);
        make.left.equalTo(weakSelf.returnButton.mas_right);
        make.bottom.equalTo(weakSelf.upContainer.mas_bottom);
        make.right.equalTo(weakSelf.finishButton.mas_left);
    }];
    
    [self.filterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.downContainer.mas_left).with.offset([Adaptor returnAdaptorValue:7]);
        make.top.equalTo(weakSelf.downContainer.mas_top).with.offset([Adaptor returnAdaptorValue:33]);
        make.right.equalTo(weakSelf.downContainer.mas_right);
        make.height.equalTo(@([Adaptor returnAdaptorValue:18]));
    }];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.filterLabel.mas_left);
        make.bottom.equalTo(weakSelf.downContainer.mas_bottom).with.offset(-[Adaptor returnAdaptorValue:53]);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:52], [Adaptor returnAdaptorValue:52]));
    }];
    
    [self.selectCoverImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.coverImageView.mas_right).with.offset([Adaptor returnAdaptorValue:12]);
        make.bottom.equalTo(weakSelf.downContainer.mas_bottom).with.offset(-[Adaptor returnAdaptorValue:53]);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:52], [Adaptor returnAdaptorValue:52]));
    }];
}

#pragma mark    懒加载
- (UIView *)upContainer{
    if (_upContainer == nil) {
        _upContainer = [[UIView alloc] init];
//        _upContainer.backgroundColor = RGB(27, 27, 35);
        _downContainer.backgroundColor = [UIColor clearColor];

    }
    return _upContainer;
}

- (SeedPlayerView *)showVideoArea{
    if (_showVideoArea == nil) {
        _showVideoArea = [[SeedPlayerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [Adaptor returnAdaptorValue:346])];
        _showVideoArea.contentMode = UIViewContentModeScaleAspectFill;
        _showVideoArea.backgroundColor = [UIColor clearColor];
        [_showVideoArea addGestureRecognizer:self.tapGR];
    }
    return _showVideoArea;
}

- (UIView *)downContainer{
    if (_downContainer == nil) {
        _downContainer = [[UIView alloc] init];
        _downContainer.backgroundColor = [UIColor clearColor];
//        _downContainer.backgroundColor = RGB(15, 15, 21);
    }
    return _downContainer;
}

- (UIButton *)returnButton{
    if (_returnButton == nil) {
        _returnButton = [[UIButton alloc] init];
        [_returnButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"feedbackBack.png"]] forState:UIControlStateNormal];
        [_returnButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"feedbackBack.png"]] forState:UIControlStateHighlighted];
    }
    return _returnButton;
}

- (UIButton *)finishButton{
    if (_finishButton == nil) {
        _finishButton = [[UIButton alloc] init];
        [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
        [_finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _finishButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _finishButton;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"编辑";
    }
    return _titleLabel;
}

- (UILabel *)filterLabel{
    if (_filterLabel == nil) {
        _filterLabel = [[UILabel alloc] init];
        _filterLabel.textColor = [UIColor whiteColor];
        _filterLabel.textAlignment = NSTextAlignmentLeft;
        _filterLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
        _filterLabel.text = @"选择封面";
    }
    return _filterLabel;
}

- (UIImageView *)coverImageView{
    if (_coverImageView == nil) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.clipsToBounds = YES;
    }
    return _coverImageView;
}

- (UIButton *)selectCoverImageButton{
    if (_selectCoverImageButton == nil) {
        _selectCoverImageButton = [[UIButton alloc] init];
//        [_selectCoverImageButton setTitle:@"选择" forState:UIControlStateNormal];
        [_selectCoverImageButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"redAddImageView.png"]] forState:UIControlStateNormal];
        [_selectCoverImageButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"redAddImageView.png"]] forState:UIControlStateSelected];
        [_selectCoverImageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _selectCoverImageButton.backgroundColor = [UIColor redColor];
        _selectCoverImageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _selectCoverImageButton;
}

- (UIButton *)playVideoButton{
    if (_playVideoButton == nil) {
        _playVideoButton = [[UIButton alloc] init];
        _playVideoButton.hidden = YES;
        _playVideoButton.userInteractionEnabled = NO;
        [_playVideoButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"playVideoIcon.png"]] forState:UIControlStateNormal];
        [_playVideoButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"playVideoIcon.png"]] forState:UIControlStateHighlighted];
    }
    return _playVideoButton;
}

- (UITapGestureRecognizer *)tapGR{
    if (_tapGR == nil) {
        _tapGR = [[UITapGestureRecognizer alloc] init];
    }
    return _tapGR;
}

- (void)hidePlayVideoButton:(BOOL)isHidden{
    if (isHidden) {
        self.playVideoButton.hidden = YES;
    }else {
        self.playVideoButton.hidden = NO;
    }
}
@end