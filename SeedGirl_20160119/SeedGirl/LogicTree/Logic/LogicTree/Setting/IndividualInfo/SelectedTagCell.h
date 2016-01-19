//
//  SelectedTagCell.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeedTagData.h"
@protocol SelectedTagCellProtocol;
@interface SelectedTagCell : UITableViewCell
@property (nonatomic, assign) id<SelectedTagCellProtocol>delegate;
- (void)setSelectedTagCellData:(NSMutableArray *)dataArray;
@end

@protocol SelectedTagCellProtocol <NSObject>
- (void)removeSelectItem:(NSInteger)index;
@end
