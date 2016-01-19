//
//  RecordInfo_ReviewCell.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/4.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RecordInfo_ReviewCellProtocol;
@class CommentData;

@interface RecordInfo_ReviewCell : UITableViewCell
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, assign) id <RecordInfo_ReviewCellProtocol>delegate;
- (void)setCellsData:(CommentData *)data withIndexPath:(NSIndexPath *)indexPath;
@end

@protocol RecordInfo_ReviewCellProtocol <NSObject>
@required
- (void)reviewCellNoteAction:(RecordInfo_ReviewCell *)cell withIndexPath:(NSIndexPath *)indexPath;
- (void)reviewCellReplyAction:(RecordInfo_ReviewCell *)cell withIndexPath:(NSIndexPath *)indexPath;
- (void)reviewCellPriseAction:(RecordInfo_ReviewCell *)cell withIndexPath:(NSIndexPath *)indexPath;
@end
