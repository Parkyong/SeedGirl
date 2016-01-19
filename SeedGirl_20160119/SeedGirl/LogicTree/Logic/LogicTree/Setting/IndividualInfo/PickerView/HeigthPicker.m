//
//  HeigthPicker.m
//  PickerViewTest
//
//  Created by ParkHunter on 15/9/9.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "HeigthPicker.h"
@interface HeigthPicker ()
@property (nonatomic, strong) NSMutableArray *heigthArray;
@property (nonatomic, copy)   NSString *heigth;
@end
@implementation HeigthPicker
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    self.heigthArray = [NSMutableArray array];
    for (int i = 0; i <= 40; i++) {
        [self.heigthArray addObject:[NSString stringWithFormat:@"%ld", (long)(150+i)]];
    }
    self.delegate   = self;
    self.dataSource = self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.heigthArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%@cm", [self.heigthArray objectAtIndex:row]];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.viewDelegate != nil && [self.viewDelegate respondsToSelector:@selector(getHeigthAction:)]) {
        self.heigth = [self.heigthArray objectAtIndex:row];
        [self.viewDelegate getHeigthAction:self.heigth];
    }
}
@end
