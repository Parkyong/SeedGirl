//
//  SetupView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/22.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupView.h"
#import "SettingPersonalInfoCell.h"
#import "SettingInfoCell.h"
#import "SettingSignUpCell.h"

@interface SetupView () <SettingPersonalInfoProtocol>
@property (nonatomic, strong) NSArray    *titleArray;
@property (nonatomic, strong) NSArray    *imageArray;
@property (nonatomic, strong) UIView     *footerView;
@property (nonatomic, strong) UIButton *logoutButton;
@end
@implementation SetupView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self setParameter];
    [self addViews];
    [self addLimit];
    [self footerRefresh];
}

#pragma mark    设置参数
- (void)setParameter{
    self.titleArray = [NSArray arrayWithObjects:@[],
                       @[@"每日签到", @"查看粉丝", @"我的钻石"],
                       @[@"消息设置", @"经验等级说明", @"意见反馈"],nil];
    self.imageArray = [NSArray arrayWithObjects:@[],
                       @[@"sign.png", @"lookFuns.png", @"myDiamond.png"],
                       @[@"messageSetting.png",@"exp_lvl.png", @"feedBack.png"], nil];
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.tableView];
    self.tableView.tableFooterView = self.footerView;
}

#pragma mark    添加约束
- (void)addLimit{
    WeakSelf;
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.mas_top);
//        make.left.equalTo(weakSelf.mas_left);
//        make.bottom.equalTo(weakSelf.mas_bottom);
//        make.right.equalTo(weakSelf.mas_right);
//    }];
}

#pragma mark    tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 3;
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SettingPersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingPersonalInfoCell"];
        if (cell == nil) {
            cell = [[SettingPersonalInfoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:@"SettingPersonalInfoCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSettingPersonalInfoCellData];
        cell.delegate = self;
        return cell;
    }else{
        if (indexPath.section == 1 && indexPath.row == 0) {
            SettingSignUpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingSignUpCell"];
            if (cell == nil) {
                cell = [[SettingSignUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingSignUpCell"];
            }
            cell.contentLabel.text = [[self.titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            NSString *imagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[[self.imageArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
            cell.symbolImageView.image = [[UIImage alloc] initWithContentsOfFile:imagePath];
            cell.isSignUp = [[UserManager manager] isSign];
            return  cell;
        }else{
            SettingInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingInfoCell"];
            if (cell == nil) {
                cell = [[SettingInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingInfoCell"];
            }
            cell.contentLabel.text = [[self.titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            NSString *imagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[[self.imageArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
            cell.symbolImageView.image = [[UIImage alloc] initWithContentsOfFile:imagePath];
            cell.entranceImageView.image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"settingEntrance.png"]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [Adaptor returnAdaptorValue:127];
    }else{
        return [Adaptor returnAdaptorValue:49];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if(section == 1){
        return 1;
    }else{
        return 13;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 2) {
//        return  [Adaptor returnAdaptorValue:100];
//    }else{
//        return 0;
//    }
//}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section == 2) {
//        return self.footerView;
//    }else{
//        return nil;
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.changePageBlock == nil) {
        return;
    }
    
    if (indexPath.section == 0) {
        self.changePageBlock(PERSONALINFOPAGE);
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            self.changePageBlock(MESSAGESETTING);
        }else if(indexPath.row == 1){
            self.changePageBlock(EXPERIENCEREFERENCEPAGE);
        }else{
            self.changePageBlock(FEEDBACKPAGE);
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            self.changePageBlock(SINGUPPAGE);
        }else if (indexPath.row == 1) {
            self.changePageBlock(LOOKFUNSPAGE);
        }else if(indexPath.row == 2){
            self.changePageBlock(MYDIAMONDPAGE);
        }
    }
}

- (void)changeToPersonalInfoPage:(SettingPersonalInfoCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if ([self respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark    懒加载对象
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   HeigthForNavigationBar,
                                                                   SCREEN_WIDTH,
                                                                   SCREEN_HEIGHT-MainTabBarHeight-HeigthForNavigationBar) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator   = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        _tableView.scrollEnabled  = NO;
        _tableView.backgroundColor = RGB(240, 242, 245);
    }
    return _tableView;
}

- (UIView *)footerView{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [Adaptor returnAdaptorValue:80])];
        _footerView.backgroundColor = RGB(240, 242, 245);
        [_footerView addSubview:self.logoutButton];
    }
    return _footerView;
}

- (UIButton *)logoutButton{
    if (_logoutButton == nil) {
        _logoutButton = [[UIButton alloc] init];
        _logoutButton.frame = CGRectMake(0, 0, [Adaptor returnAdaptorValue:256], [Adaptor returnAdaptorValue:31]);
        _logoutButton.center = CGPointMake(self.footerView.frame.size.width/2, self.footerView.frame.size.height/2);
        _logoutButton.backgroundColor = RGB(255, 90, 81);
        _logoutButton.layer.cornerRadius = 3;
        _logoutButton.tag = 500;
        _logoutButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        [_logoutButton setTitle:@"登录" forState:UIControlStateNormal];
        [_logoutButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        [_logoutButton addTarget:self action:@selector(loginAndLogoutAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}

- (void)footerRefresh{
    if ([[UserManager manager] isLogined]) {
        [self.logoutButton setTitle:@"退出" forState:UIControlStateNormal];
        self.logoutButton.tag = 400;
    }else{
        [self.logoutButton setTitle:@"登录" forState:UIControlStateNormal];
        self.logoutButton.tag = 500;
    }
}

- (void)loginAndLogoutAction:(UIButton *)sender{
    if (sender.tag == 500) {
        if (self.changePageBlock != nil) {
            self.changePageBlock(LOGINANDLOGOUTPAGE);
        }
    }else{
        [self logoutAction];
        if (self.logoutBlock) {
            self.logoutBlock();
        }
    }
}

#pragma mark    推出操作
- (void)logoutAction{
    [[UserManager manager] cleanUserLoginInfo];
    [self.tableView reloadData];
    [self footerRefresh];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogout object:nil];
}
@end