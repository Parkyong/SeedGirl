//
//  ImageCompressTool.m
//  SeedGirl
//
//  Created by ParkHunter on 16/1/13.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "ImageCompressTool.h"

@implementation ImageCompressTool
#pragma mark    压缩图片
+ (id)compressImage:(id)images{
    if ([images isKindOfClass:[UIImage class]]) {
        UIImage *imageData = (UIImage *)images;
        return  [[self class] imageWithImage:imageData scaledToSize:[[self class] getImageSize:imageData]];
    }
    if ([images isKindOfClass:[NSMutableArray class]]) {
        NSMutableArray *imageContainer = (NSMutableArray *)images;
        NSMutableArray *returnImageContainer = [NSMutableArray array];
        for (UIImage *image in imageContainer) {
            [returnImageContainer addObject:[[self class] imageWithImage:image scaledToSize:[[self class] getImageSize:image]]];
        }
        return  returnImageContainer;
    }
    NSLog(@"压缩失败");
    return nil;
}

#pragma mark    获取图片大小
+ (CGSize)getImageSize:(UIImage *)image{
    CGFloat width  = 0;
    CGFloat heigth = 0;
    if (image.size.width > SCREEN_WIDTH) {
        CGFloat scale = SCREEN_WIDTH/image.size.width;
        width  = image.size.width*scale;
        heigth = image.size.height*scale;
        if (heigth > SCREEN_HEIGHT) {
            CGFloat scale = SCREEN_HEIGHT/heigth;
            width  = width *scale;
            heigth = heigth *scale;
        }
    }else{
        if (image.size.height > SCREEN_HEIGHT) {
            CGFloat scale = SCREEN_HEIGHT/image.size.height;
            width  = image.size.width*scale;
            heigth = image.size.height*scale;
        }else{
            width  = image.size.width;
            heigth = image.size.height;
        }
    }
    return CGSizeMake(width, heigth);
}

#pragma mark    图片重绘
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
@end
