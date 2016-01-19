//
//  SetupMessageSettingView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupMessageSettingView.h"
#import "SetupMSCell.h"
#import "UserManager.h"
#import "UserData.h"
@interface SetupMessageSettingView ()<SetupMessageSettingProtocol>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray   *titlesArray;
@end
@implementation SetupMessageSettingView
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
    self.titlesArray = @[@[@"纸条"], @[@"视频请求"]];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.tableView];
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
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled   = NO;
        _tableView.backgroundColor = RGB(240, 242, 245);
    }
    return _tableView;
}

#pragma mark    tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 8.5;
    }else{
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [Adaptor returnAdaptorValue:46];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SetupMSCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetupMSCell"];
    if (cell == nil) {
        cell = [[SetupMSCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SetupMSCell"];
    }
    cell.delegate = self;
    cell.contentLabel.text = [[self.titlesArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section == 0) {
        cell.settingSwitch.on = [[UserManager manager] note_status];
    }else{
        cell.settingSwitch.on = [[UserManager manager] videoRequest_status];
    }
    cell.selectionStyle    = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark    cell的代理方法
- (void)changeMessageSettingWithSetupMSCell:(SetupMSCell *)cell withSwitch:(BOOL)on{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameters setValue:[[UserManager manager] userID] forKey:@"user_id"];
    BOOL flag = NO;
    if (indexPath.section == 0) {
        if (on) {
            [parameters setValue:[NSNumber numberWithInt:1] forKey:@"note_status"];
            flag = YES;
        }else{
            [parameters setValue:[NSNumber numberWithInt:0] forKey:@"note_status"];
            flag = NO;
        }
        [parameters setValue:[NSNumber numberWithInteger:[[UserManager manager] videoRequest_status]]  forKey:@"videoRequest_status"];
        [self setMsgConfigWithParameter:parameters withResultBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                [UserManager manager].note_status = flag;
                EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
                if ([[UserManager manager] note_status]) {
                    options.noDisturbStatus = ePushNotificationNoDisturbStatusClose;
                }else{
                    options.noDisturbStatus = ePushNotificationNoDisturbStatusDay;
                }
                [[EaseMob sharedInstance].chatManager updatePushOptions:options error:nil];
            }
        }];
        
    }else{
        if (on) {
            [parameters setValue:[NSNumber numberWithInt:1] forKey:@"videoRequest_status"];
            flag = YES;
        }else{
            [parameters setValue:[NSNumber numberWithInt:0] forKey:@"videoRequest_status"];
            flag = NO;
        }
        [parameters setValue:[NSNumber numberWithInteger:[[UserManager manager] note_status]]  forKey:@"note_status"];
        [self setMsgConfigWithParameter:parameters withResultBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                [UserManager manager].videoRequest_status = flag;
            }
        }];
    }
}

- (void)setMsgConfigWithParameter:(NSDictionary *)parameter withResultBlock:(void (^)(BOOL isSuccess))result{
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_msg_config"] parameters:parameter success:^(id responseObject) {
        APPLog(@"%@", responseObject);
        if (publishProtocol(responseObject) == 0) {
            APPLog(@"设置成功");
            result(YES);
        }else{
            APPLog(@"设置失败");
            result(NO);
        }
    } failure:^(NSError *error) {
        APPLog(@"%@", error);
    }];
}

@end