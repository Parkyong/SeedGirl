//
//  RecordDeleteButton.h
//  RecordingTest
//
//  Created by ParkHunter on 15/8/17.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, RecordDeleteButtonType){
    DeleteButtonStyleNormal=0,
    DeleteButtonStyleDelete,
    DeleteButtonStyleDisable
};
@interface RecordDeleteButton : UIButton
@property (nonatomic, assign) RecordDeleteButtonType type;
@end
