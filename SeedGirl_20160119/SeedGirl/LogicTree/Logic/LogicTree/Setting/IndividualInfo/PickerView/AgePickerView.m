//
//  AgePickerView.m
//  PickerViewTest
//
//  Created by ParkHunter on 15/9/9.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "AgePickerView.h"
@interface AgePickerView ()
@property (nonatomic, copy)  NSString *age;
@end

@implementation AgePickerView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self setDatePickerMode:UIDatePickerModeDate];
    [self setCalendar:[NSCalendar currentCalendar]];
    [self setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
    
    NSDate* minDate  = [self convertStringToDate:@"1900-01-01 00:00:00"];
    NSDate* maxDate  = [self convertStringToDate:[self maxDateString]];
    self.minimumDate = minDate;
    self.maximumDate = maxDate;
    [self addTarget:self action:@selector(changeAgeAction:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark    变化
- (void)changeAgeAction:(UIDatePicker *)picker{
    self.age = [NSString stringWithFormat:@"%ld", (long)[self ageWithDateOfBirth:picker.date]];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(getAgeAction:)]) {
        [self.delegate getAgeAction:self.age];
    }
}

#pragma mark    获取成年18
- (NSString *)maxDateString{
    NSDate *nowDate     = [NSDate date];
    NSString *nowYear   = [self stringFromDate:nowDate];
    NSString *maxString = [NSString stringWithFormat:@"%ld-01-01 00:00:00",[nowYear integerValue]-18];
    return maxString;
}

#pragma mark    转换时间
- (NSDate *)convertStringToDate:(NSString *)dateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

#pragma mark    nsdate转string
- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

#pragma mark    计算年龄
- (NSInteger)ageWithDateOfBirth:(NSDate *)date;{
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    NSInteger brithDateYear     = 0;
    NSInteger brithDateDay      = 0;
    NSInteger brithDateMonth    = 0;
    NSInteger currentDateYear   = 0;
    NSInteger currentDateDay    = 0;
    NSInteger currentDateMonth  = 0;
    
    if (version >= 8.0) {
        // 出生日期转换 年月日
        NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
       brithDateYear  = [components1 year];
       brithDateDay   = [components1 day];
       brithDateMonth = [components1 month];
        
        // 获取系统当前 年月日
        NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
       currentDateYear  = [components2 year];
       currentDateDay   = [components2 day];
       currentDateMonth = [components2 month];
    }else{
        // 出生日期转换 年月日
        NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
        brithDateYear  = [components1 year];
        brithDateDay   = [components1 day];
        brithDateMonth = [components1 month];
        
        // 获取系统当前 年月日
        NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        currentDateYear  = [components2 year];
        currentDateDay   = [components2 day];
        currentDateMonth = [components2 month];
    }
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    if (iAge < 0) {
        iAge = 0;
    }
    return iAge;
}
@end
