//
//  OwnProgressHUD.m
//  SeedSocial
//
//  Created by Admin on 15/5/12.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import "OwnProgressHUD.h"
#import "MBProgressHUD.h"

@interface OwnProgressHUD () <MBProgressHUDDelegate>

@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation OwnProgressHUD

- (instancetype)initWithView:(UIView *)view animated:(BOOL)animated{
    if (view == nil) {
        return nil;
    }
    
    if (self = [super init]) {
        _progressHUD = [MBProgressHUD showHUDAddedTo:view animated:animated];
        _progressHUD.alpha = 0.8f;
        _progressHUD.removeFromSuperViewOnHide = YES;
        _progressHUD.delegate = self;
    }
    return self;
}

//显示文字模式
+ (instancetype)showAddedTo:(UIView *)view
                   animated:(BOOL)animated {
    OwnProgressHUD *progressHUD = [[OwnProgressHUD alloc] initWithView:view animated:animated];
    return progressHUD;
}
//设置垂直中心点偏移量
- (void)setCenterYOffset:(CGFloat)yOffset {
    _progressHUD.yOffset = yOffset;
}
//设置显示文字
- (void)showProgressText:(NSString *)text {
//    _progressHUD.labelText = text;
    _progressHUD.detailsLabelText = text;
    _progressHUD.detailsLabelFont = [UIFont systemFontOfSize:17.0f];
}

//设置纯文本
- (void)showText:(NSString *)text {
    _progressHUD.mode = MBProgressHUDModeText;
//    _progressHUD.labelText = text;
    _progressHUD.detailsLabelText = text;
    _progressHUD.detailsLabelFont = [UIFont systemFontOfSize:17.0f];
}
//执行其他任务block
- (void)showAnimated:(BOOL)animated
 whileExecutingBlock:(void (^)())block
     completionBlock:(void (^)())completion {
    [_progressHUD showAnimated:animated whileExecutingBlock:block completionBlock:completion];
}
//隐藏
- (void)hide:(BOOL)animated {
    [_progressHUD hide:animated];
}
//延迟隐藏
- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    [_progressHUD hide:animated afterDelay:delay];
}

#pragma mark - MBProgressHUD Delegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    [hud removeFromSuperview];
    hud = nil;
}

@end
