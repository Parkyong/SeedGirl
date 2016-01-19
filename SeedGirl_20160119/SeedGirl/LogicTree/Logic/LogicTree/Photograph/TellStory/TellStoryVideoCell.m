//
//  TellStoryVideoCell.m
//  SeedGirl
//
//  Created by ParkHunter on 16/1/15.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "TellStoryVideoCell.h"
@interface TellStoryVideoCell ()
@property (nonatomic, strong) UIImageView *playView;
@end
@implementation TellStoryVideoCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self.headImageView addSubview:self.playView];
}

#pragma mark    懒加载
- (UIImageView *)playView{
    if (_playView == nil) {
        _playView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        _playView.center = self.contentView.center;
        _playView.image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"video_button_play.png"]];
    }
    
    return _playView;
}
@end
