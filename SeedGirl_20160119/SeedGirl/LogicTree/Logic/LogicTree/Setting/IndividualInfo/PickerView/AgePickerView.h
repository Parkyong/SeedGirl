//
//  AgePickerView.h
//  PickerViewTest
//
//  Created by ParkHunter on 15/9/9.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AgePickerViewProtocol <NSObject>
- (void)getAgeAction:(NSString *)age;
@end
@interface AgePickerView : UIDatePicker
@property (nonatomic, assign) id<AgePickerViewProtocol>delegate;
@end
