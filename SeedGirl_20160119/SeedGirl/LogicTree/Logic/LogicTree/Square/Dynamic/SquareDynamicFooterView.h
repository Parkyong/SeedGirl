//
//  SquareDynamicFooterView.h
//  SeedGirl
//  功能描述 - 广场动态视图cell脚部视图
//  Created by Admin on 16/1/6.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquareDynamicFooterView : UIView
//设置观看、评论、点赞数据
- (void)setWatchCount:(NSInteger)watch commentCount:(NSInteger)comment praiseCount:(NSInteger)praise;
@end
