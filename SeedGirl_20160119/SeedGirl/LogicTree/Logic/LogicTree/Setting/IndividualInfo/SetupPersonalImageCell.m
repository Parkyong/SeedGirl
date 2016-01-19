//
//  SetupPersonalImageCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/28.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupPersonalImageCell.h"
@interface SetupPersonalImageCell ()
@property (nonatomic, strong) UIPanGestureRecognizer             *panGR;
@property (nonatomic, strong) UITapGestureRecognizer             *tapGR;
@property (nonatomic, strong) UIImageView             *deleteItemButton;
@end
@implementation SetupPersonalImageCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addViews];
        [self addLimits];
        self.isEdit = NO;
    }
    return self;
}

#pragma mark    添加试图
- (void)addViews{
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.deleteItemButton];
//    [self.headImageView addGestureRecognizer:self.tapGR];
}

#pragma mark    添加约束
- (void)addLimits{
    self.headImageView.frame     = CGRectMake(5, 5, self.bounds.size.width-5, self.bounds.size.height-5);
    self.deleteItemButton.frame  = CGRectMake(0, 0, 66, 66);
    self.deleteItemButton.center = CGPointMake(10, 10);
}

#pragma mark    点击
- (void)tapRGAction:(UITapGestureRecognizer *)tapGR{
    if (self.delegate && [self.delegate respondsToSelector:@selector(setupPersonalImageCellTapAction:withIndex:)]) {
        [self.delegate setupPersonalImageCellTapAction:self withIndex:self.indexPath];
    }
}

#pragma mark    删除
- (void)deleteItemAction:(UITapGestureRecognizer *)tapGR{
    if (self.delegate && [self.delegate respondsToSelector:@selector(setupPersonalImageCellDeleteAction:withIndex:)]) {
        [self.delegate setupPersonalImageCellDeleteAction:self withIndex:self.indexPath];
    }
}

- (void)setIsEdit:(BOOL)isEdit{
    _isEdit = isEdit;
    if (isEdit) {
        _deleteItemButton.hidden = NO;
        [self.headImageView removeGestureRecognizer:self.tapGR];
        [self startShakeView];
    }else{
        _deleteItemButton.hidden = YES;
        [self.headImageView addGestureRecognizer:self.tapGR];
        [self stopShakeView];
    }
}

#pragma mark    抖动
- (void)startShakeView{
    CATransform3D transform;
    if (arc4random() % 2 == 1)
        transform = CATransform3DMakeRotation(-0.08, 0, 0, 1.0);
    else
        transform = CATransform3DMakeRotation( 0.08, 0, 0, 1.0);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:transform];
    animation.autoreverses = YES;
    animation.duration     = 0.1;
    animation.repeatCount  = 10000;
    
    CATransform3D transform1;
    if (arc4random() % 2 == 1)
        transform1 = CATransform3DMakeRotation(-0.5, 0, 0, 1.0);
    else
        transform1 = CATransform3DMakeRotation( 0.5, 0, 0, 1.0);
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation1.toValue = [NSValue valueWithCATransform3D:transform1];
    animation1.autoreverses = YES;
    animation1.duration     = 0.1;
    animation1.repeatCount  = 10000;
    
    [[self.deleteItemButton layer] addAnimation:animation1 forKey:@"wiggleAnimation"];
    [[self.headImageView layer] addAnimation:animation forKey:@"wiggleAnimation"];
}

#pragma mark    停止抖动
- (void)stopShakeView{
    [[self.deleteItemButton layer] removeAllAnimations];
    [[self.headImageView layer] removeAllAnimations];
}

#pragma mark    设置高亮
- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    if (highlighted) {
        _headImageView.alpha = .7f;
    }else {
        _headImageView.alpha = 1.f;
    }
}

#pragma mark    懒加载对象
- (UIImageView *)deleteItemButton{
    if (_deleteItemButton == nil) {
        _deleteItemButton = [[UIImageView alloc] init];
        _deleteItemButton.image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"xButton.png"]];
        _deleteItemButton.hidden                 = YES;
        _deleteItemButton.userInteractionEnabled = YES;
        _deleteItemButton.contentMode = UIViewContentModeScaleToFill;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteItemAction:)];
        [_deleteItemButton addGestureRecognizer:tapGR];
    }
    return _deleteItemButton;
}

- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.cornerRadius     = (((ScreenWidth)-22*2-5*3)/4)*0.1;
        _headImageView.layer.borderWidth      = 2;
        _headImageView.layer.borderColor      = [UIColor grayColor].CGColor;
        _headImageView.layer.masksToBounds    = YES;
        _headImageView.userInteractionEnabled = NO;
    }
    return _headImageView;
}

- (UITapGestureRecognizer *)tapGR{
    if (_tapGR == nil) {
        _tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRGAction:)];
    }
    return _tapGR;
}
@end
