//
//  Adaptor.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/8.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "Adaptor.h"

@implementation Adaptor
+(CGFloat)returnAdaptorValue:(CGFloat)value{
    return  ceilf(value/568.0*ScreenHeight);
}
@end
