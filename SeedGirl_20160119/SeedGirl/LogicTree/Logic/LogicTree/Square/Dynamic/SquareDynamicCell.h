//
//  SquareDynamicCell.h
//  SeedGirl
//  功能描述 - 广场动态视图cell
//  Created by Admin on 15/10/29.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecordData;

@interface SquareDynamicCell : UITableViewCell
//设置显示数据
- (void)setShowData:(RecordData *)data;
@end
