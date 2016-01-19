//
//  CameraData.h
//  RecordingTest
//
//  Created by ParkHunter on 15/8/17.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CameraData : NSObject
@property (assign, nonatomic) CGFloat duration;
@property (strong, nonatomic) NSURL *fileURL;
@end
