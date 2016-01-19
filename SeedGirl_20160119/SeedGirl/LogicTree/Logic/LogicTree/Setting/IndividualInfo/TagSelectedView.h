//
//  TagSelectedView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagSelectedView : UIView
@property (nonatomic, strong) NSMutableArray  *selectData;
@property (nonatomic, strong) NSMutableArray  *dataSource;
@property (nonatomic, strong) UITableView      *tableView;
@end