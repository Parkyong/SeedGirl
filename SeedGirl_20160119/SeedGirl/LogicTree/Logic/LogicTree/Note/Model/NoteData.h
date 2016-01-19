//
//  NoteData.h
//  SeedGirl
//
//  Created by ParkHunter on 15/12/10.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteData : NSObject
@property (nonatomic, copy) NSString     *userIcon;    //头像
@property (nonatomic, copy) NSString     *userName;    //姓名
@property (nonatomic, copy) NSString     *userHxid;    //环信ID
@property (nonatomic, copy) NSString      *lastMSG;    //最后一条信息
@property (nonatomic, copy) NSString    *timeStamp;    //时间戳
@property (nonatomic, assign) BOOL          isRead;    //是否读
-(void)setData:(id)_data;
@end
