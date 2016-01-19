//
//  MainNavigationController.h
//  SeedGirl
//  功能描述 - 主导航控制器，配合底部标签
//  Created by Admin on 15/11/18.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainTabBarViewController;

@interface MainNavigationController : UINavigationController

@property (nonatomic, strong) MainTabBarViewController *tabBarVC;

@end
