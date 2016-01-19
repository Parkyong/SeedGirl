//
//  SquareDynamicButtonView.h
//  SeedGirl
//  功能描述 - 广场动态cell按钮区域
//  Created by Admin on 15/11/26.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquareDynamicButtonView : UIView

//设置线条颜色及按钮图
- (void)setLineColor:(UIColor *)color ButtonImageName:(NSString *)image;
//设置数量
- (void)setTotalCount:(NSString *)count;

@end
