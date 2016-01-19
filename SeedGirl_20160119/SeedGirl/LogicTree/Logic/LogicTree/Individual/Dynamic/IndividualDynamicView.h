//
//  IndividualDynamicView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/19.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecordData;

typedef void(^DynamicSelectedBlock)(RecordData *recordData);

@interface IndividualDynamicView : UITableView
//动态选择block
@property (nonatomic, copy) DynamicSelectedBlock selectedBlock;
//首次加载
- (void)firstLoad;

- (void)addObserver;            //添加观察者
- (void)removeObserver;         //删除观察者
@end
