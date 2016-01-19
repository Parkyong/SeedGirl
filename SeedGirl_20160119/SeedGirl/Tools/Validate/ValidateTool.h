//
//  ValidateTool.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/2.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidateTool : NSObject
//昵称
+ (BOOL) validateNickname:(NSString *)nickname;

//昵称
+ (BOOL) validateBankcardNum:(NSString *)nickname;

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

//是否为中文
+ (BOOL)isChinese:(NSString *)word;
@end
