//
//  EditView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/11.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "EditView.h"
#import "FilterSelectView.h"
#import "FilterObject.h"
@interface EditView ()
@property (nonatomic, strong) UIView                 *upContainer;
@property (nonatomic, strong) UILabel                 *titleLabel;
@property (nonatomic, strong) UILabel                *filterLabel;
@property (nonatomic, strong) UIImageView          *showImageArea;
@property (nonatomic, strong) UIView               *downContainer;
@property (nonatomic, strong) FilterSelectView  *filterScrollView;
@end
@implementation EditView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
        self.backgroundColor = RGB(27, 27, 35);
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self setParameters];
    [self addViews];
    [self addLimit];
    [self addFunction];
}

- (void)setParameters{
    self.imageContainer = [NSMutableArray array];
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.upContainer];
    [self addSubview:self.showImageArea];
    [self addSubview:self.downContainer];
    
    [self.upContainer addSubview:self.returnButton];
    [self.upContainer addSubview:self.titleLabel];
    [self.upContainer addSubview:self.finishButton];
    
    [self.downContainer addSubview:self.filterLabel];
    [self.downContainer addSubview:self.filterScrollView];
}

#pragma mark    添加限制
- (void)addLimit{
    WeakSelf;
    [self.upContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(20);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(@44);
    }];
    
    [self.showImageArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.upContainer.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(@([Adaptor returnAdaptorValue:346]));
    }];
    
    [self.downContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showImageArea.mas_bottom);
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
    
    [self.filterScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.downContainer.mas_left);//make.right.equalTo(weakSelf.downContainer.mas_right);
        make.right.equalTo(weakSelf.downContainer.mas_right);
        make.bottom.equalTo(weakSelf.downContainer.mas_bottom).with.offset(-[Adaptor returnAdaptorValue:19]);
        make.height.equalTo(@([Adaptor returnAdaptorValue:86]));
    }];
}

#pragma mark    添加功能
- (void)addFunction{
    WeakSelf;
    self.filterScrollView.filterBlock = ^(NSInteger filterType){
        weakSelf.showImageArea.image = [[FilterObject shareHandle] getFiltrateImageWithType:filterType
                                                                        withOriginalImage:weakSelf.showImage];
        weakSelf.showImage = weakSelf.showImageArea.image;
    };
}

#pragma mark    懒加载
- (UIView *)upContainer{
    if (_upContainer == nil) {
        _upContainer = [[UIView alloc] init];
        _upContainer.backgroundColor = RGB(27, 27, 35);
    }
    return _upContainer;
}

- (UIImageView *)showImageArea{
    if (_showImageArea == nil) {
        _showImageArea = [[UIImageView alloc] init];
        _showImageArea.contentMode = UIViewContentModeScaleAspectFill;
        _showImageArea.clipsToBounds = YES;
    }
    return _showImageArea;
}

- (UIView *)downContainer{
    if (_downContainer == nil) {
        _downContainer = [[UIView alloc] init];
        _downContainer.backgroundColor = RGB(15, 15, 21);
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
        _filterLabel.text = @"选择滤镜";
    }
    return _filterLabel;
}

- (FilterSelectView *)filterScrollView{
    if (_filterScrollView == nil) {
        _filterScrollView = [[FilterSelectView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [Adaptor returnAdaptorValue:86])];
    }
    return _filterScrollView;
}

#pragma mark    功能
- (void)setShowImageViewsImage:(UIImage *)image{
    self.showImageArea.image = image;
    self.showImage = image;
}
@end