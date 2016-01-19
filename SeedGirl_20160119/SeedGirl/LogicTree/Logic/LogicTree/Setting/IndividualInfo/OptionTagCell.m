//
//  OptionTagCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "OptionTagCell.h"
#import "OptionTagItemCell.h"
#import "SeedTagData.h"

@interface OptionTagCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *tagCollectionView;
@property (nonatomic, strong) NSMutableArray    *tagDataContainer;
@property (nonatomic, assign) CGFloat                      height;
@end
@implementation OptionTagCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setParameter];
        [self addViews];
        [self addLimits];
    }
    return self;
}

#pragma mark    添加试图
- (void)addViews{
    [self.contentView addSubview:self.tagCollectionView];
}

#pragma mark    添加约束
- (void)addLimits{
    WeakSelf;
    [self.tagCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top);
        make.left.equalTo(weakSelf.contentView.mas_left);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.right.equalTo(weakSelf.contentView.mas_right);
    }];
}

#pragma mark    设置参数
- (void)setParameter{
    self.tagDataContainer = [NSMutableArray array];
    self.height                       = 0;
    self.tagCollectionView.delegate   = self;
    self.tagCollectionView.dataSource = self;
    [self.tagCollectionView registerClass:[OptionTagItemCell class] forCellWithReuseIdentifier:@"OptionTagItemCell"];
}

- (void)setDataWithCell:(OptionTagCell *)cell withData:(NSArray *)data{
    if (data == nil || data.count == 0) {
        return;
    }
    [self.tagDataContainer removeAllObjects];
    [self.tagDataContainer addObjectsFromArray:data];
    [self.tagCollectionView reloadData];
}

#pragma mark    代理
#pragma mark    collection Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.tagDataContainer.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width  = (ScreenWidth-7*5)/6;
    CGFloat height = width/5.0*2;
    return CGSizeMake(width, height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"OptionTagItemCell";
    OptionTagItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    [cell setData:[self.tagDataContainer objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:)]) {
        [self.delegate didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark    collectionView
- (UICollectionView *)tagCollectionView{
    if (_tagCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _tagCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _tagCollectionView.backgroundColor = [UIColor clearColor];
    }
    return _tagCollectionView;
}

- (CGFloat)getHeigth{
    CGFloat width  = (ScreenWidth-7*5)/6;
    CGFloat height = width/5.0*2;
    if (self.tagDataContainer.count % 6 == 0) {
        self.height = (self.tagDataContainer.count/6 *height) + (self.tagDataContainer.count/6-1)*5 + 2*5;
    }else{
        self.height = ((self.tagDataContainer.count/6+1)*height) + (self.tagDataContainer.count/6)*5+2*5;
    }
    return  self.height;
}
@end
