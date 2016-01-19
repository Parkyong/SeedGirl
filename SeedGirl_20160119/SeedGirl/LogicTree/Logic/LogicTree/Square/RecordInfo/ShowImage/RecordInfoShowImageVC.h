//
//  RecordInfoShowImageVC.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/9.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordData.h"
#import "BaseSubViewController.h"
#import "SetupPersonalImageObject.h"
@interface RecordInfoShowImageVC : BaseSubViewController
@property (nonatomic, strong) NSArray    *localData;
@property (nonatomic, assign) NSInteger currenIndex;
@end
