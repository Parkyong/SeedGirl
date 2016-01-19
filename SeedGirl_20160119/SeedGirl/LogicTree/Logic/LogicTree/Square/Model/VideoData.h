//
//  VideoData.h
//  SeedGirl
//  功能描述 - 视频数据
//  Created by Admin on 15/10/29.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoData : NSObject

//发布用户昵称
@property (copy, nonatomic) NSString *userName;
//视频地址
@property (copy, nonatomic) NSString *videoURL;
//视频缩略图
@property (copy, nonatomic) NSString *videoThumbnail;
//视频宽度
@property (assign) CGFloat videoWidth;
//视频高度
@property (assign) CGFloat videoHeight;
//观察总数
@property (assign) NSInteger watchCount;

//设置数据
- (void)setData:(id)_data;

@end
