//
//  NetworkNotifier.m
//  SeedSocial
//
//  Created by Admin on 15/5/11.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import "NetworkNotifier.h"
#import "Reachability.h"
#import "APPConfig.h"

@import CoreTelephony.CTTelephonyNetworkInfo;

@interface NetworkNotifier ()
@property (strong, nonatomic) Reachability *hostReach;
@property (strong,nonatomic) CTTelephonyNetworkInfo *networkInfo;
@end

@implementation NetworkNotifier
@synthesize networkInfo,hostReach,radioAccessName,networkStatusName,connectServerState;

+ (instancetype)manager {
    static NetworkNotifier *manager = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        manager = [[NetworkNotifier alloc] init];
        manager->networkInfo = [[CTTelephonyNetworkInfo alloc] init];
        manager->hostReach = [Reachability reachabilityWithHostName:@"www.apple.com"];
        [manager->hostReach startNotifier];
    });
    return manager;
}

//开始监测
- (void)startNotifier {
    //网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityStatusChanged:) name:kReachabilityChangedNotification object:nil];
    //网络运营商状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(radioAccessChanged:) name:CTRadioAccessTechnologyDidChangeNotification object:nil];
}
//停止检测
- (void)stopNotifier {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTRadioAccessTechnologyDidChangeNotification object:nil];
}

//网络状态监听
- (void)reachabilityStatusChanged:(NSNotification*)notification {
    NetworkStatus status = hostReach.currentReachabilityStatus;
    switch (status) {
        case NotReachable:
            networkStatusName = @"无网络";
            break;
        case ReachableViaWWAN:
            networkStatusName = @"WWAN";
            break;
        case ReachableViaWiFi:
            networkStatusName = @"WIFI";
            break;
    }

    APPLog(@"/*------%@------*/",networkStatusName);
    
    if(status == NotReachable) {
        connectServerState = NO;
    } else {
        connectServerState = YES;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NetworkNotifierNotification object:@{@"network_status":[NSNumber numberWithBool:connectServerState]}];
}

//网络运营商状态监听
- (void)radioAccessChanged:(NSNotification*)notification {
    NSString *currentStatus = networkInfo.currentRadioAccessTechnology;
    if([currentStatus isEqualToString:CTRadioAccessTechnologyGPRS]) {
        //2.5G
        radioAccessName = @"GPRS";
    } else if([currentStatus isEqualToString:CTRadioAccessTechnologyEdge]) {
        //2.75G
        radioAccessName = @"EDGE";
    } else if([currentStatus isEqualToString:CTRadioAccessTechnologyWCDMA]) {
        //3G
        radioAccessName = @"WCDMA";
    } else if([currentStatus isEqualToString:CTRadioAccessTechnologyHSDPA]) {
        //3.5G WCDMA R5版本
        radioAccessName = @"HSDPA";
    } else if([currentStatus isEqualToString:CTRadioAccessTechnologyHSUPA]) {
        //3.5G WCDMA R6版本
        radioAccessName = @"HSUPA";
    } else if([currentStatus isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
        //3G
        radioAccessName = @"CDMA1x";
    } else if([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]) {
        //3G CDMA 演进版本
        radioAccessName = @"CDMAEVDORev0";
    } else if([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]) {
        //3G CDMA 演进版本
        radioAccessName = @"CDMAEVDORevA";
    } else if([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]) {
        //3G CDMA 演进版本
        radioAccessName = @"CDMAEVDORevB";
    }  else if([currentStatus isEqualToString:CTRadioAccessTechnologyeHRPD]) {
        //3.75G CDMA 演进版本
        radioAccessName = @"eHRPD";
    } else if([currentStatus isEqualToString:CTRadioAccessTechnologyLTE]) {
        //接近4G
        radioAccessName = @"LTE";
    }
    APPLog(@"/*------%@------*/",radioAccessName);
}

@end
