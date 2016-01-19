//
//  AlbumViewController.m
//  RecordingTest
//
//  Created by ParkHunter on 15/8/7.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "AlbumViewController.h"
#import "AlbumView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "TellStoryViewController.h"
#import "SetupPersonalInfoViewController.h"
#import "PhotographViewController.h"
#import "AlbumData.h"
@interface AlbumViewController ()
@property (nonatomic, strong) AlbumView            *rootView;
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray     *photoArray;
@end

@implementation AlbumViewController

- (void)loadView
{
    self.rootView = [[AlbumView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.rootView.parentsController = self;
    self.view     = self.rootView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.rootView scrollToBottom];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
    if (self.isRequireMultibleButton) {
        [self setRightBarButton];
    }
    self.rootView.isChangeHeadImage = !self.isRequireMultibleButton;
}

- (void)initialize{
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    self.photoArray    = [[NSMutableArray alloc] initWithCapacity:1];
    __weak typeof(self)weakSelf = self;
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    [weakSelf.photoArray addObject:result];
                }
            }];
        }else{
            [weakSelf.rootView.albumDataArray removeAllObjects];
            for (ALAsset *assetItem in self.photoArray) {
                AlbumData *data = [[AlbumData alloc] init];
                data.assetItem  = assetItem;
                data.isSelected = NO;
                [weakSelf.rootView.albumDataArray addObject:data];
            }
            [weakSelf.rootView.albumCollectionView reloadData];
            [weakSelf.rootView scrollToBottom];
        }
    } failureBlock:^(NSError *error) {
        APPLog(@"%@", error);
    }];
}

- (void)setRightBarButton{
    //rightbarButtonitem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择多张" style:UIBarButtonItemStyleBordered target:self action:@selector(multableSelectAction:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

#pragma mark    多选按钮
- (void)multableSelectAction:(UIBarButtonItem *)sender{
    if (!self.rootView.isMultibleSelect){
        self.rootView.isMultibleSelect = !self.rootView.isMultibleSelect;
        [self.navigationItem.rightBarButtonItem setTitle:@"完成"];
    }else{
        //发表动态页
        UIViewController *controller = [[self.navigationController viewControllers] firstObject];
        if ([controller isKindOfClass:[TellStoryViewController class]]) {
            TellStoryViewController *storyVC = (TellStoryViewController *)controller;
            [self changeAssetItemToImage];
            [storyVC refreshCollectionViewAction:self.rootView.selectedArray withFlag:NO];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
        //个人展示页
        if ([controller isKindOfClass:[AlbumViewController class]]) {
            UIViewController *pointer = [(AlbumViewController *)controller tempIndicator];
            SetupPersonalInfoViewController *setupPersonalVC = (SetupPersonalInfoViewController *)pointer;
            [self changeAssetItemToImage];
            [setupPersonalVC.rootView refreshHeaderImageCollectionView:self.rootView.selectedArray];//fix me
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
        //个人展示页
        if ([controller isKindOfClass:[PhotographViewController class]]) {
            UIViewController *pointer = [(PhotographViewController *)controller tempPointer];
            SetupPersonalInfoViewController *setupPersonalVC = (SetupPersonalInfoViewController *)pointer;
            [self changeAssetItemToImage];
            [setupPersonalVC.rootView refreshHeaderImageCollectionView:self.rootView.selectedArray];//fix me
            [self dismissViewControllerAnimated:YES completion:nil];
        }        
    }
}

#pragma mark    返回上一页
- (void)popCurrentPageAction{
    if (!self.isPushStyle) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark    更换数据类型
- (void)changeAssetItemToImage{
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:self.rootView.selectedArray];
    [self.rootView.selectedArray removeAllObjects];
    for (AlbumData *data in array) {
        UIImage *image = [UIImage imageWithCGImage:[[data.assetItem defaultRepresentation] fullScreenImage]];
        [self.rootView.selectedArray addObject:image];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
