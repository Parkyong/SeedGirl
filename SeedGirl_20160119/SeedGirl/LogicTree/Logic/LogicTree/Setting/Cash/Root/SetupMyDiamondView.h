//
//  SetupMyDiamondView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetupMyDiamondHeader.h"
#import "SetupMyDiamondFooter.h"

typedef void (^ SetupMyDiamondPushBlockType)(BOOL isBind);
@interface SetupMyDiamondView : UIView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) SetupMyDiamondPushBlockType pushBlock;
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) SetupMyDiamondHeader *headerView;
@property (nonatomic, strong) SetupMyDiamondFooter *footerView;
@property (nonatomic, assign) NSInteger     tempMoneyContainer;

- (void)refreshData;
- (void)addObserver;
- (void)removeObserver;
@end
