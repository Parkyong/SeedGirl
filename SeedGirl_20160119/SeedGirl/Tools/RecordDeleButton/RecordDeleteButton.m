//
//  RecordDeleteButton.m
//  RecordingTest
//
//  Created by ParkHunter on 15/8/17.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "RecordDeleteButton.h"

@implementation RecordDeleteButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = DeleteButtonStyleNormal;
    }
    return self;
}

#pragma mark    设置状态
- (void)setType:(RecordDeleteButtonType)type{
    if (type == DeleteButtonStyleNormal) {
        self.enabled = YES;
        _type = DeleteButtonStyleNormal;
    }else if(type == DeleteButtonStyleDelete){
        self.enabled = YES;
        _type = DeleteButtonStyleDelete;
    }else{
        self.enabled = NO;
        _type = DeleteButtonStyleDisable;
    }
}
@end
