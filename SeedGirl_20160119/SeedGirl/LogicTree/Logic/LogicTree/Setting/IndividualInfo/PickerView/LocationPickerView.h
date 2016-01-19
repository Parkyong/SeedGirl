//
//  LocationPickerView.h
//  PickerViewTest
//
//  Created by ParkHunter on 15/9/10.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LocationPickerViewProtocol <NSObject>
- (void)getLocationAction:(NSString *)location;
@end
@interface LocationPickerView : UIPickerView <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, assign) id <LocationPickerViewProtocol>viewDelegate;
@end
