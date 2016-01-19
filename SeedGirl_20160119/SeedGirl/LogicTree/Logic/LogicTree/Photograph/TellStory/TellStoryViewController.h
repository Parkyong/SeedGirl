//
//  TellStoryViewController.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/17.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "BaseSubViewController.h"
@interface TellStoryViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *collectionDataContainer;
@property (nonatomic, copy)   NSURL               *willUploadVideoUrl;
@property (nonatomic, assign) BOOL                        isVideoFlag;
- (void)refreshCollectionViewAction:(NSArray *)imageArray withFlag:(BOOL)isVideoFlag;

- (void)clearContainer;     //清空数据容器，并且只留一个加号图片
@end
