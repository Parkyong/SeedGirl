//
//  SetupPersonalInfoViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 16/1/4.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "SetupPersonalInfoViewController.h"
#import "NetworkImageUploader.h"

#import "RecordInfoShowImageVC.h"
#import "PhotographViewController.h"
#import "AlbumViewController.h"
#import "TagSelectedViewController.h"
#import "SeedTagData.h"
#import "UserData.h"


@interface SetupPersonalInfoViewController () <UIAlertViewDelegate>
@property (nonatomic, strong) NSArray *tempArray;
@property (nonatomic, strong) NSString *tempTagString;
@end
@implementation SetupPersonalInfoViewController

- (void)loadView{
    self.rootView = [[SetupPersonalInfoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view     = self.rootView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rootView addObserver];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.rootView removeObserver];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self customNavigationBar];
    [self addBlock];
    [self settingViewsData];
    [self addObserver];
}

#pragma mark    进入页面后刷新数据
- (void)settingViewsData{
    WeakSelf;
    [self net_userInfoCompletionWithBlock:^(BOOL isFinish) {
        if (isFinish) {
            [weakSelf.rootView successRefreshAction];
            self.tempArray = [weakSelf.rootView getUploadBasicInfo];
            self.tempTagString = [NSString stringWithFormat:@"%@", [self getTagListParameter]];
        }else{
            [weakSelf.rootView failedRefreshAction];
        }
    }];
}

#pragma mark    - 网络请求
#pragma mark    获取个人信息
- (void)net_userInfoCompletionWithBlock:(void(^)(bool))result{
    OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    NSDictionary *parameters = @{@"user_id":[[UserManager manager] userID],
                                 @"session_token":[[UserManager manager] userSessionToken]};
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_get_userinfo"] parameters:parameters success:^(id responseObject) {
        if (0 == userInfoProtocol(responseObject)) {
            [progressHUD hide:YES];
            result(YES);
        }else{
            result(NO);
        }
        [progressHUD hide:YES];
    } failure:^(NSError *error) {
        result(NO);
        [progressHUD hide:YES];
    }];
}

#pragma mark    更新个人数据
- (void)updateUserinfoWithPidContainer:(NSMutableArray *)pidContainer withResultBlock:(void (^)(BOOL isSuccess))result{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameters setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameters setValue:[[self.rootView getUploadBasicInfo] objectAtIndex:0]  forKey:@"name"];
    [parameters setValue:[NSNumber numberWithInteger:[[[self.rootView getUploadBasicInfo] objectAtIndex:1] integerValue]] forKey:@"age"];
    [parameters setValue:[NSNumber numberWithInteger:[[[self.rootView getUploadBasicInfo] objectAtIndex:2] integerValue]] forKey:@"height"];
    [parameters setValue:[[self.rootView getUploadBasicInfo] objectAtIndex:3]  forKey:@"interests"];
    [parameters setValue:[[self.rootView getUploadBasicInfo] objectAtIndex:4]  forKey:@"city"];
    [parameters setValue:[[self.rootView getUploadBasicInfo] objectAtIndex:5]  forKey:@"vocation"];
    [parameters setValue:[[self.rootView getUploadBasicInfo] objectAtIndex:6]  forKey:@"description"];
    [parameters setValue:[self getTagListParameter] forKey:@"taglist"];
    [parameters setValue:[self.rootView getUploadImagesParameters:pidContainer] forKey:@"showList"];
    
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_update_userinfo"] parameters:parameters success:^(id responseObject) {
        if (userUpadateProtocol(responseObject) == 0) {
            result(YES);
        }else{
            result(NO);
        }
    } failure:^(NSError *error) {
        result(NO);
    }];
}

