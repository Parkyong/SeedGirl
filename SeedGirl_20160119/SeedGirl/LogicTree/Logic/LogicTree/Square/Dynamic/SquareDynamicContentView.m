//
//  SquareDynamicContentView.m
//  SeedGirl
//
//  Created by Admin on 16/1/6.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "SquareDynamicContentView.h"
#import "SquareDynamicPicView.h"

@interface SquareDynamicContentView ()
//文本
@property (nonatomic, strong) UILabel *wordLabel;
//图片
@property (nonatomic, strong) SquareDynamicPicView *dynamicPicView;
//约束
@property (nonatomic, strong) MASConstraint *picTopConstraint;
@end

@implementation SquareDynamicContentView

- (instancetype)init {
    if (self = [super init]) {
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

//加载子视图
- (void)loadSubviews {
    //文本
    [self addSubview:self.wordLabel];
    //图片
    [self addSubview:self.dynamicPicView];
    
    [self addConstraints];
}
//添加约束
- (void)addConstraints {
    WeakSelf;
    //文本
    [self.wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(20.0f);
        make.right.equalTo(weakSelf).with.offset(-20.0f);
    }];
    //图片
    [self.dynamicPicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.wordLabel.mas_bottom).with.offset(16.0f).priority(UILayoutPriorityDefaultLow);
        self.picTopConstraint = make.top.equalTo(weakSelf).priority(UILayoutPriorityDefaultHigh);
        make.left.equalTo(weakSelf).with.offset(20.0f);
        make.right.equalTo(weakSelf).with.offset(-20.0f);
        make.bottom.equalTo(weakSelf).with.offset(-16.0f);
    }];
}

#pragma mark - Main
//设置记录文本
- (void)setRecordText:(NSString*)text {
    [self.picTopConstraint deactivate];
    if (text != nil && ![text isEqualToString:@""]) {
        [_wordLabel setText:text];
    } else {
        [_wordLabel setText:nil];
        [self.picTopConstraint activate];
    }
}
//设置记录展示图片和视频图片
- (void)setRecordPicList:(NSMutableArray *)pic video:(NSString *)video {
    //子对象宽度
    CGFloat minItemWidth = 0.0f;
    //底部间距
    CGFloat bottomSpacing = -16.0f;
    if (pic != nil && pic.count > 0) {
        //子对象行间距
        CGFloat minLineSpacing = 4.0f;
        if (pic.count >= 4) {
            minLineSpacing = 4.0f;
            minItemWidth = (ScreenWidth - 40.0f - minLineSpacing*3)/4;
        } else if (pic.count >= 2) {
            minLineSpacing = 5.0f;
            minItemWidth = (ScreenWidth - 40.0f - minLineSpacing*2)/3;
        } else {
            minLineSpacing = 0;
            minItemWidth = ScreenWidth/2 - 40.0f;
        }

        //设置基本属性
        minItemWidth = ceilf(minItemWidth);
        [self.dynamicPicView setMinLineSpacing:minLineSpacing minItemSize:CGSizeMake(minItemWidth, minItemWidth)];
        //设置图片数据
        [self.dynamicPicView setShowPicList:pic];
    } else if (video != nil && ![video isEqualToString:@""]) {
        //设置基本属性
        minItemWidth = ScreenWidth/2 - 40.0f;
        [self.dynamicPicView setMinLineSpacing:0 minItemSize:CGSizeMake(minItemWidth, minItemWidth)];
        //设置视频数据
        NSMutableArray *videoList = [NSMutableArray arrayWithObjects:video, nil];
        [self.dynamicPicView setShowVideoList:videoList];
    } else {
        //设置基本属性
        minItemWidth = 0;
        [self.dynamicPicView setMinLineSpacing:0 minItemSize:CGSizeZero];
        //设置图片数据
        [self.dynamicPicView setShowPicList:nil];
        
        bottomSpacing = 0;
    }
    WeakSelf;
    [self.dynamicPicView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(minItemWidth);
        make.bottom.equalTo(weakSelf).with.offset(bottomSpacing);
    }];
}

#pragma mark - lazyload
//内容
- (UILabel *)wordLabel {
    if (_wordLabel == nil) {
        _wordLabel = [[UILabel alloc] init];
        _wordLabel.backgroundColor = [UIColor clearColor];
        _wordLabel.textAlignment = NSTextAlignmentLeft;
        _wordLabel.textColor = RGBA(51, 51, 51, 0.9);
        _wordLabel.font = [UIFont systemFontOfSize:16.0f];
        _wordLabel.numberOfLines = 2;
        _wordLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _wordLabel.preferredMaxLayoutWidth = ScreenWidth-40.0f;
    }
    return _wordLabel;
}
//图片
- (SquareDynamicPicView *)dynamicPicView {
    if (_dynamicPicView == nil) {
        _dynamicPicView = [[SquareDynamicPicView alloc] init];
        _dynamicPicView.backgroundColor = [UIColor clearColor];
        _dynamicPicView.userInteractionEnabled = NO;
    }
    return _dynamicPicView;
}

@end
