//
//  RecordInfoView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/4.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordData.h"
#import "CommentData.h"
typedef NS_ENUM(NSInteger, RecordInfoPageType){
    RecordInfoNotePage,
    RecordInfoCommentPage
};
typedef void (^SHOWIMAGEBLOCKTYPE)(NSArray *recordData, NSInteger currentIndex);
typedef void (^RECORDINFOCOMMENTPAGEBLOCKTYPE)(BOOL isHeaderReview, NSString *commentID);
typedef void (^RECORDINFONOTEPAGEBLOCKTYPE)(NSString *hxName, NSString *hxID);
typedef void (^RECORDINFOPRAISEBLOCKTYPE)(NSString *commentID);
typedef void (^RECORDINFOPLAYVIDEOBLOCKTYPE)();
@interface RecordInfoView : UIView
@property (nonatomic, strong) UITableView                    *tableView;
@property (nonatomic, strong) NSMutableArray            *dataConatainer;
@property (nonatomic, copy) SHOWIMAGEBLOCKTYPE           showImageBlock;
@property (nonatomic, copy) RECORDINFOCOMMENTPAGEBLOCKTYPE commentBlock;
@property (nonatomic, copy) RECORDINFONOTEPAGEBLOCKTYPE       noteBlock;
@property (nonatomic, copy) RECORDINFOPRAISEBLOCKTYPE        priseBlock;
@property (nonatomic, copy) RECORDINFOPLAYVIDEOBLOCKTYPE playVideoBlock;
@property (nonatomic, strong) UIViewController        *parentController;
- (void)startDataRefresh;
- (void)loadData:(NSMutableArray *)array;
@end
