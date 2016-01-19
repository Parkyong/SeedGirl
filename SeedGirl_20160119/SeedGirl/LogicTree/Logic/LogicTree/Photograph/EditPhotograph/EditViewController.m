//
//  EditViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/11.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "EditViewController.h"
#import "EditView.h"

#import "TellStoryViewController.h"
#import "AlbumViewController.h"
#import "PhotographViewController.h"
#import "SetupPersonalInfoViewController.h"

#import "NetworkImageUploader.h"
#import "ImageCompressTool.h"
@interface EditViewController ()
@property (nonatomic, strong) EditView *rootView;
@end
@implementation EditViewController
- (void)loadView{
    self.rootView = [[EditView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.rootView.showImage = self.showImage;
    self.view     = self.rootView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.rootView setShowImageViewsImage:self.showImage];
    [self addFunction];
}

#pragma mark    添加功能
- (void)addFunction{
    [self.rootView.finishButton addTarget:self
                                   action:@selector(finishButtonAction:)
                         forControlEvents:UIControlEventTouchUpInside];
    
    [self.rootView.returnButton addTarget:self
                                   action:@selector(returnButtonAction:)
                         forControlEvents:UIControlEventTouchUpInside];
}

- (void)finishButtonAction:(UIButton *)sender{
    UIViewController *controller = [self.navigationController.viewControllers firstObject];
    //发表动态
    if ([controller isKindOfClass:[TellStoryViewController class]]) {
        [self.rootView.imageContainer addObject:self.rootView.showImage];
        TellStoryViewController *storyVC = (TellStoryViewController *)controller;
        [storyVC refreshCollectionViewAction:self.rootView.imageContainer withFlag:NO];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    if (self.isChangeHeadImage) {
        OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        [progressHUD showProgressText:@"上传中"];
        //提示信息开始
        [[NetworkImageUploader manager] uploadHeaderImage:[ImageCompressTool compressImage:self.rootView.showImage] withResult:^(BOOL isSuccess) {
            if (isSuccess) {
                //提示信息结束
                [[NSNotificationCenter defaultCenter] postNotificationName:kUserInfoChange object:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
                [progressHUD showProgressText:@"上传成功"];
                [progressHUD hide:YES afterDelay:1];
            }else{
                [progressHUD showProgressText:@"上传失败"];
                [progressHUD hide:YES afterDelay:1];
            }
        }];
        return;
    }
    
    //个人展示页 展示图片 点击照相
    if ([controller isKindOfClass:[PhotographViewController class]]) {
        PhotographViewController *photoVC = (PhotographViewController *)controller;
        if ([photoVC.tempPointer isKindOfClass:[SetupPersonalInfoViewController class]]) {
            [self.rootView.imageContainer addObject:self.rootView.showImage];
            SetupPersonalInfoViewController *setupPsersonalVC = (SetupPersonalInfoViewController *)photoVC.tempPointer;
//            [setupPsersonalVC.rootView.headerView refreshHeaderImageCollectionView:self.rootView.imageContainer];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    //个人展示页 展示图片 点击相册单张
    if ([controller isKindOfClass:[AlbumViewController class]]) {
        AlbumViewController *albumVC = (AlbumViewController *)controller;
        if ([albumVC.tempIndicator isKindOfClass:[SetupPersonalInfoViewController class]]) {
            [self.rootView.imageContainer addObject:self.rootView.showImage];
            SetupPersonalInfoViewController *setupPsersonalVC = (SetupPersonalInfoViewController *)albumVC.tempIndicator;
//            [setupPsersonalVC.rootView.headerView refreshHeaderImageCollectionView:self.rootView.imageContainer];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark    返回
- (void)returnButtonAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark    viewDidAppear
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

#pragma mark    隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}
@end
