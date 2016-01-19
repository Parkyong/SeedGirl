//
//  MainTabBarViewController.h
//  SeedGirl
//  功能描述 - 主标签控制器，配合底部标签
//  Created by Admin on 15/11/18.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarViewController : UIViewController

//是否动画隐藏标签栏
- (void)tabBarHiddenStatus:(BOOL)hidden Animated:(BOOL)animated;
//跳转广场视图
- (void)showSquareController;
//跳转个人视图
- (void)showIndividualController;
//跳转发布视图
- (void)showIssueController;

@end
