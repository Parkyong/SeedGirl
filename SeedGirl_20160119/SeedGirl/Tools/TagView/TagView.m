//
//  TagView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/29.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "TagView.h"

@interface TagView ()
@property (nonatomic, strong) UIButton               *firstTag;
@property (nonatomic, strong) UIButton              *secondTag;
@property (nonatomic, strong) UIButton               *thirdTag;
@property (nonatomic, assign) CGRect                  newFrame;
@end
@implementation TagView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
//    [self addSubview:self.firstTag];
//    [self addSubview:self.secondTag];
//    [self addSubview:self.thirdTag];
//    self.firstTag.backgroundColor  = [UIColor redColor];
//    self.secondTag.backgroundColor = [UIColor greenColor];
//    self.thirdTag.backgroundColor  = [UIColor blueColor];
    self.selectedTagsDict          = [NSMutableDictionary dictionary];
//
//    WeakSelf;
//    [self.firstTag mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.mas_left);
//        make.top.equalTo(weakSelf.mas_top);
//        make.bottom.equalTo(weakSelf.mas_bottom);
//        make.width.equalTo(weakSelf.secondTag.mas_width);
//    }];
//    [self.secondTag mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.firstTag.mas_right).with.offset(12);
//        make.top.equalTo(weakSelf.mas_top);
//        make.bottom.equalTo(weakSelf.mas_bottom);
//        make.width.equalTo(weakSelf.thirdTag.mas_width);
//    }];
//    [self.thirdTag mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.secondTag.mas_right).with.offset(12);
//        make.right.equalTo(weakSelf.mas_right);
//        make.top.equalTo(weakSelf.mas_top);
//        make.bottom.equalTo(weakSelf.mas_bottom);
//        make.width.equalTo(weakSelf.firstTag.mas_width);
//    }];
//    CGFloat commonWidth  = self.newFrame.size.width/3;
//    CGFloat commonHeigth = self.newFrame.size.height;
//    self.firstTag.frame  = CGRectMake(0, 0, commonWidth, commonHeigth);
//    self.secondTag.frame = CGRectMake(CGRectGetMaxX(self.firstTag.frame), 0, commonWidth, commonHeigth);
//    self.thirdTag.frame  = CGRectMake(CGRectGetMaxX(self.secondTag.frame), 0, commonWidth, commonHeigth);
}

//#pragma mark    懒加载对象
//- (UIButton *)firstTag{
//    if (_firstTag == nil) {
//        _firstTag = [[UIButton alloc] init];
//        _firstTag.hidden = YES;
//        _firstTag.titleLabel.textAlignment = NSTextAlignmentLeft;
//        [_firstTag addTarget:self action:@selector(selectTagAction:)
//            forControlEvents:UIControlEventTouchUpInside];
//        _firstTag.tag   = 1;
//    }
//    return _firstTag;
//}
//
//- (UIButton *)secondTag{
//    if (_secondTag == nil) {
//        _secondTag = [[UIButton alloc] init];
//        _secondTag.hidden = YES;
//        _secondTag.titleLabel.textAlignment = NSTextAlignmentLeft;
//        [_secondTag addTarget:self action:@selector(selectTagAction:)
//             forControlEvents:UIControlEventTouchUpInside];
//        _secondTag.tag   = 2;
//    }
//    return _secondTag;
//}
//
//- (UIButton *)thirdTag{
//    if (_thirdTag == nil) {
//        _thirdTag = [[UIButton alloc] init];
//        _thirdTag.hidden = YES;
//        _thirdTag.titleLabel.textAlignment = NSTextAlignmentLeft;
//        [_thirdTag addTarget:self action:@selector(selectTagAction:)
//            forControlEvents:UIControlEventTouchUpInside];
//        _thirdTag.tag   = 3;
//    }
//    return _thirdTag;
//}

#pragma mark    行为
- (void)selectTagAction:(UIButton *)sender{
    [sender removeFromSuperview];
    NSArray *keyArray = [self.selectedTagsDict allKeys];
    if ([keyArray containsObject:[NSString stringWithFormat:@"%ld", sender.tag]]) {
        [self.selectedTagsDict removeObjectForKey:[NSString stringWithFormat:@"%ld", sender.tag]];
    }
    if (self.removeTagBlock != nil) {
        self.removeTagBlock(sender.tag);
    }
}

//fix yanse
- (void)addTagsAction:(NSString *)tagTitle{
    NSArray *keyArray = [self.selectedTagsDict allKeys];
    if (keyArray.count == 0) {
        [self addTagButton:1 withTitle:tagTitle];
        [self.selectedTagsDict setValue:tagTitle forKey:@"1"];
    }else{
        if (![keyArray containsObject:@"1"]) {
            [self addTagButton:1 withTitle:tagTitle];
            [self.selectedTagsDict setValue:tagTitle forKey:@"1"];
            
        }else if(![keyArray containsObject:@"2"]){
            [self addTagButton:2 withTitle:tagTitle];
            [self.selectedTagsDict setValue:tagTitle forKey:@"2"];
            
        }else if(![keyArray containsObject:@"3"]){
            [self addTagButton:3 withTitle:tagTitle];
            [self.selectedTagsDict setValue:tagTitle forKey:@"3"];
        }
    }
}

//添加Button
- (UIButton *)addTagButton:(NSInteger )index withTitle:(NSString *)title{
    CGFloat width  = self.frame.size.width/3;
    CGFloat heigth = self.frame.size.height;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(width*(index-1), 0, width, heigth)];
    [button addTarget:self action:@selector(selectTagAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    button.tag = index;
    [self addSubview:button];
    return button;
}
@end