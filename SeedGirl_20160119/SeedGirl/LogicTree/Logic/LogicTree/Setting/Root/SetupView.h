//
//  SetupView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/22.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, SetupPageType){
    SINGUPPAGE=0,
    LOOKFUNSPAGE,
    MYDIAMONDPAGE,
    MESSAGESETTING,
    EXPERIENCEREFERENCEPAGE,
    FEEDBACKPAGE,
    PERSONALINFOPAGE,
    LOGINANDLOGOUTPAGE
};
typedef void (^ChangePageBlockType)(NSInteger page);
@interface SetupView : UIView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) ChangePageBlockType changePageBlock;
@property (copy, nonatomic) dispatch_block_t logoutBlock;
- (void)footerRefresh;
@end
