//
//  RecordInfoCommentVC.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/9.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSubViewController.h"
typedef void (^CommentRefreshBlockType)();
@interface RecordInfoCommentVC : BaseSubViewController
@property (nonatomic, copy) NSString                          *recordID;
@property (nonatomic, copy) NSString                         *commentID;
@property (nonatomic, copy) CommentRefreshBlockType refreshCommentBlock;
@property (nonatomic, assign) BOOL                       isHeaderReview;
@end
