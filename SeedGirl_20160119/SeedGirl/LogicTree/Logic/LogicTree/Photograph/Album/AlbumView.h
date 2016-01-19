//
//  AlbumView.h
//  RecordingTest
//
//  Created by ParkHunter on 15/8/7.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIViewController   *parentsController;
@property (nonatomic, strong) UICollectionView *albumCollectionView;
@property (nonatomic, strong) NSMutableArray        *albumDataArray;
@property (nonatomic, strong) NSMutableArray         *selectedArray;
@property (nonatomic, assign) BOOL                 isMultibleSelect;
@property (nonatomic, assign) BOOL                isChangeHeadImage;
-(void)scrollToBottom;
@end
