//
//  OwnLabel.h
//  SeedSocial
//  功能描述 - 自定义label
//  Created by Admin on 15/6/18.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    TextVerticalAlignmentTop = 0,
    TextVerticalAlignmentMiddle,
    TextVerticalAlignmentBottom
} TextVerticalAlignment;

@interface OwnLabel : UILabel

@property (nonatomic) UIEdgeInsets contentEdgeInsets;

@property (nonatomic) TextVerticalAlignment verticalAlignment;

@end
