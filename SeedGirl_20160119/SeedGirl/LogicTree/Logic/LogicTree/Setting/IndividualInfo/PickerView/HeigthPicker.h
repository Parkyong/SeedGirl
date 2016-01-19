//
//  HeigthPicker.h
//  PickerViewTest
//
//  Created by ParkHunter on 15/9/9.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HeigthPickerViewProtocol <NSObject>
- (void)getHeigthAction:(NSString *)heigth;
@end
@interface HeigthPicker : UIPickerView <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, assign) id<HeigthPickerViewProtocol>viewDelegate;
@end
