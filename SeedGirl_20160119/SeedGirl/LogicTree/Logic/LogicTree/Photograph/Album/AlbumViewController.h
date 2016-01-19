//
//  AlbumViewController.h
//  RecordingTest
//
//  Created by ParkHunter on 15/8/7.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSubViewController.h"
@interface AlbumViewController : BaseSubViewController
@property (nonatomic, assign) BOOL             isPushStyle;     //模态进入还是navigation进入
@property (nonatomic, assign) BOOL isRequireMultibleButton;     //是否需要多张选择
@property (nonatomic, assign) BOOL       isChangeHeadImage;     //是否更改头像
@property (nonatomic, strong) UIViewController *tempIndicator;
@end
