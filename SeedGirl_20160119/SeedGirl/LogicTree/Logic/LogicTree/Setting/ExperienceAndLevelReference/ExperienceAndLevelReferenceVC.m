//
//  EeperienceAndLevelReferenceVC.m
//  SeedGirl
//
//  Created by ParkHunter on 16/1/14.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "ExperienceAndLevelReferenceVC.h"
#import "ExperienceAndLevelReferenceView.h"
#import "LevelCell.h"
#import "ExperienceCell.h"

#define LevelTableView           100
#define ExperienceTableView      200
@interface ExperienceAndLevelReferenceVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) ExperienceAndLevelReferenceView *rootView;
@property (nonatomic, strong) NSArray *levelContentContainer;
@property (nonatomic, strong) NSArray *experiecneContentContainer;
@end
@implementation ExperienceAndLevelReferenceVC
- (void)loadView{
    self.rootView = [[ExperienceAndLevelReferenceView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.rootView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setParameter];
}

- (void)setParameter{
    self.rootView.levelTableView.delegate        = self;
    self.rootView.levelTableView.dataSource      = self;
    self.rootView.experienceTableView.delegate   = self;
    self.rootView.experienceTableView.dataSource = self;
    self.levelContentContainer = @[@"所需总经验50，不可提现",
                                   @"所需总经验150，不可提现",
                                   @"所需总经验300，每月可提现一次，提现的钻石总数需求200，提现比：50%",
                                   @"所需总经验500，每月可提现一次，提现的钻石总数需求200，提现比：60%",
                                   @"所需总经验800，每月可提现一次，提现的钻石总数需求200，提现比：70%",
                                   @"所需总经验1200，每月可提现两次，提现的钻石总数需求150，提现比：75%",
                                   @"所需总经验1600，每月可提现两次，提现的钻石总数需求150，提现比：80%",
                                   @"所需总经验2000，每月可提现两次，提现的钻石总数需求150，提现比：85%",
                                   @"所需总经验2500，每月可提现两次，提现的钻石总数需求100，提现比：90%",
                                   @"所需总经验3000，每月可提现三次，提现的钻石总数需求100，提现比：90%"];
    
    self.experiecneContentContainer = @[@"注册即可获得50点经验，只可获得一次",
                                        @"每日签到可获得10点经验",
                                        @"首次填写个人资料可获得100点经验",
                                        @"首次设置个人头像可获得150点经验",
                                        @"发布动态，单次获得5点经验，每日上限150",
                                        @"应答视频，单次获得10点经验，每日上限200",
                                        @"首次上传制式视频可获得50点经验"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == LevelTableView) {
        return self.levelContentContainer.count;
    }else{
        return self.experiecneContentContainer.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == LevelTableView) {
        LevelCell*cell = [tableView dequeueReusableCellWithIdentifier:@"LevelCell"];
        if (cell == nil) {
            cell = [[LevelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"levelCell"];
        }
        [cell setLevelCellData:[self.levelContentContainer objectAtIndex:indexPath.row] withIndex:indexPath.row];
        return cell;
    }else{
        ExperienceCell*cell = [tableView dequeueReusableCellWithIdentifier:@"ExperienceCell"];
        if (cell == nil) {
            cell = [[ExperienceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExperienceCell"];
        }
        [cell setExperienceCellData:[self.experiecneContentContainer objectAtIndex:indexPath.row]];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [Adaptor returnAdaptorValue:47];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
