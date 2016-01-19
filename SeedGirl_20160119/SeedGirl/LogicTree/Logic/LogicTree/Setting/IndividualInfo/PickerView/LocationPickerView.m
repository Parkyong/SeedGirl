//
//  LocationPickerView.m
//  PickerViewTest
//
//  Created by ParkHunter on 15/9/10.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "LocationPickerView.h"
#import "LocationItem.h"

@interface LocationPickerView ()
@property (nonatomic, strong) NSArray   *provinces;
@property (nonatomic, strong) NSArray      *cities;
@property (nonatomic, strong) LocationItem *locate;
@property (nonatomic, copy)   NSString   *location;
@end

@implementation LocationPickerView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    self.delegate   = self;
    self.dataSource = self;
    self.provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
    self.cities = [[self.provinces objectAtIndex:0] objectForKey:@"cities"];
    self.locate = [[LocationItem alloc] init];
    self.locate.state = [[self.provinces objectAtIndex:0] objectForKey:@"state"];
    self.locate.city = [self.cities objectAtIndex:0];
}

#pragma mark - PickerView lifecycle
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [self.provinces count];
        case 1:
            return [self.cities count];
        default:
            return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return [[self.provinces objectAtIndex:row] objectForKey:@"state"];
            break;
        case 1:
            return [self.cities objectAtIndex:row];
            break;
        default:
            return @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:
            self.cities = [[self.provinces objectAtIndex:row] objectForKey:@"cities"];
            [self selectRow:0 inComponent:1 animated:YES];
            [self reloadComponent:1];
            
            self.locate.state = [[self.provinces objectAtIndex:row] objectForKey:@"state"];
            self.locate.city = [self.cities objectAtIndex:0];
            break;
        case 1:
            self.locate.city = [self.cities objectAtIndex:row];
            break;
        default:
            break;
    }
    if (self.viewDelegate != nil && [self.viewDelegate respondsToSelector:@selector(getLocationAction:)]) {
        self.location = [NSString stringWithFormat:@"%@ %@", self.locate.state, self.locate.city];
        [self.viewDelegate getLocationAction:self.location];
    }
}
@end
