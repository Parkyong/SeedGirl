//
//  DateTool.m
//  SeedGirl
//
//  Created by ParkHunter on 15/12/7.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "DateTool.h"
#import "NSDate+Category.h"

@implementation DateTool
+(NSString *)getTimeString:(NSString *)timeStamp{
//时间戳时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:MM:ss"];
    NSDate *timeStampDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:[timeStamp doubleValue]];

    //现在时间
    NSDate *lateDate = [DateTool getNowDateFromatAnDate:[NSDate date]];
    NSTimeInterval cha = [lateDate timeIntervalSince1970] - [timeStampDate timeIntervalSince1970];
    NSString *timeString = nil;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (cha/86400>1)
    {
        return [formatter stringFromDate:timeStampDate];
//        timeString = [NSString stringWithFormat:@"%f", cha/86400];
//        timeString = [timeString substringToIndex:timeString.length-7];
//        timeString = [NSString stringWithFormat:@"%@天前", timeString];
    }
    return timeString;
}

#pragma mark    获取当前时区时间
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    
    return destinationDateNow;
}

+ (NSString *)getDefaultDate:(NSString *)timeStamp{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSDate *timeStampDate   = [NSDate dateWithTimeIntervalInMilliSecondSince1970:[timeStamp doubleValue]];
//    NSDate *afterChangeDate =[self getNowDateFromatAnDate:timeStampDate];
   return  [formatter stringFromDate:timeStampDate];
}

@end
