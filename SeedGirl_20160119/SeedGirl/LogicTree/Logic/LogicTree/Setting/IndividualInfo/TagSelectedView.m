//
//  TagSelectedView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "TagSelectedView.h"
#import "OptionTagCell.h"
#import "SeedTagData.h"
#import "SelectedTagCell.h"
@interface TagSelectedView ()<UITableViewDataSource, UITableViewDelegate, OptionTagCellProtocol, SelectedTagCellProtocol>
@end
@implementation TagSelectedView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setParameter];
        [self addViews];
        [self addLimits];
    }
    return self;
}

- (void)addViews{
    [self addSubview:self.tableView];
}

- (void)addLimits{
    WeakSelf;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.right.equalTo(weakSelf.mas_right);
    }];
}

- (void)setParameter{
    self.dataSource = [NSMutableArray array];
    self.selectData = [NSMutableArray array];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[OptionTagCell class] forCellReuseIdentifier:@"OptionTagCell"];
    [self.tableView registerClass:[SelectedTagCell class] forCellReuseIdentifier:@"SelectedTagCell"];
}

#pragma mark    代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataSource.count;
    }else{
        if (self.selectData.count != 0) {
            return 1;
        }else{
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        OptionTagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionTagCell"];
        NSArray * array = [self.dataSource objectAtIndex:indexPath.row];
        [cell setDataWithCell:cell withData:array];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate  = self;
        return cell;
    }else{
        SelectedTagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectedTagCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell setSelectedTagCellData:self.selectData];
        return cell;
    }
    return nil;
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectData.count == 3) {
        return;
    }
    SeedTagData *data = [[self.dataSource objectAtIndex:0] objectAtIndex:indexPath.row];
    [self.selectData addObject:data];

    [[self.dataSource objectAtIndex:0] removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

- (void)removeSelectItem:(NSInteger)index{
    [[self.dataSource objectAtIndex:0] addObject:[self.selectData objectAtIndex:index]];
    [self.selectData removeObjectAtIndex:index];
    [self.tableView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *sectionView = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 20)];
        label.text = @"可选标签";
        [sectionView addSubview:label];
        return sectionView;
    }else{
        UIView *sectionView = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 20)];
        label.text = @"已选标签";
        [sectionView addSubview:label];
        return sectionView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        OptionTagCell *cell = (OptionTagCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return [cell getHeigth];
    }else{
        CGFloat width  = (ScreenWidth-7*5)/6;
        CGFloat height = width/5.0*2;
        return height+5;
    }
}

#pragma mark    设置数据
- (void)setUpDataOfCell:(id)cell atIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = [self.dataSource objectAtIndex:indexPath.row];
    [cell setDataWithCell:cell withData:array];
}

#pragma mark    懒加载对象
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)
                                                  style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        _tableView.bounces                        = NO;
        _tableView.backgroundColor                = [UIColor whiteColor];
    }
    return _tableView;
}
@end