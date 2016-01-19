//
//  PersonalInfoCellDelegate.h
//  SeedGirl
//
//  Created by ParkHunter on 16/1/4.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PersonalInfoCellDelegate <NSObject>
- (void)pickerViewActionWithIndexPath:(NSInteger)indexPath;
- (void)textFieldActionWithIndexPath:(NSInteger)indexPath;
@end
