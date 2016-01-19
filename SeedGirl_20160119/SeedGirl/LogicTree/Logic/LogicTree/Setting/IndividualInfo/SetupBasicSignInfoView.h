//
//  SetupBasicSignInfoView.h
//  SeedGirl
//
//  Created by ParkHunter on 16/1/4.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalInfoCellDelegate.h"

@interface SetupBasicSignInfoView : UIView
@property (nonatomic, copy) NSString        *name;          //标题名称
@property (nonatomic, copy) NSString *contentText;          //内容
@property (nonatomic, assign) NSInteger     index;          //index
@property (nonatomic, assign) id <PersonalInfoCellDelegate>delegate;
@property (nonatomic, assign)BOOL  isShowKeyboard;          //展示keyboard
-(void)editedStatus;
@end
