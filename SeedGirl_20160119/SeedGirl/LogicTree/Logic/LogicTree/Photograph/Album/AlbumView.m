//
//  AlbumView.m
//  RecordingTest
//
//  Created by ParkHunter on 15/8/7.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "AlbumView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "AlbumItemCell.h"
#import "EditViewController.h"
#import "TellStoryViewController.h"
#import "PhotographViewController.h"
#import "SkimVideoViewController.h"
#import "AlbumData.h"
#import "OwnProgressHUD.h"
#import "AlbumViewController.h"
#import "SetupPersonalInfoViewController.h"

@interface AlbumView ()
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end
@implementation AlbumView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize
{
    [self initParameter];
    [self addViews];
}

#pragma mark    初始化参数
- (void)initParameter
{
    self.albumDataArray = [NSMutableArray array];
    self.selectedArray  = [NSMutableArray array];
    self.isMultibleSelect               = NO;
    self.albumCollectionView.delegate   = self;
    self.albumCollectionView.dataSource = self;
    [self.albumCollectionView registerClass:[AlbumItemCell class] forCellWithReuseIdentifier:@"AlbumItemCell"];
}

#pragma mark    添加Views
- (void)addViews
{
    [self addSubview:self.albumCollectionView];
}

#pragma mark    代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.albumDataArray.count;
}

#pragma mark    显示cell
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"AlbumItemCell";
    AlbumItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    AlbumData *cellData = [self.albumDataArray objectAtIndex:indexPath.row];
    cell.photoImageView.image = [UIImage imageWithCGImage:cellData.assetItem.thumbnail];
    cell.isPhotoImageSelected = cellData.isSelected;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //是否是多选
    if (self.isMultibleSelect) {
        UIViewController *controller = [[self.parentsController.navigationController viewControllers] firstObject];
        
        //动态发表页
        if ([controller isKindOfClass:[TellStoryViewController class]]) {
            //多选
            AlbumData *data = [self.albumDataArray objectAtIndex:indexPath.row];
            if (data.isSelected) {
                data.isSelected = NO;
                [self.selectedArray removeObject:data];
            }else{
                TellStoryViewController *tellStoryVC = (TellStoryViewController *)controller;
                if (tellStoryVC.collectionDataContainer.count + self.selectedArray.count > 9) {
                    [self showMessage:@"动态图片不能超过9张"];
                    return;
                }
                data.isSelected = YES;
                [self.selectedArray addObject:data];
            }
        }
        
        //个人展示页选择相册
        if ([controller isKindOfClass:[AlbumViewController class]]) {
            UIViewController *pointer = [(AlbumViewController *)controller tempIndicator];
            SetupPersonalInfoViewController *setupPersonalVC = (SetupPersonalInfoViewController *)pointer;
            AlbumData *data = [self.albumDataArray objectAtIndex:indexPath.row];
            if (data.isSelected) {
                data.isSelected = NO;
                [self.selectedArray removeObject:data];
            }else{
                if (setupPersonalVC.rootView.collectionImageArray.count + self.selectedArray.count > 8) {
                    [self showMessage:@"个人展示图片不能超过8张"];
                    return;
                }
                data.isSelected = YES;
                [self.selectedArray addObject:data];
            }
        }
        
        //个人展示页选择照相后选择相册
        if ([controller isKindOfClass:[PhotographViewController class]]) {
            UIViewController *pointer = [(PhotographViewController *)controller tempPointer];
            SetupPersonalInfoViewController *setupPersonalVC = (SetupPersonalInfoViewController *)pointer;
            AlbumData *data = [self.albumDataArray objectAtIndex:indexPath.row];
            if (data.isSelected) {
                data.isSelected = NO;
                [self.selectedArray removeObject:data];
            }else{
                if (setupPersonalVC.rootView.collectionImageArray.count + self.selectedArray.count > 8) {
                    [self showMessage:@"个人展示图片不能超过8张"];
                    return;
                }
                data.isSelected = YES;
                [self.selectedArray addObject:data];
            }
        }

        [self.albumCollectionView reloadItemsAtIndexPaths:@[indexPath]];
    }else{
        UIViewController *controller = [[self.parentsController.navigationController viewControllers] firstObject];
        AlbumData *data = [self.albumDataArray objectAtIndex:indexPath.row];
        ALAssetRepresentation *representation = [data.assetItem defaultRepresentation];
        UIImage *image = [UIImage imageWithCGImage:[representation fullScreenImage]];
        EditViewController *editVC = [[EditViewController alloc] init];
        editVC.showImage = image;
        editVC.isChangeHeadImage = self.isChangeHeadImage;
        if ([controller isKindOfClass:[AlbumViewController class]]) {
            AlbumViewController *albumVC = (AlbumViewController *)controller;
            editVC.tempPointer = albumVC.tempIndicator;
        }
        [self.parentsController.navigationController pushViewController:editVC animated:YES];
    }
}

#pragma mark    滑动到最底部
- (void)scrollToBottom{
    if (self.albumDataArray.count == 0) {
        return;
    }
    NSInteger section = [self numberOfSectionsInCollectionView:self.albumCollectionView] - 1;
    NSInteger item    = [self collectionView:self.albumCollectionView numberOfItemsInSection:section] - 1;
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
    [self.albumCollectionView scrollToItemAtIndexPath:lastIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
}

#pragma mark    - 懒加载方法
- (UICollectionView *)albumCollectionView
{
    if (_albumCollectionView == nil) {
        _albumCollectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:self.flowLayout];
    }
    return _albumCollectionView;
}

#pragma mark    viewFlowLayout
- (UICollectionViewFlowLayout *)flowLayout
{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.itemSize = CGSizeMake((ScreenWidth-10)/4, (ScreenWidth-10)/4);
        _flowLayout.minimumLineSpacing      = 2;
        _flowLayout.minimumInteritemSpacing = 1;
    }
    return _flowLayout;
}

#pragma mark  - MOV转换成mp4
- (NSURL *)convert2Mp4:(NSURL *)movUrl {
    NSURL *mp4Url = nil;
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:AVAssetExportPresetHighestQuality];
        mp4Url = [movUrl copy];
        mp4Url = [mp4Url URLByDeletingPathExtension];
        mp4Url = [mp4Url URLByAppendingPathExtension:@"mp4"];
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        dispatch_semaphore_t wait = dispatch_semaphore_create(0l);
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    NSLog(@"failed, error:%@.", exportSession.error);
                } break;
                case AVAssetExportSessionStatusCancelled: {
                    NSLog(@"cancelled.");
                } break;
                case AVAssetExportSessionStatusCompleted: {
                    NSLog(@"completed.");
                } break;
                default: {
                    NSLog(@"others.");
                } break;
            }
            dispatch_semaphore_signal(wait);
        }];
        long timeout = dispatch_semaphore_wait(wait, DISPATCH_TIME_FOREVER);
        if (timeout) {
            NSLog(@"timeout.");
        }
        if (wait) {
            //dispatch_release(wait);
            wait = nil;
        }
    }
    
    return mp4Url;
}

#pragma mark    展示信息
- (void)showMessage:(NSString *)message{
    OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [progressHUD showText:message];
    [progressHUD hide:YES afterDelay:1];
}
@end