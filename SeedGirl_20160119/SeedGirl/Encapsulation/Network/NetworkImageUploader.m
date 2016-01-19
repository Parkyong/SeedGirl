//
//  NetworkImageUploader.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/30.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "NetworkImageUploader.h"
#import "AFNetworking.h"
#import "QiniuSDK.h"
@interface NetworkImageUploader ()
@property (nonatomic, strong) AFURLSessionManager *urlSessiontManager;
@property (nonatomic, strong) NSURLSessionUploadTask      *uploadTask;
@end
@implementation NetworkImageUploader
+ (instancetype)manager{
    static NetworkImageUploader *defaultManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = [[NetworkImageUploader alloc] init];
        defaultManager.urlSessiontManager = [[AFURLSessionManager alloc]
                                             initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
    });
    return defaultManager;
}

#pragma mark  - 照片上传
#pragma mark    上传头像
- (void)uploadHeaderImage:(UIImage *)headImage withResult:(void(^)(BOOL isSuccess))result{
    NSDictionary *paramer = [self getTokenParametersWithType:1];
    NSArray *imageContainer = [NSArray arrayWithObject:headImage];
    [self uploadImages:imageContainer withParameter:paramer withType:0 withResult:^(BOOL isSuccess, NSMutableArray *iconContaine){
        if (isSuccess) {
            result(YES);
        }else{
            result(NO);
        }
    }];
}

#pragma mark    上传个人背景展示图片
- (void)uploadPersonalBackgroundImages:(NSArray *)images
                             witResult:(void(^)(BOOL isSuccess , NSMutableArray *iconContainer))result{
    
    NSMutableDictionary *parameter = [self getTokenParametersWithType:2];
    [self uploadImages:images withParameter:parameter withType:0 withResult:^(BOOL isSuccess, NSMutableArray *iconContainer) {
        if (isSuccess) {
            result(YES, iconContainer);
        }else{
            result(NO, nil);
        }
    }];
}

#pragma mark    上传动态广场展示图片
- (void)uploadDynamicBackgroundImages:(NSArray *)images
                           withResult:(void (^)(BOOL isSuccess, NSMutableArray *iconContainer))result{
    NSMutableDictionary *parameter = [self getTokenParametersWithType:2];
    [self uploadImages:images withParameter:parameter withType:1 withResult:^(BOOL isSuccess, NSMutableArray *iconContainer) {
        if (isSuccess) {
            result(YES, iconContainer);
        }else{
            result(NO, nil);
        }
    }];
}

#pragma mark    上传视频封面图片
- (void)uploadVideoCoverImage:(UIImage *)coverImage
                   withResult:(void (^)(BOOL isSuccess, NSMutableArray *iconContainer))result{
    NSMutableDictionary *parameter = [self getTokenParametersWithType:2];
    NSArray *imageContainer = [NSArray arrayWithObject:coverImage];
    [self uploadImages:imageContainer withParameter:parameter withType:2 withResult:^(BOOL isSuccess, NSMutableArray *iconContainer) {
        if (isSuccess) {
            result(YES, iconContainer);
        }else{
            result(NO, nil);
        }
    }];
}

#pragma mark    上传照片
- (void)uploadImages:(NSArray *)images
       withParameter:(NSDictionary *)parameter
            withType:(NSInteger)type
          withResult:(void (^)(BOOL isSuccess, NSMutableArray *iconContainer))result{
    WeakSelf;
    //请求上传照片token
    [self net_getUploadTokenWithParameters:parameter withBlock:^(NSString *token, BOOL isSuccess) {
        if (isSuccess) {
            //准备上传数据
            [weakSelf uploadImageWithToken:token
                        withImageConatiner:[NSMutableArray arrayWithArray:images]
                        withEmptyContainer:[NSMutableArray array]
                            withUploadType:[[parameter objectForKey:@"upload_type"] integerValue]
                                  withType:type
                                 withTitle:nil
                                withResult:^(BOOL isSuccess, NSMutableArray *iconContainer) {
                                    if (isSuccess) {
                                        result(YES, iconContainer);
                                    }else{
                                        result(NO, nil);
                                    }
                                }];
        }else{
            result(NO, nil);
        }
    }];
}

