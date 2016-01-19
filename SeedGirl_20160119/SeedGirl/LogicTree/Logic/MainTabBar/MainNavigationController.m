//
//  MainNavigationController.m
//  SeedGirl
//
//  Created by Admin on 15/11/18.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "MainNavigationController.h"
#import "MainTabBarViewController.h"

@interface MainNavigationController ()

//隐藏属性数组
@property (nonatomic, strong) NSMutableArray *hiddenArray;

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _hiddenArray = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Main
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //设置底部标签栏是否隐藏
    [_tabBarVC tabBarHiddenStatus:YES Animated:animated];
    [_hiddenArray addObject:@(YES)];

    [super pushViewController:viewController animated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    //设置底部标签栏是否隐藏
    [_tabBarVC tabBarHiddenStatus:NO Animated:animated];
    [_hiddenArray removeAllObjects];

    return [super popToRootViewControllerAnimated:animated];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated {
    //设置底部标签栏是否隐藏
    if (_hiddenArray.count > 1) {
        [_tabBarVC tabBarHiddenStatus:[[_hiddenArray lastObject] boolValue] Animated:animated];
    } else {
        [_tabBarVC tabBarHiddenStatus:NO Animated:animated];
    }
    [_hiddenArray removeLastObject];

    return [super popViewControllerAnimated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //设置底部标签栏是否隐藏
    if (_hiddenArray.count > 1) {
        NSInteger index = [self.childViewControllers indexOfObject:viewController];
        [_tabBarVC tabBarHiddenStatus:[[_hiddenArray objectAtIndex:index] boolValue] Animated:animated];
        
        [_hiddenArray removeObjectsInRange:NSMakeRange(index, _hiddenArray.count-1)];
    } else {
        [_tabBarVC tabBarHiddenStatus:NO Animated:animated];
        [_hiddenArray removeLastObject];
    }
    
    return [super popToViewController:viewController animated:animated];
}

@end
