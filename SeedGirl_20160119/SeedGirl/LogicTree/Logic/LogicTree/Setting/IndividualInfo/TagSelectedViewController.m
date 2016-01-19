//
//  TagSelectedViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "TagSelectedViewController.h"
#import "TagSelectedView.h"
#import "SeedTagData.h"
#import "UIColor+Expand.h"
#import "UserData.h"
@interface TagSelectedViewController ()
@property (nonatomic, strong) TagSelectedView *rootView;
@end
@implementation TagSelectedViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.rootView = [[TagSelectedView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.rootView];

    //添加已经选择标签
    [self.rootView.selectData addObjectsFromArray:[[[UserManager manager] userData] userTagList]];


    
    [self getTagListDataWithResult:^(BOOL isSuccess, id netData) {
        if (isSuccess) {
            NSMutableArray *tagArray = [NSMutableArray array];
            for (NSDictionary *itemDict in netData) {
                SeedTagData *itemData = [[SeedTagData alloc] init];
                [itemData setSeedTagData:itemDict];
                [tagArray addObject:itemData];
            }
            [self.rootView.dataSource addObject:tagArray];
            [self.rootView.tableView reloadData];
        }else{
            
        }
    }];
}

#pragma mark    获取tag列表
- (void)getTagListDataWithResult:(void(^)(BOOL isSuccess, id netData))result{
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_system_taglist"] parameters:nil success:^(id responseObject) {
        if (publishProtocol(responseObject) == 0) {
            NSArray*tagList = [responseObject objectForKey:@"tagList"];
            result(YES, tagList);
        }else{
            result(NO, nil);
        }
    } failure:^(NSError *error) {
        result(NO, nil);
        APPLog(@"%@", error);
    }];
}

#pragma mark    退出
- (void)popCurrentPageAction{
    [[[[UserManager manager] userData] userTagList] removeAllObjects];
    [[[[UserManager manager] userData] userTagList] addObjectsFromArray:self.rootView.selectData];
    if (self.reloadBlock != nil) {
        self.reloadBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
