//
//  MainTabBarView.m
//  SeedGirl
//
//  Created by Admin on 15/11/18.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "MainTabBarView.h"
#import "OwnNewMessageImage.h"

@interface MainTabBarView ()

//广场
@property (nonatomic, strong) UIButton *button_square;
//个人
@property (nonatomic, strong) UIButton *button_individual;
//个人消息提醒图片
@property (nonatomic, strong) OwnNewMessageImage *individualMessageImage;
//发布
@property (nonatomic, strong) UIButton *button_issue;
//纸条
@property (nonatomic, strong) UIButton *button_note;
//纸条消息提醒图片
@property (nonatomic, strong) OwnNewMessageImage *noteMessageImage;
//设置
@property (nonatomic, strong) UIButton *button_setting;

//按钮数组
@property (nonatomic, strong) NSArray *buttonList;
//选择
@property (nonatomic, strong) UIButton *button_selected;

@end

@implementation MainTabBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

#pragma mark - 自带
//绘制
- (void)drawRect:(CGRect)rect{
    CGContextRef context    = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.5);
    CGContextMoveToPoint(context, 0, 15);
    CGColorRef strokeColor  = RGB(235, 235, 235).CGColor;
    CGContextSetStrokeColorWithColor(context, strokeColor);
    CGColorRef fillColor    = RGB(245, 247, 248).CGColor;
    CGContextSetFillColorWithColor(context, fillColor);//填充颜色
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 15)];
    [bezierPath addArcWithCenter:CGPointMake(ScreenWidth/2, 31)
                          radius:30.5
                      startAngle:DEGREES_TO_RADIANS(211.5)
                        endAngle:DEGREES_TO_RADIANS(-31.5)
                       clockwise:YES];
    bezierPath.lineCapStyle  = kCGLineCapRound;  //线条拐角
    bezierPath.lineJoinStyle = kCGLineCapRound;
    [bezierPath addLineToPoint:CGPointMake(ScreenWidth+1, 15)];
    [bezierPath addLineToPoint:CGPointMake(ScreenWidth+1, 65)];
    [bezierPath addLineToPoint:CGPointMake(0, 65)];
    [bezierPath stroke];
    CGContextAddPath(context, bezierPath.CGPath);
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
    CGContextStrokePath(context);
}

//加载子视图
- (void)loadSubviews {
    _buttonList = [NSArray arrayWithObjects:self.button_square,self.button_individual,self.button_issue,self.button_note,self.button_setting, nil];

    [self addSubview:self.button_square];
    [self addSubview:self.button_individual];
    [self.button_individual addSubview:self.individualMessageImage];
    [self.individualMessageImage setHidden:YES];
    
    [self addSubview:self.button_issue];
    
    [self addSubview:self.button_note];
    [self.button_note addSubview:self.noteMessageImage];
    [self.noteMessageImage setHidden:YES];
    
    [self addSubview:self.button_setting];
    
    CGFloat button_width = CGRectGetWidth(self.bounds)/5;
    CGFloat button_y = MainTabBarHeight - BottomTabBarHeight;

    [self.button_square setFrame:CGRectMake(0, button_y, button_width, BottomTabBarHeight)];
    
    [self.button_individual setFrame:CGRectMake(button_width, button_y, button_width, BottomTabBarHeight)];
    [self.individualMessageImage setFrame:CGRectMake(button_width/2+11.0f, 2.5f, 6.0f, 6.0f)];
    self.individualMessageImage.layer.cornerRadius = 3.0f;
    
    [self.button_issue setFrame:CGRectMake(button_width*2, 0, button_width, MainTabBarHeight)];
    
    [self.button_note setFrame:CGRectMake(button_width*3, button_y, button_width, BottomTabBarHeight)];
    [self.noteMessageImage setFrame:CGRectMake(button_width/2+13.0f, 2.5f, 6.0f, 6.0f)];
    self.noteMessageImage.layer.cornerRadius = 3.0f;
    
    [self.button_setting setFrame:CGRectMake(button_width*4, button_y, button_width, BottomTabBarHeight)];
}

#pragma mark - Main
//设置默认索引
- (void)setDefaultSelectedIndex:(NSInteger)index {
    if (index < 0 || index >= _buttonList.count) {
        return;
    }
    
    _button_selected = [_buttonList objectAtIndex:index];
    _button_selected.selected = YES;
}
//设置选择索引
- (void)setSelectedIndex:(NSInteger)index {
    UIButton *button = [_buttonList objectAtIndex:index];
    if (button == _button_selected) {
        return ;
    }
    
    _button_selected.selected = NO;
    _button_selected = button;
    _button_selected.selected = YES;
}
//显示视频请求新消息提醒
- (void)showNewVideoRequestMessage:(BOOL)status {
    [self.individualMessageImage setHidden:!status];
}
//显示纸条新消息提醒
- (void)showNewNoteMessage:(BOOL)status {
    [self.noteMessageImage setHidden:!status];
}

