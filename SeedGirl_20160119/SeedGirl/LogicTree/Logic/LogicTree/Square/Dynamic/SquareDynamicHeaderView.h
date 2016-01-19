//
//  SquareDynamicHeaderView.h
//  SeedGirl
//  功能描述 - 广场动态视图cell头部视图
//  Created by Admin on 16/1/6.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquareDynamicHeaderView : UIView
//设置个人信息
- (void)setUserIcon:(NSString *)url name:(NSString *)name level:(NSInteger)level;
//设置记录时间
- (void)setRecordTime:(NSString *)time;
@end
