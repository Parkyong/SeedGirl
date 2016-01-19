//
//  SelectedTagCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "SelectedTagCell.h"
@interface SelectedTagCell ()
@property (nonatomic, strong) UIView         *container;
@property (nonatomic, strong) UILabel       *firstLabel;
@property (nonatomic, strong) UILabel      *secondLabel;
@property (nonatomic, strong) UILabel       *thirdLabel;
@property (nonatomic, strong) NSMutableArray *cellDataArray;
@end
@implementation SelectedTagCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
        [self addLimits];
    }
    return self;
}

#pragma mark    添加试图
- (void)addViews{
    self.cellDataArray = [NSMutableArray array];
    [self.contentView addSubview:self.container];
    [self.container addSubview:self.firstLabel];
    [self.container addSubview:self.secondLabel];
    [self.container addSubview:self.thirdLabel];
    self.container.backgroundColor = [UIColor clearColor];
}

#pragma mark    添加限制
- (void)addLimits{
    CGFloat width  = (ScreenWidth-7*5)/6;
    CGFloat height = width/5.0*2;
    self.container.frame = CGRectMake(10, 5, width*3+5*2, height);
}

- (UIView *)container{
    if (_container == nil) {
        _container = [[UIView alloc] init];
        _container.userInteractionEnabled = YES;
    }
    return _container;
}

- (UILabel *)firstLabel{
    if (_firstLabel == nil) {
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.tag = 1;
        _firstLabel.hidden = YES;
        _firstLabel.userInteractionEnabled = YES;
        _firstLabel.textColor = [UIColor whiteColor];
        _firstLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _firstLabel.textAlignment = NSTextAlignmentCenter;
        [_firstLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    }
    return _firstLabel;
}

- (UILabel *)secondLabel{
    if (_secondLabel == nil) {
        _secondLabel = [[UILabel alloc] init];
        _secondLabel.tag = 2;
        _secondLabel.hidden = YES;
        _secondLabel.userInteractionEnabled = YES;
        _secondLabel.textColor = [UIColor whiteColor];
        _secondLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        [_secondLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    }
    return _secondLabel;
}

- (UILabel *)thirdLabel{
    if (_thirdLabel == nil) {
        _thirdLabel = [[UILabel alloc] init];
        _thirdLabel.tag = 3;
        _thirdLabel.hidden = YES;
        _thirdLabel.userInteractionEnabled = YES;
        _thirdLabel.textColor = [UIColor whiteColor];
        _thirdLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _thirdLabel.textAlignment = NSTextAlignmentCenter;
        [_thirdLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    }
    return _thirdLabel;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(removeSelectItem:)] ) {
        UILabel *label = (UILabel *)[tapGR view];
        NSLog(@"%ld",label.tag);
        [self.cellDataArray removeObjectAtIndex:label.tag-1];
        [self setSelectedTagCellData:self.cellDataArray];
        [self.delegate removeSelectItem:label.tag-1];
    }
}

- (void)setSelectedTagCellData:(NSMutableArray *)dataArray{
    [self.firstLabel removeFromSuperview];
    [self.secondLabel removeFromSuperview];
    [self.thirdLabel removeFromSuperview];
    NSMutableArray *temArray = [NSMutableArray arrayWithArray:dataArray];
    if (temArray.count == 0) {
        return;
    }
    [self.cellDataArray removeAllObjects];
    [self.cellDataArray addObjectsFromArray:temArray];
    CGFloat width  = (ScreenWidth-7*5)/6;
    CGFloat height = width/5.0*2;

    switch (dataArray.count) {
        case 1:
        {
            SeedTagData *data = [dataArray objectAtIndex:0];
            self.firstLabel.text = data.TagText;
            self.firstLabel.backgroundColor = data.TagColor;
            self.firstLabel.frame = CGRectMake(0, 0, width, height);
            [self.container addSubview:self.firstLabel];
            [UIView animateWithDuration:0.5 animations:^{
                self.firstLabel.hidden = NO;
            }];
            break;
        }
        case 2:
        {
            SeedTagData *data = [dataArray objectAtIndex:0];
            self.firstLabel.text = data.TagText;
            self.firstLabel.backgroundColor = data.TagColor;
            self.firstLabel.frame = CGRectMake(0, 0, width, height);
            [self.container addSubview:self.firstLabel];
            [UIView animateWithDuration:0.5 animations:^{
                self.firstLabel.hidden = NO;
            }];
            
            SeedTagData *data1 = [dataArray objectAtIndex:1];
            self.secondLabel.text = data1.TagText;
            self.secondLabel.backgroundColor = data1.TagColor;
            self.secondLabel.frame = CGRectMake(CGRectGetMaxX(self.firstLabel.frame)+5, 0, width, height);
            [self.container addSubview:self.secondLabel];
            [UIView animateWithDuration:0.5 animations:^{
                self.secondLabel.hidden = NO;
            }];
            break;
        }
        case 3:
        {
            SeedTagData *data = [dataArray objectAtIndex:0];
            self.firstLabel.text = data.TagText;
            self.firstLabel.backgroundColor = data.TagColor;
            self.firstLabel.frame = CGRectMake(0, 0, width, height);
            [self.container addSubview:self.firstLabel];
            [UIView animateWithDuration:0.5 animations:^{
                self.firstLabel.hidden = NO;
            }];
            
            SeedTagData *data1 = [dataArray objectAtIndex:1];
            self.secondLabel.text = data1.TagText;
            self.secondLabel.backgroundColor = data1.TagColor;
            self.secondLabel.frame = CGRectMake(CGRectGetMaxX(self.firstLabel.frame)+5, 0, width, height);
            [self.container addSubview:self.secondLabel];
            [UIView animateWithDuration:0.5 animations:^{
                self.secondLabel.hidden = NO;
            }];
            
            SeedTagData *data2 = [dataArray objectAtIndex:2];
            self.thirdLabel.text = data2.TagText;
            self.thirdLabel.backgroundColor = data2.TagColor;
            self.thirdLabel.frame = CGRectMake(CGRectGetMaxX(self.secondLabel.frame)+5, 0, width, height);
            [self.container addSubview:self.thirdLabel];
            [UIView animateWithDuration:0.5 animations:^{
                self.thirdLabel.hidden = NO;
            }];
            break;
        }
        default:
            break;
    }
}
@end
