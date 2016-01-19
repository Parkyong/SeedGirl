//
//  NoteView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/10/9.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteData.h"

typedef void (^ NOTEVCTOCHATVCBLOCKTYPE)(NSString *userHxid, NSString *userName);
typedef void (^ DELETEBLOCKTYPE)();
@interface NoteView : UIView

@property (nonatomic, copy) NOTEVCTOCHATVCBLOCKTYPE pushToChatVCBlock;
@property (nonatomic, copy) DELETEBLOCKTYPE               deleteBlcok;
@property (nonatomic, strong) NoteData                 *otherUserData;
- (void)addObserver;            //添加观察者
- (void)removeObserver;         //删除观察者

//首次加载
- (void)firstLoad;
//开始刷新
- (void)startDataRefresh;
@end