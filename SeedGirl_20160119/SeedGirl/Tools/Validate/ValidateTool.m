//
//  ValidateTool.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/2.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "ValidateTool.h"

@implementation ValidateTool
//昵称
+ (BOOL) validateNickname:(NSString *)nickname{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:nickname];
    return B;
}

//银行卡号码
+ (BOOL) validateBankcardNum:(NSString *)bankcardNum{
    NSString *phoneRegex = @"^[0-9]{14,24}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:bankcardNum];
}

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile{
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//是否为中文
+ (BOOL)isChinese:(NSString *)word{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:word];
}
@end
