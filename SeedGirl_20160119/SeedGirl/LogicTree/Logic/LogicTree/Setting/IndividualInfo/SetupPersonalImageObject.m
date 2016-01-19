//
//  SetupPersonalImageObject.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/18.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "SetupPersonalImageObject.h"

@implementation SetupPersonalImageObject
- (instancetype)init{
    if (self = [super init]) {
        _image        = nil;
        _imagePath    = nil;
        _isImageData  = NO;
        _isBundleData = NO;
    }
    return self;
}
@end