#pragma mark    准备上传数据
- (void)uploadImageWithToken:(NSString *)token
          withImageConatiner:(NSMutableArray *)imageContainer
          withEmptyContainer:(NSMutableArray *)emptyContainer
              withUploadType:(NSInteger)uploadType
                    withType:(NSInteger)type
                   withTitle:(NSString *)title
                  withResult:(void(^)(BOOL isSuccess, NSMutableArray *iconContainer))result{
    if (imageContainer.count == 0) {
        result(YES, emptyContainer);
        return ;
    }
    
    WeakSelf;
    NSData *data   = nil;
    UIImage *image = [imageContainer objectAtIndex:0];
    if (UIImagePNGRepresentation(image)) {
        //返回为png图像。
        data = UIImagePNGRepresentation(image);
    }else {
        //返回为JPEG图像。
        data = UIImageJPEGRepresentation(image, 1.0);
    }
    
    //上传照片
    [self uploadImagesToQiNiuWith:data
                        withToken:token
                   withUploadType:uploadType
                         withType:type
                        withTitle:title
                       withResult:^(BOOL isSuccess, NSString *icon) {
                           if (isSuccess) {
                               //递归上传照片
                               [imageContainer removeObjectAtIndex:0];
                               //fix me
                               if (icon != nil) {
                                   [emptyContainer addObject:icon];
                               }
                               [weakSelf uploadImageWithToken:token
                                           withImageConatiner:imageContainer
                                           withEmptyContainer:emptyContainer
                                               withUploadType:uploadType
                                                     withType:type
                                                    withTitle:title
                                                   withResult:^(BOOL isSuccess, NSMutableArray *iconContainer) {
                                                       if (isSuccess) {
                                                           result(YES, iconContainer);
                                                       }else{
                                                           result(NO, nil);
                                                       }
                                                   }];
                           }else{
                               result(NO, nil);
                           }
                       } ];
}

#pragma mark  - 视频上传
#pragma mark    上传动态视频
- (void)uploadDynamicVideo:(NSURL *)videoPath withResult:(void(^) (BOOL isSuccess, NSString *path))result{
    NSMutableDictionary *parameter = [self getTokenParametersWithType:3];
    NSData *videoData = [NSData dataWithContentsOfURL:videoPath];
    [self uploadVideoWithData:videoData
                withParameter:parameter
                     withType:3
                    withTitle:nil
                   withResult:^(BOOL isSuccess, NSString *path) {
                       if (isSuccess) {
                           result(YES, path);
                       }else{
                           result(NO, path);
                       }
                   }];
}

#pragma mark    上传自定义视频
- (void)uploadCustomVideo:(NSURL *)videoPath withResult:(void(^) (BOOL isSuccess, NSString *path))result{
    NSMutableDictionary *parameter = [self getTokenParametersWithType:3];
    NSData *videoData = [NSData dataWithContentsOfURL:videoPath];
    [self uploadVideoWithData:videoData withParameter:parameter withType:1 withTitle:nil withResult:^(BOOL isSuccess, NSString *path) {
        if (isSuccess) {
            result(YES, path);
        }else{
            result(NO, nil);
        }
    }];
}

#pragma mark    上传制式视频
- (void)uploadStandardVideo:(NSURL *)videoPath
                  withTitle:(NSString*)title
                 withResult:(void(^) (BOOL isSuccess, NSString *path))result{
    NSMutableDictionary *parameter = [self getTokenParametersWithType:3];
    NSData *videoData = [NSData dataWithContentsOfURL:videoPath];
    [self uploadVideoWithData:videoData
                withParameter:parameter
                     withType:2
                    withTitle:title
                   withResult:^(BOOL isSuccess, NSString *path) {
                       if (isSuccess) {
                           result(YES, path);
                       }else{
                           result(NO, nil);
                       }
                   }];
}

#pragma mark     上传视频
- (void)uploadVideoWithData:(NSData*)videoData
              withParameter:(NSDictionary *)parameter
                   withType:(NSInteger)type
                  withTitle:(NSString*)title
                 withResult:(void(^)(BOOL isSuccess,NSString *path))result{
    [self net_getUploadTokenWithParameters:parameter withBlock:^(NSString *token, BOOL isSuccess) {
        if (isSuccess) {
            [self uploadVideoToQiNiuWith:videoData
                               withToken:token
                          withUploadType:3
                                withType:type
                               withTitle:title
                              withResult:^(BOOL isSuccess ,NSString *path) {
                                  if (isSuccess) {
                                      result(YES, path);
                                  }else{
                                      result(NO, nil);
                                  }
                              }];
        }else{
            result(NO,nil);
        }
    }];
}

