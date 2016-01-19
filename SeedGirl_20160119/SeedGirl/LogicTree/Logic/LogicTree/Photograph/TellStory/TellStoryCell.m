//
//  TellStoryCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/17.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "TellStoryCell.h"
@interface TellStoryCell ()
@property (nonatomic, strong) UIButton     *deleteButton;
@end
@implementation TellStoryCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addViews];
        [self addLimits];
        self.backgroundColor = RGB(240, 242, 245);
    }
    return self;
}

- (void)addViews{
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.deleteButton];
}

- (void)addLimits{
    self.headImageView.frame     = CGRectMake(5, 5,
                                              self.bounds.size.width-5,
                                              self.bounds.size.height-5);
    self.deleteButton.frame      = CGRectMake(0, 0, 66, 66);
    self.deleteButton.center     = CGPointMake(10, 10);
}

#pragma mark    懒加载对象
- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headImageView.userInteractionEnabled = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

- (UIButton *)deleteButton{
    if (_deleteButton == nil) {
        _deleteButton = [[UIButton alloc] initWithFrame:CGRectZero];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"xButton.png"]];
        [_deleteButton setImage:image forState:UIControlStateNormal];
        [_deleteButton setImage:image forState:UIControlStateSelected];
        [_deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (void)setDeleteButtonHidden:(BOOL)isHidden{
    self.deleteButton.hidden = isHidden;
}

- (void)deleteButtonAction:(UIButton *)sender{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(deleteImageWithCell:withIndex:)]) {
        [self.delegate deleteImageWithCell:self withIndex:self.indexPath];
    }
}
@end