#pragma mark - UIResponse Event
//按钮点击事件
- (void)buttonClick:(UIButton *)button {
    NSInteger index = [_buttonList indexOfObject:button];
    if (self.selectedBlock) {
        self.selectedBlock(index);
    }
    
//    //设置选择按钮
//    [self setSelectedIndex:index];
}

#pragma mark - lazyload
//广场
- (UIButton *)button_square {
    if (_button_square == nil) {
        _button_square = [[UIButton alloc] init];
        _button_square.backgroundColor = [UIColor clearColor];
        _button_square.contentMode = UIViewContentModeCenter;
        [_button_square setImage:[UIImage imageWithContentOfFile:@"square.png"] forState:UIControlStateNormal];
        [_button_square setImage:[UIImage imageWithContentOfFile:@"square_s.png"] forState:UIControlStateHighlighted];
        [_button_square setImage:[UIImage imageWithContentOfFile:@"square_s.png"] forState:UIControlStateSelected];
        [_button_square addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_square;
}
//个人
- (UIButton *)button_individual {
    if (_button_individual == nil) {
        _button_individual = [[UIButton alloc] init];
        _button_individual.backgroundColor = [UIColor clearColor];
        _button_individual.contentMode = UIViewContentModeCenter;
        [_button_individual setImage:[UIImage imageWithContentOfFile:@"individual.png"] forState:UIControlStateNormal];
        [_button_individual setImage:[UIImage imageWithContentOfFile:@"individual_s.png"] forState:UIControlStateHighlighted];
        [_button_individual setImage:[UIImage imageWithContentOfFile:@"individual_s.png"] forState:UIControlStateSelected];
        [_button_individual addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_individual;
}
//个人消息提醒图片
- (OwnNewMessageImage *)individualMessageImage {
    if (_individualMessageImage == nil) {
        _individualMessageImage = [[OwnNewMessageImage alloc] init];
    }
    return _individualMessageImage;
}
//发布
- (UIButton *)button_issue {
    if (_button_issue == nil) {
        _button_issue = [[UIButton alloc] init];
        _button_issue.backgroundColor = [UIColor clearColor];
        _button_issue.contentMode = UIViewContentModeCenter;
        [_button_issue setImage:[UIImage imageWithContentOfFile:@"photograph.png"] forState:UIControlStateNormal];
        [_button_issue setImage:[UIImage imageWithContentOfFile:@"photograph_s.png"] forState:UIControlStateHighlighted];
        [_button_issue setImage:[UIImage imageWithContentOfFile:@"photograph_s.png"] forState:UIControlStateSelected];
        [_button_issue addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_issue;
}
//纸条
- (UIButton *)button_note {
    if (_button_note == nil) {
        _button_note = [[UIButton alloc] init];
        _button_note.backgroundColor = [UIColor clearColor];
        _button_note.contentMode = UIViewContentModeCenter;
        [_button_note setImage:[UIImage imageWithContentOfFile:@"note.png"] forState:UIControlStateNormal];
        [_button_note setImage:[UIImage imageWithContentOfFile:@"note_s.png"] forState:UIControlStateHighlighted];
        [_button_note setImage:[UIImage imageWithContentOfFile:@"note_s.png"] forState:UIControlStateSelected];
        [_button_note addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_note;
}
//纸条消息提醒图片
- (OwnNewMessageImage *)noteMessageImage {
    if (_noteMessageImage == nil) {
        _noteMessageImage = [[OwnNewMessageImage alloc] init];
    }
    return _noteMessageImage;
}
//设置
- (UIButton *)button_setting {
    if (_button_setting == nil) {
        _button_setting = [[UIButton alloc] init];
        _button_setting.backgroundColor = [UIColor clearColor];
        _button_setting.contentMode = UIViewContentModeCenter;
        [_button_setting setImage:[UIImage imageWithContentOfFile:@"setting.png"] forState:UIControlStateNormal];
        [_button_setting setImage:[UIImage imageWithContentOfFile:@"setting_s.png"] forState:UIControlStateHighlighted];
        [_button_setting setImage:[UIImage imageWithContentOfFile:@"setting_s.png"] forState:UIControlStateSelected];
        [_button_setting addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_setting;
}

@end
