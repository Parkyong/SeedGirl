//
//  SquareDynamicContentView.h
//  SeedGirl
//  功能描述 - 广场动态视图cell内容视图
//  Created by Admin on 16/1/6.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquareDynamicContentView : UIView
//设置记录文本
- (void)setRecordText:(NSString*)text;
//设置记录展示图片和视频图片
- (void)setRecordPicList:(NSMutableArray *)pic video:(NSString *)video;
@end
