//
//  SeedTagData.h
//  SeedSocial
//  功能描述 - 种子标签属性数据
//  Created by Admin on 15/4/29.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>

@interface SeedTagData : NSObject <NSCoding>

//标签ID
@property (assign) NSInteger TagID;
//标签标题
@property (copy, nonatomic) NSString *TagText;
//标签颜色
@property (copy, nonatomic) NSString *TagTextColor;
//标签颜色 ps.调用这个
@property (strong, nonatomic) UIColor *TagColor;

//设置数据
- (void)setSeedTagData:(id)_data;

@end
