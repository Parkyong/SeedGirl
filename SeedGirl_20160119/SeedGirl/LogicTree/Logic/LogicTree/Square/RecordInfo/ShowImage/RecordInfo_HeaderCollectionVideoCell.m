//
//  RecordInfo_HeaderCollectionVideoCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/12/30.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "RecordInfo_HeaderCollectionVideoCell.h"
@interface RecordInfo_HeaderCollectionVideoCell ()
@property (nonatomic, strong) UIView      *backView;
@property (nonatomic, strong) UIImageView *playView;
@end
@implementation RecordInfo_HeaderCollectionVideoCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.backView addSubview:self.playView];
        [self.headImageView addSubview:self.backView];
        [self.contentView addSubview:self.headImageView];
        [self addAutoLayoutContainer];
    }
    return self;
}

- (void)addAutoLayoutContainer{
    WeakSelf;
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headImageView.mas_top);
        make.left.equalTo(weakSelf.headImageView.mas_left);
        make.bottom.equalTo(weakSelf.headImageView.mas_bottom);
        make.right.equalTo(weakSelf.headImageView.mas_right);
    }];
    
    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.backView.mas_centerX);
        make.centerY.equalTo(weakSelf.backView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
}

- (UIView *)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                            self.headImageView.frame.size.width,
                                                            self.headImageView.frame.size.height)];
        _backView.backgroundColor = RGBA(0, 0, 0, 0.2);
    }
    return _backView;
}

- (UIImageView *)playView{
    if (_playView == nil) {
        _playView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _playView.image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"video_button_play.png"]];
    }
    
    return _playView;
}
@end
