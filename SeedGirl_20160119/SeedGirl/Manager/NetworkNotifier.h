//
//  NetworkNotifier.h
//  SeedSocial
//  功能描述 - 网络状态监听
//  Created by Admin on 15/5/11.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkNotifier : NSObject
//网络状态名称
@property (copy, nonatomic) NSString *networkStatusName;
//网络运营商名称
@property (copy, nonatomic) NSString *radioAccessName;
//连接服务器状态
@property (assign) BOOL connectServerState;

+ (instancetype)manager;

//开始监测
- (void)startNotifier;
//停止检测
- (void)stopNotifier;

@end
