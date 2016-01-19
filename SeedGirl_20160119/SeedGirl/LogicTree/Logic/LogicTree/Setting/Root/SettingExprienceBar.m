//
//  SettingExprienceBar.m
//  SeedGirl
//
//  Created by ParkHunter on 16/1/14.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "SettingExprienceBar.h"
#import "ResizeTool.h"
#define BG_COLOR            RGBA(181, 151, 157,0.8)
#define BAR_BG_COLOR        RGBA(244, 247, 27,0.8)
#define BAR_H               9.0f
#define BAR_MARGIN          0.0f
#define INDICATOR_W         9.0f
#define INDICATOR_H         9.0f
@interface SettingExprienceBar ()
@property (nonatomic, strong) UIView      *contentView;      //里面心部分view
@property (nonatomic, strong) UIImageView *indicator;        //指示器
@property (nonatomic, strong) UILabel     *showLabel;        //展示label
@end
@implementation SettingExprienceBar
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = BG_COLOR;
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self addViews];
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.contentView];
    [self addSubview:self.indicator];
    [self addSubview:self.showLabel];
}

#pragma mark    方法
- (void)setProgressToWidth:(CGFloat)width{
    [ResizeTool setView:self.contentView toSizeWidth:width];
    [self refreshIndicatorPosition];
}

#pragma mark    从新设置指示器位置
- (void)refreshIndicatorPosition{
    self.indicator.center = CGPointMake(MIN(self.contentView.frame.origin.x + self.contentView.frame.size.width,
                                            self.frame.size.width - self.indicator.frame.size.width / 2 + 2),
                                        self.frame.size.height / 2-(BAR_MARGIN/2));
}

#pragma mark    展示经验
- (void)setShowExperience:(NSInteger)currentExperience withUpdateExperience:(NSInteger)updateExperience{
    CGFloat width = ScreenWidth/updateExperience *currentExperience;
    [self setProgressToWidth:width];
    self.showLabel.text = [NSString stringWithFormat:@"%ld/%ld", currentExperience, updateExperience];
}

#pragma mark    -
#pragma mark    懒加载对象
- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BAR_H)];
        _contentView.backgroundColor = BAR_BG_COLOR;
    }
    return _contentView;
}

#pragma mark    指示器
- (UIImageView *)indicator
{
    if (_indicator == nil) {
        _indicator = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, INDICATOR_W, INDICATOR_H)];
        _indicator.backgroundColor = RGBA(255, 255, 255, 0.8);
        _indicator.center = CGPointMake(0, self.frame.size.height / 2-(BAR_MARGIN/2));
    }
    return _indicator;
}

- (UILabel *)showLabel{
    if (_showLabel == nil) {
        _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, BAR_H)];
        _showLabel.textColor = [UIColor whiteColor];
        _showLabel .font = [UIFont systemFontOfSize:14];
        _showLabel.numberOfLines = 1;
        _showLabel.textAlignment = NSTextAlignmentCenter;
        _showLabel.center = CGPointMake(ScreenWidth/2, BAR_H/2);
    }
    return _showLabel;
}

#pragma mark    获取实例
+ (SettingExprienceBar *)getInstance{
    SettingExprienceBar *progressBar = [[SettingExprienceBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BAR_H + BAR_MARGIN)];
    return progressBar;
}
@end