#pragma mark    navigationBar
- (void)customNavigationBar{
    UIButton *rigtButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rigtButton setTitle:@"保存" forState:UIControlStateNormal];
    [rigtButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rigtButton.backgroundColor = [UIColor clearColor];
    [rigtButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigtButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark    添加Block
- (void)addBlock{
    WeakSelf;
    //进入观看照片页面
    self.rootView.pushToShowImageControllerBlock =^(NSIndexPath *indexPath, NSArray *imageList){
        RecordInfoShowImageVC *showImageVC = [[RecordInfoShowImageVC alloc] init];
        showImageVC.localData              =  imageList;
        showImageVC.currenIndex            = indexPath.row;
        showImageVC.modalTransitionStyle   = UIModalTransitionStyleCrossDissolve;
        [weakSelf presentViewController:showImageVC animated:YES completion:nil];
    };
    
    //进入tag选择页面
    self.rootView.pushToTagControllerBlock = ^(){
        TagSelectedViewController * tagSelectedVC = [[TagSelectedViewController alloc] init];
        tagSelectedVC.reloadBlock = ^{
            [weakSelf.rootView setData];
        };
        [weakSelf.navigationController pushViewController:tagSelectedVC animated:YES];
    };
    
    //进入拍照页面
    self.rootView.pushToImagePickerBlock  = ^(BOOL isTakePhoto, BOOL isHeadImage){
        if (isTakePhoto) {
            PhotographViewController *photographVC = [[PhotographViewController alloc] init];
            photographVC.isPushStyle               = NO;
            photographVC.viewType                  = CAMERAVIEW;
            photographVC.isChangeHeadImage         = isHeadImage;
            photographVC.tempPointer               = weakSelf;
            UINavigationController *photographNC = [[UINavigationController alloc] initWithRootViewController:photographVC];
            [weakSelf presentViewController:photographNC animated:NO completion:nil];
        }else{
            AlbumViewController *albumVC = [[AlbumViewController alloc] init];
            albumVC.isRequireMultibleButton = !isHeadImage;
            albumVC.isChangeHeadImage       = isHeadImage;
            albumVC.isPushStyle             = NO;
            albumVC.tempIndicator           = weakSelf;
            UINavigationController *albumNC = [[UINavigationController alloc] initWithRootViewController:albumVC];
            [weakSelf presentViewController:albumNC animated:NO completion:nil];
        }
    };
}

#pragma mark    添加观察者
- (void)addObserver{
    //头像更新后刷新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingViewsData) name:kUserInfoChange object:nil];
}

#pragma mark    保存数据
- (void)saveAction:(UIBarButtonItem *)item{
    if (self.rootView.isShaking) {
        [self.rootView stopHeaderImageViewShakeAction];
    }
    [self.rootView saveAction];

    NSArray *willUploadImages = [self.rootView getUploadImages];
    OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [progressHUD showProgressText:@"上传中"];
    
    if (willUploadImages.count != 0) {
        [[NetworkImageUploader manager] uploadPersonalBackgroundImages:willUploadImages witResult:^(BOOL isSuccess, NSMutableArray *iconContainer) {
            if (isSuccess) {
                //网络请求成功后
                [self updateUserinfoWithPidContainer:iconContainer withResultBlock:^(BOOL isSuccess) {
                    if (isSuccess) {
                        [progressHUD showProgressText:@"上传成功"];
                        [progressHUD hide:YES];
                        [[NSNotificationCenter defaultCenter] postNotificationName:kUserInfoChange object:nil];
                        [self.navigationController popViewControllerAnimated:NO];
                    }
                }];
            }else{
                [progressHUD showProgressText:@"上传失败"];
                [progressHUD hide:YES];
            }
        }];
    }else{
        [self updateUserinfoWithPidContainer:nil withResultBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                [progressHUD showProgressText:@"上传成功"];
                [progressHUD hide:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:kUserInfoChange object:nil];
                [self.navigationController popViewControllerAnimated:NO];
            }else {
                [progressHUD showProgressText:@"上传失败"];
                [progressHUD hide:YES];
            }
        }];
    }
}

#pragma mark    getParameter tool
- (NSString *)getTagListParameter{
    NSArray *array = [[[UserManager manager] userData] userTagList];
    if (array == nil || array.count == 0) {
        return nil;
    }
    NSMutableString *tagString = [NSMutableString string];
    for (int i =0; i < array.count-1; i++) {
        SeedTagData *data = [array objectAtIndex:i];
        [tagString appendFormat:@"%ld,", (long)data.TagID];
    }
    [tagString appendFormat:@"%ld", [[array lastObject] TagID]];
    return tagString;
}

#pragma mark    展示Actionsheet
- (void)showActionAlertViewAction{
    WeakSelf;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否保存已做的修改" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [weakSelf.navigationController popViewControllerAnimated:NO];
                                                         }];
    [alertController addAction:cancelAction];
    
    //保存
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             //action
                                                             [weakSelf commonActionAlertClickedButtonAtIndex:0];
                                                         }];
    [alertController addAction:saveAction];
    
    [alertController.view setTintColor:RGB(51, 51, 51)];
    [self presentViewController:alertController animated:YES completion:nil];
    
#else
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否保存已做的修改"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"保存",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
#endif
}

- (void)commonActionAlertClickedButtonAtIndex:(NSInteger)index{
    if (index == 0) {
        [self saveAction:nil];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self commonActionAlertClickedButtonAtIndex:buttonIndex];
}

#pragma mark    退出
- (void)popCurrentPageAction{
    [self.rootView saveAction];
    if ([self.tempArray isEqualToArray:[self.rootView getUploadBasicInfo]] &&
        [self.tempTagString isEqualToString:[self getTagListParameter]]){
        [self.navigationController popViewControllerAnimated:NO];
    }else{
        [self showActionAlertViewAction];
    }
}
@end
