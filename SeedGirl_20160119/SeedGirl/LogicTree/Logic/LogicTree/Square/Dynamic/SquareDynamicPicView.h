//
//  SquareDynamicPicView.h
//  SeedGirl
//  功能描述 - 广场动态视图cell图片视图
//  Created by Admin on 15/11/25.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquareDynamicPicView : UIView
//设置基本属性
- (void)setMinLineSpacing:(CGFloat)minLineSpacing minItemSize:(CGSize)minItemSize;
//设置图片数据
- (void)setShowPicList:(NSMutableArray *)data;
//设置视频数据
- (void)setShowVideoList:(NSMutableArray *)data;
@end