#pragma mark    公用方法
#pragma mark    获取上传token
- (void)net_getUploadTokenWithParameters:(NSDictionary *)parameters withBlock:(UpLoadIconBlock)block{
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_getuploadtoken"] parameters:parameters success:^(id responseObject) {
        if(publishProtocol(responseObject) == 0) {
            NSString *tokenStr = [responseObject objectForKey:@"token"];
            block(tokenStr, YES);
        }
    } failure:^(NSError *error) {
        APPLog(@"error is %@",[error description]);
        block(nil, NO);
    }];
}

#pragma mark    video上传七牛服务器
- (void)uploadVideoToQiNiuWith:(NSData *)data
                     withToken:(NSString *)token
                withUploadType:(NSInteger)uploadType
                      withType:(NSInteger)type
                     withTitle:(NSString *)title
                    withResult:(void (^)(BOOL isSuccess, NSString *path))result{
    
    NSString       *key = [self getKeyWithType:uploadType];
    token               = [token stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *params= nil;
    NSString *value     = [NSString stringWithFormat:@"%ld",(long)type];
    params              = [NSMutableDictionary dictionary];
    [params setValue:value forKey:@"x:type"];
    if (type == 2) {
        [params setValue:title forKey:@"x:title"];
    }
    [self uploadDetailActionWithData:data withToken:token withKey:key withParams:params withResult:^(BOOL isSuccess, NSString *path) {
        if (isSuccess) {
            result(YES, path);
        }else{
            result(NO, nil);
        }
    }];
}

#pragma mark    Image上传七牛服务器
- (void)uploadImagesToQiNiuWith:(NSData *)data
                      withToken:(NSString *)token
                 withUploadType:(NSInteger)uploadType
                       withType:(NSInteger)type
                      withTitle:(NSString *)title
                     withResult:(void (^)(BOOL isSuccess, NSString *icon))result{
    
    NSString       *key = [self getKeyWithType:uploadType];
    token               = [token stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *params= nil;
    if (type != 0) {
        NSString *value = [NSString stringWithFormat:@"%ld",(long)type];
        params          = [NSMutableDictionary dictionary];
        [params setValue:value forKey:@"x:type"];
    }
    [self uploadDetailActionWithData:data withToken:token withKey:key withParams:params withResult:^(BOOL isSuccess, NSString *icon) {
        if (isSuccess) {
            result(YES, icon);
        }else{
            result(NO, nil);
        }
    }];
}

#pragma mark    上传至七牛服务器
- (void)uploadDetailActionWithData:(NSData *)data
                         withToken:(NSString *)token
                           withKey:(NSString *)key
                        withParams:(NSDictionary *)params
                        withResult:(void (^)(BOOL isSuccess, NSString* path))result
{
    QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil
                                               progressHandler:nil
                                                        params:params
                                                      checkCrc:YES
                                            cancellationSignal:nil];
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    [upManager putData:data key:key token:token
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  if (!info.error && info.statusCode == 200) {
                      APPLog(@"%@", info);
                      APPLog(@"%@", resp);
                      id statusKey = [resp valueForKey:@"status"];
                      if (statusKey != nil && [statusKey integerValue] == 0) {
                          NSString *ID = [resp objectForKey:@"id"];
                          result(YES, ID);
                      } else {
                          result(NO, nil);
                      }
                  }else{
                      APPLog(@"%@", info.error);
                      result(NO, nil);
                  }
              } option:opt];
}

#pragma mark    - tool
#pragma mark    获取上传token 参数
- (NSMutableDictionary *)getTokenParametersWithType:(NSInteger)type{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{@"user_id":[[UserManager manager] userID],
                                         @"session_token":[[UserManager manager] userSessionToken],
                                         @"upload_type":[NSNumber numberWithInteger:type]}];
    return parameters;
}

#pragma mark    获取上传token 参数
- (NSString *)getKeyWithType:(NSInteger)type{
    NSString *userID    = [[UserManager manager] userID] ;
    NSDate *dateNow     = [NSDate date];
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",(long)[dateNow timeIntervalSince1970]];
    
    switch (type) {
        case 1:
        {
            return  [[NSString stringWithFormat:@"user_%@_%@", userID, timeStamp] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            break;
        }
        case 2:
        {
            return  [[NSString stringWithFormat:@"photo_%@_%@", userID, timeStamp] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        case 3:
        {
            return  [[NSString stringWithFormat:@"p_v_%@_%@.mp4", userID, timeStamp] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        default:
            return nil;
    }
}
@end