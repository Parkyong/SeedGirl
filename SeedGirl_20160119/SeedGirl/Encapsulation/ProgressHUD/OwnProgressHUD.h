//
//  OwnProgressHUD.h
//  SeedSocial
//  功能描述 - 进度提示
//  Created by Admin on 15/5/12.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OwnProgressHUD : NSObject

//显示文字模式
+ (instancetype)showAddedTo:(UIView *)view
                   animated:(BOOL)animated;
//设置垂直中心点偏移量
- (void)setCenterYOffset:(CGFloat)yOffset;
//设置显示文字
- (void)showProgressText:(NSString *)text;
//设置纯文本
- (void)showText:(NSString *)text;
//执行其他任务block
- (void)showAnimated:(BOOL)animated
 whileExecutingBlock:(void (^)())block
     completionBlock:(void (^)())completion;
//隐藏
- (void)hide:(BOOL)animated;
//延迟隐藏
- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end
