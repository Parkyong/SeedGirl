//
//  HeaderView.m
//  SeedGirl
//
//  Created by ParkHunter on 16/1/14.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "HeaderView.h"
#define MARGIN  [Adaptor returnAdaptorValue:7]
@interface HeaderView ()
@property (nonatomic, strong) UIView *markView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView  *seperator;
@end
@implementation HeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    [self addViews];
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.markView];
    [self addSubview:self.label];
    [self addSubview:self.seperator];
}

- (UIView *)markView{
    if (_markView == nil) {
        _markView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                             3, self.frame.size.height)];
        _markView.backgroundColor = RGB(233, 115, 137);
    }
    return _markView;
}

- (UILabel *)label{
    if (_label == nil) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.markView.frame)+MARGIN,
                                                           0,
                                                           SCREEN_WIDTH - CGRectGetWidth(self.markView.frame)-MARGIN,
                                                           self.frame.size.height)];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.font = [UIFont systemFontOfSize:18];
        _label.textColor = [UIColor blackColor];
    }
    return _label;
}

- (UIView *)seperator{
    if (_seperator == nil) {
        _seperator = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame)-1, CGRectGetWidth(self.frame), 1)];
        _seperator.backgroundColor = RGB(244, 244, 244);
    }
    return _seperator;
}

- (void)setTitle:(NSString *)title{
    self.label.text = title;
}
@end
