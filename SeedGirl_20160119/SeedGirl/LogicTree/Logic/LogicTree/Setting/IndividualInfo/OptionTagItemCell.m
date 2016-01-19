//
//  OptionTagItemCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "OptionTagItemCell.h"
@interface OptionTagItemCell ()
@end
@implementation OptionTagItemCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addViews];
        [self addLimits];
    }
    return self;
}

- (void)addViews{
    [self.contentView addSubview:self.tagLabel];
}

- (void)addLimits{
    WeakSelf;
    self.tagLabel.backgroundColor = [UIColor redColor];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top);
        make.left.equalTo(weakSelf.contentView.mas_left);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.right.equalTo(weakSelf.contentView.mas_right);
    }];
}

#pragma mark    懒加载对象
- (UILabel *)tagLabel{
    if (_tagLabel == nil) {
        _tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _tagLabel.backgroundColor = [UIColor purpleColor];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.textColor = [UIColor whiteColor];
        _tagLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    }
    return _tagLabel;
}

- (void)setData:(SeedTagData *)data{
    if (data.TagText.length != 0) {
        self.tagLabel.text = data.TagText;
    }
    if (data.TagTextColor.length != 0) {
        self.tagLabel.backgroundColor = data.TagColor;
    }
}
@end