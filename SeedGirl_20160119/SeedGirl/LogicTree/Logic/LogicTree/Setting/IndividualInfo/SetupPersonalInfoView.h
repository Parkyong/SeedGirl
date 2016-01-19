//
//  SetupPersonalInfoView.h
//  SeedGirl
//
//  Created by ParkHunter on 16/1/4.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SetupPersonalInfoViewHeaderShowImageBlockType)(NSIndexPath *, NSArray *);
typedef void (^SetupPersonalInfoViewHeaderShowTagBlockType)();
typedef void (^SetupPersonalInfoViewHeaderImagePickerBlockType)(BOOL isTakePhoto, BOOL isHeadImage);

@interface SetupPersonalInfoView : UIView
@property (nonatomic, strong) NSMutableArray *collectionImageArray;
@property (nonatomic, assign) BOOL  isShaking;
@property (nonatomic, copy) SetupPersonalInfoViewHeaderShowImageBlockType pushToShowImageControllerBlock;
@property (nonatomic, copy) SetupPersonalInfoViewHeaderShowTagBlockType         pushToTagControllerBlock;
@property (nonatomic, copy) SetupPersonalInfoViewHeaderImagePickerBlockType       pushToImagePickerBlock;


- (void)stopHeaderImageViewShakeAction;                                         //停止抖动
- (NSArray *)getUploadImages;                                                   //获取要上传的图片
- (NSArray *)getUploadImagesParameters:(NSArray *)PIDContainer;
- (NSArray *)getUploadBasicInfo;

- (void)successRefreshAction;                                                   //成功获取数据后刷新页面
- (void)failedRefreshAction;                                                    //获取数据失败后刷新页面
- (void)refreshHeaderImageCollectionView:(NSArray *)imageContainer;

//监视
- (void)addObserver;
- (void)removeObserver;

//结束编辑
- (void)saveAction;
- (void)setData;
@end
