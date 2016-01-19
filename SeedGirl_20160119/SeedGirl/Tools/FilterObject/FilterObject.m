//
//  FilterObject.m
//  RecordingTest
//
//  Created by ParkHunter on 15/8/11.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "FilterObject.h"
#import <CoreImage/CoreImage.h>
#import "ImageUtil.h"
#import "ColorMatrix.h"
@implementation FilterObject
+ (instancetype)shareHandle
{
    static FilterObject *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[FilterObject alloc] init];
    });
    return obj;
}

- (UIImage*)getFiltrateImageWithType:(FilterType)type withOriginalImage:(UIImage *)originalImage
{
    UIImage *newImage = nil;
    switch (type) {
        case Default:
        {
            newImage = originalImage;
            break;
        }
        case FleetingTime:
        {
            newImage = [ImageUtil imageWithImage:originalImage withColorMatrix:colormatrix_lomo];
            break;
        }
        case Blues:
        {
            newImage = [ImageUtil imageWithImage:originalImage withColorMatrix:colormatrix_landiao];

            break;
        }
        case Sweet:
        {
            newImage = [ImageUtil imageWithImage:originalImage withColorMatrix:colormatrix_huajiu];
            break;
        }
        case BlackClothes:
        {
            newImage = [ImageUtil imageWithImage:originalImage withColorMatrix:colormatrix_gete];
            break;
        }
        case Greenwaves:
        {
            newImage = [ImageUtil imageWithImage:originalImage withColorMatrix:colormatrix_ruise];
            break;
        }
        case Cookies:
        {
            newImage = [ImageUtil imageWithImage:originalImage withColorMatrix:colormatrix_danya];
            break;
        }
        case Fiberflax:
        {
            newImage = [ImageUtil imageWithImage:originalImage withColorMatrix:colormatrix_jiuhong];
            break;
        }
        case BlackAndWhite:
        {
            newImage = [ImageUtil imageWithImage:originalImage withColorMatrix:colormatrix_heibai];
            break;
        }
        case Latte:
        {
            newImage = [ImageUtil imageWithImage:originalImage withColorMatrix:colormatrix_qingning];
            break;
        }
        case Corner:
        {
            newImage = [ImageUtil imageWithImage:originalImage withColorMatrix:colormatrix_langman];
            break;
        }
        case Pola:
        {
            newImage = [ImageUtil imageWithImage:originalImage withColorMatrix:colormatrix_menghuan];
            break;
        }
        default:
            newImage = originalImage;
            break;
    }
    return newImage;
}
@end
