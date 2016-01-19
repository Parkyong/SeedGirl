//
//  SetupMyDiamondView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupMyDiamondView.h"
#import "SetupMyDiamondLCell.h"
#import "SetupMyDiamondBCell.h"
#import "BankManager.h"
#import "BankRuleData.h"
@interface SetupMyDiamondView ()<BindBankCardProtocol, SetupMyDiamondLCellProtocol>
@property (nonatomic, strong) NSArray             *titlesArray;
@end
@implementation SetupMyDiamondView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
        self.backgroundColor = RGB(240, 242, 245);
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self addViews];
    [self addLimit];
    self.titlesArray = @[@[@"绑定银行卡", @"提现砖石数"]];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.tableView];
}

#pragma mark    添加观察者
- (void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark
- (void)removeObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark    添加约束
- (void)addLimit{
    WeakSelf;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}

#pragma mark    懒加载对象
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
        _tableView.scrollEnabled   = NO;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

#pragma mark    tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [Adaptor returnAdaptorValue:256];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [Adaptor returnAdaptorValue:46];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [Adaptor returnAdaptorValue:100];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return self.footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SetupMyDiamondBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetupMyDiamondBCell"];
        if (cell == nil) {
            cell = [[SetupMyDiamondBCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SetupMyDiamondBCell"];
        }
        cell.contentLabel.text = [[self.titlesArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.delegate          = self;
        [cell setSetupMyDiamondBCellData];
        cell.selectionStyle    = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row == 1){
        SetupMyDiamondLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetupMyDiamondLCell"];
        if (cell == nil) {
            cell = [[SetupMyDiamondLCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SetupMyDiamondLCell"];
        }
        cell.contentLabel.text = [[self.titlesArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.delegate          = self;
        cell.selectionStyle    = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (void)setupMyDiamondLCellDisPlayMoneyCount:(SetupMyDiamondLCell *)cell withMoney:(NSInteger)money{
    self.tempMoneyContainer = money;
}

#pragma mark    bindBankCard
- (void)bindBankCardAction:(SetupMyDiamondBCell *)cell withIsBindStatus:(BOOL)isBind{
    if (self.pushBlock) {
        self.pushBlock(isBind);
    }
}

#pragma mark    懒加载对象
- (SetupMyDiamondHeader *)headerView{
    if (_headerView == nil) {
        _headerView = [[SetupMyDiamondHeader alloc] init];
        _headerView.backgroundColor = RGB(240, 242, 245);
    }
    return _headerView;
}

- (SetupMyDiamondFooter *)footerView{
    if (_footerView == nil) {
        _footerView = [[SetupMyDiamondFooter alloc] init];
        _footerView.backgroundColor = RGB(240, 242, 245);
    }
    return _footerView;
}

#pragma mark   控制键盘
- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    void(^animations)() = ^{
        [self willShowKeyboardFromFrame:beginFrame toFrame:endFrame];
    };
    
    void(^completion)(BOOL) = ^(BOOL finished){
    };
    
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:animations completion:completion];
}

- (void)willShowKeyboardFromFrame:(CGRect)beginFrame toFrame:(CGRect)toFrame{
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y+(toFrame.origin.y - beginFrame.origin.y), frame.size.width, frame.size.height+(toFrame.size.height - beginFrame.size.height));
}

#pragma mark    方法
- (void)refreshData{
    [self.headerView setSetupMyDiamondHeaderData];
    [self.tableView reloadData];
}
@end