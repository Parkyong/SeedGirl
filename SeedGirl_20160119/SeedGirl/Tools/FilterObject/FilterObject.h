//
//  FilterObject.h
//  RecordingTest
//
//  Created by ParkHunter on 15/8/11.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, FilterType) {
    Default=0,
    FleetingTime,
    Blues,
    Sweet,
    BlackClothes,
    Greenwaves,
    Cookies,
    Fiberflax,
    BlackAndWhite,
    Latte,
    Corner,
    Pola
};
@interface FilterObject : NSObject
+ (instancetype)shareHandle;
- (UIImage*)getFiltrateImageWithType:(FilterType)type withOriginalImage:(UIImage *)originalImage;
@end
