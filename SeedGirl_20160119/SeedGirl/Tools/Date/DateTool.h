//
//  DateTool.h
//  SeedGirl
//
//  Created by ParkHunter on 15/12/7.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTool : NSObject
+ (NSString *)getTimeString:(NSString *)timeStamp;           //获取几小时之前
+ (NSString *)getDefaultDate:(NSString *)timeStamp;         //时间戳转换成系统时间
@end
