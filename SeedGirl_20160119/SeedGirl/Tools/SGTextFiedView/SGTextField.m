//
//  SGTextField.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/9.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SGTextField.h"

@implementation SGTextField

//- (CGRect)placeholderRectForBounds:(CGRect)bounds
//{
//    CGRect inset = CGRectMake(bounds.origin.x+17, bounds.origin.y, bounds.size.width, bounds.size.height);//更好理解些
//    return inset;
//}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 17.0f, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 17.0f, 0);
}

@end
