//
//  FansData.h
//  SeedGirl
//
//  Created by ParkHunter on 15/12/15.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FansData : NSObject
@property (nonatomic, copy)   NSString                  *fansIcon; //用户头像地址
@property (nonatomic, copy)   NSString                  *fansName; //用户名称
@property (nonatomic, copy)   NSString                    *fansID; //用户ID
@property (nonatomic, copy)   NSString                  *fansHxid; //用户环信ID
@property (nonatomic, assign) NSInteger   fansContributionDiamond; //用户贡献砖石数量
- (void)setData:(id)_data;
@end
