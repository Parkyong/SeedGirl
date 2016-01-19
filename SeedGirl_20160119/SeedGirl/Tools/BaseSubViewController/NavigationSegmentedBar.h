//
//  NavigationSegmentedBar.h
//  SeedGirl
//  功能描述 - 导航分段控制器
//  Created by Admin on 15/10/16.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SegementedSeletedBlock)(NSInteger index);

@interface NavigationSegmentedBar : UISegmentedControl

@property (copy, nonatomic) SegementedSeletedBlock selectedBlock;

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray*)items;

//是否显示新消息提醒
- (void)showNewMessage:(BOOL)status;

@end
