//
//  RecordInfo_HeaderCell.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/5.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RecordInfo_HeaderCellProtocl;
@class RecordData;
@interface RecordInfo_HeaderCell : UITableViewCell
@property (nonatomic, assign) id <RecordInfo_HeaderCellProtocl>delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak)  UITableView *weakTableView;
- (void)setCellsData:(RecordData *)data withIndexPath:(NSIndexPath *)indexPath;
- (void)setCellFrame;
@end

@protocol RecordInfo_HeaderCellProtocl <NSObject>
@required
- (void)headerCellNoteAction:(RecordInfo_HeaderCell *)cell withIndexPath:(NSIndexPath *)indexPath;
- (void)headerCellCommentAction:(RecordInfo_HeaderCell *)cell withIndexPath:(NSIndexPath *)indexPath;
- (void)headerCellPriseAction:(RecordInfo_HeaderCell *)cell withIndexPath:(NSIndexPath *)indexPath;
- (void)headerCellZoomingPicture:(RecordInfo_HeaderCell *)cell withIndexPath:(NSIndexPath *)indexPath withData:(NSArray *)data;
- (void)headerCellPlayVideo:(RecordInfo_HeaderCell *)cell withIndexPath:(NSIndexPath *)indexPath;
@end
