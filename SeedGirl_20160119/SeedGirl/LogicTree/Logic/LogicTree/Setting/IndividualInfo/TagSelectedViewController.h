//
//  TagSelectedViewController.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "BaseSubViewController.h"
typedef void (^RELOADBLOCKTYPE)();
@interface TagSelectedViewController : BaseSubViewController
@property (nonatomic, copy) RELOADBLOCKTYPE reloadBlock;
@end