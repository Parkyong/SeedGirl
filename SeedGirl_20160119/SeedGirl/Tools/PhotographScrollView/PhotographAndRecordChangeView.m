//
//  PhotographAndRecordChangeView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/10.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "PhotographAndRecordChangeView.h"
@interface PhotographAndRecordChangeView ()
@property (nonatomic, strong) UIImageView   *pointImageView;
@property (nonatomic, strong) UIScrollView  *mainScrollView;
@property (nonatomic, strong) UIButton    *photographButton;
@property (nonatomic, strong) UIButton        *recordButton;
@end
@implementation PhotographAndRecordChangeView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    self.currentArea = PhotographArea;
    [self addViews];
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.pointImageView];
    [self addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.photographButton];
    [self.mainScrollView addSubview:self.recordButton];
}

#pragma mark    -
#pragma mark    懒加载对象
- (UIImageView *)pointImageView{
    if (_pointImageView == nil) {
        _pointImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-5)/2, 0, 5, 5)];
        _pointImageView.image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath]
                                                                   stringByAppendingPathComponent:@"point.png"]];
        _pointImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _pointImageView;
}

- (UIScrollView *)mainScrollView{
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pointImageView.frame)+[Adaptor returnAdaptorValue:6], self.frame.size.width, self.frame.size.height-CGRectGetHeight(self.pointImageView.frame)-[Adaptor returnAdaptorValue:6])];
        _mainScrollView.contentSize = CGSizeMake(self.frame.size.width, 0);
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator   = NO;
        _mainScrollView.bounces                        = NO;
        _mainScrollView.userInteractionEnabled         = YES;
    }
    return _mainScrollView;
}

- (UIButton *)photographButton{
    if (_photographButton == nil) {
        _photographButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/3,
                                                                       0,
                                                                       self.frame.size.width/3,
                                                                       CGRectGetHeight(self.mainScrollView.frame))];
        [_photographButton setTitle:@"照相" forState:UIControlStateNormal];
        _photographButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        [_photographButton setTitleColor:RGB(239, 28, 136) forState:UIControlStateSelected];
        [_photographButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        _photographButton.userInteractionEnabled = YES;
        _photographButton.selected = YES;
        _photographButton.tag   = 1;
        [_photographButton addTarget:self action:@selector(scrollAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photographButton;
}

- (UIButton *)recordButton{
    if (_recordButton == nil) {
        _recordButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/3*2,
                                                                   0,
                                                                   self.frame.size.width/3,
                                                                   CGRectGetHeight(self.mainScrollView.frame))];
        [_recordButton setTitle:@"摄像" forState:UIControlStateNormal];
        _recordButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        [_recordButton setTitleColor:RGB(239, 28, 136) forState:UIControlStateSelected];
        [_recordButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        _recordButton.userInteractionEnabled = YES;
        _recordButton.tag   = 2;
        [_recordButton addTarget:self action:@selector(scrollAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _recordButton;
}

#pragma mark     代理方法
- (void)scrollAction:(UIButton *)sender{
//    CGPoint point = self.mainScrollView.contentOffset;
    switch (sender.tag) {
        case 1:
        {
            [UIView animateWithDuration:0.5 animations:^{
//                self.mainScrollView.contentOffset = CGPointMake(0, point.y);
                self.photographButton.frame = CGRectMake(self.frame.size.width/3,
                                                         0,
                                                         self.frame.size.width/3,
                                                         CGRectGetHeight(self.mainScrollView.frame));
                self.recordButton.frame = CGRectMake(self.frame.size.width/3*2,
                                                     0,
                                                     self.frame.size.width/3,
                                                     CGRectGetHeight(self.mainScrollView.frame));
                
                self.photographButton.selected    = YES;
                self.recordButton.selected        = NO;
                self.currentArea                  = PhotographArea;
            }];
            break;
        }
        case 2:
        {
            [UIView animateWithDuration:0.5 animations:^{
//                self.mainScrollView.contentOffset = CGPointMake(self.frame.size.width/3, point.y);
                self.photographButton.frame = CGRectMake(0,
                                                         0,
                                                         self.frame.size.width/3,
                                                         CGRectGetHeight(self.mainScrollView.frame));
                self.recordButton.frame = CGRectMake(self.frame.size.width/3,
                                                     0,
                                                     self.frame.size.width/3,
                                                     CGRectGetHeight(self.mainScrollView.frame));
                self.photographButton.selected    = NO;
                self.recordButton.selected        = YES;
                self.currentArea                  = RecordArea;
            }];
            break;
        }
    }
    if (self.changeBlock != nil) {
        self.changeBlock(sender.tag);
    }
}

#pragma mark    切换摄像与拍照
- (void)outControlChangeCameraAreaAction:(AreaType)areType{
    if (areType == PhotographArea) {
        [self scrollAction:self.photographButton];
    }else if(areType == RecordArea){
        [self scrollAction:self.recordButton];
    }
}

#pragma mark    只显示照相
- (void)hideRecordButton{
    [self.recordButton removeFromSuperview];
    self.photographButton.selected    = YES;
    self.currentArea                  = PhotographArea;
    self.photographButton.frame       = CGRectMake(self.frame.size.width/3,
                                                   0,
                                                   self.frame.size.width/3,
                                                   CGRectGetHeight(self.mainScrollView.frame));
    self.mainScrollView.scrollEnabled = NO;
    if (self.changeBlock != nil) {
        self.changeBlock(PhotographArea);
    }
}

#pragma mark    只显示摄像
- (void)hideCameraButton{
    [self.photographButton removeFromSuperview];
    self.recordButton.selected        = YES;
    self.currentArea                  = RecordArea;
    self.recordButton.frame           = CGRectMake(self.frame.size.width/3,
               0,
               self.frame.size.width/3,
               CGRectGetHeight(self.mainScrollView.frame));
    self.mainScrollView.scrollEnabled = NO;
    if (self.changeBlock != nil) {
        self.changeBlock(RecordArea);
    }
}
@end
