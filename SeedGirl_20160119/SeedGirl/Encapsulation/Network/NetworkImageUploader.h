//
//  NetworkImageUploader.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/30.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^UpLoadIconBlock)(NSString *token, BOOL isSuccess);

@interface NetworkImageUploader : NSObject

+(instancetype)manager;

//照片
#pragma mark    上传头像
- (void)uploadHeaderImage:(UIImage *)headImage
               withResult:(void(^)(BOOL isSuccess))result;

#pragma mark    上传个人背景展示图片
- (void)uploadPersonalBackgroundImages:(NSArray *)images
                             witResult:(void(^)(BOOL isSuccess, NSMutableArray *iconContainer))result;

#pragma mark    上传动态广场展示图片
- (void)uploadDynamicBackgroundImages:(NSArray *)images
                           withResult:(void (^)(BOOL isSuccess, NSMutableArray *iconContainer))result;

#pragma mark    上传视频封面图片
- (void)uploadVideoCoverImage:(UIImage *)coverImage
                   withResult:(void (^)(BOOL isSuccess, NSMutableArray *iconContainer))result;
//视频
#pragma mark    上传动态视频
- (void)uploadDynamicVideo:(NSURL *)videoPath
                withResult:(void(^) (BOOL isSuccess, NSString *path))result;

#pragma mark    上传自定义视频
- (void)uploadCustomVideo:(NSURL *)videoPath
               withResult:(void(^) (BOOL isSuccess, NSString *path))result;

#pragma mark    上传制式视频
- (void)uploadStandardVideo:(NSURL *)videoPath
                  withTitle:(NSString*)title
                 withResult:(void(^) (BOOL isSuccess, NSString *path))result;
@end
