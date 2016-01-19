//
//  EditViewController.h
//  SeedGirl
//
//  Created by ParkHunter on 15/10/11.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController
@property (nonatomic, strong) UIImage            *showImage;
@property (nonatomic, assign) BOOL        isChangeHeadImage;
@property (nonatomic, strong) UIViewController *tempPointer;        //暂存指针
@end
