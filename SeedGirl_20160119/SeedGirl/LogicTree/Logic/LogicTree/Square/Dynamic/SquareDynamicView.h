//
//  SquareDynamicView.h
//  SeedGirl
//  功能描述 - 广场动态视图
//  Created by Admin on 15/10/29.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecordData;

typedef void(^DynamicSelectedBlock)(RecordData *recordData);

@interface SquareDynamicView : UITableView

//动态选择block
@property (nonatomic, copy) DynamicSelectedBlock selectedBlock;

//首次加载
- (void)firstLoad;

@end
