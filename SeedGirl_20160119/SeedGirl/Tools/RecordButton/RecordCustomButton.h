//
//  RecordCustomButton.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/6.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RecordCustomButtonActionBlockType)();
@interface RecordCustomButton : UIView
@property (nonatomic, copy) NSString       *symbolImagePath;
@property (nonatomic, copy) NSString   *backgroundImagePath;
@property (nonatomic, copy) NSString                  *text;
- (void)addActionBlock:(RecordCustomButtonActionBlockType)block;
@end