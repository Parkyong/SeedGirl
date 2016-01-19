//
//  NoteTableViewCell.h
//  SeedGirl
//
//  Created by ParkHunter on 15/10/9.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteData.h"
@protocol NoteTableViewCellProtocol;
@interface NoteTableViewCell : UITableViewCell
@property (nonatomic, assign) id<NoteTableViewCellProtocol>delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
- (void)setCellData:(NoteData *)_data;
@end

@protocol NoteTableViewCellProtocol <NSObject>
-(void)deleteNoteListConversationWithCell:(NoteTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath;
@end
