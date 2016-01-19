//
//  RecordTableViewCell.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/26.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CashRecordData;

@interface CashRecordCell : UITableViewCell
//设置显示数据
- (void)setShowData:(CashRecordData *)data;
@end
