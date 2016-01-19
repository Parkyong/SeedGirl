//
//  RecordInfoView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/4.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "RecordInfoView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "RecordInfo_ReviewCell.h"
#import "RecordInfo_HeaderCell.h"
#import "LoginViewController.h"

#import "UIScrollView+OwnRefresh.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "CommentData.h"


@interface RecordInfoView ()<UITableViewDataSource,
UITableViewDelegate,
RecordInfo_ReviewCellProtocol,
RecordInfo_HeaderCellProtocl>
@property (nonatomic, strong) UIImageView      *backImageView;
@property (strong, nonatomic) NSMutableArray     *dynamicList;      //动态列表
@property (assign, nonatomic) NSInteger      dynamicListCount;      //动态列表总数
@property (assign, nonatomic) NSInteger          pageMaxCount;      //一页列表最大数量
@property (assign, nonatomic) NSInteger      currentPageIndex;      //当前页码索引
@end
@implementation RecordInfoView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setParameters];
        [self addViews];
        [self setDataRefresh];
    }
    return self;
}

#pragma mark    设置参数
- (void)setParameters{
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.dataConatainer       = [NSMutableArray array];
    [self.tableView registerClass:[RecordInfo_ReviewCell class] forCellReuseIdentifier:@"RecordInfo_ReviewCell"];
    [self.tableView registerClass:[RecordInfo_HeaderCell class] forCellReuseIdentifier:@"RecordInfo_HeaderCell"];
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.backImageView];
    [self addSubview:self.tableView];
}

//设置刷新
- (void)setDataRefresh {
    _currentPageIndex = 0;
    _pageMaxCount     = 5;
    _dynamicList      = [[NSMutableArray alloc] initWithCapacity:_pageMaxCount];
    _dynamicListCount = 0;
    WeakSelf;
    //下拉刷新
    [self.tableView addHeaderWithRefreshingBlock:^{
        if ([weakSelf.tableView isFooterRefreshing]) {
            [weakSelf.tableView headerEndRefreshing];
            return ;
        }
        
        [weakSelf.tableView footerResetNoMoreData];
        
        weakSelf.currentPageIndex = 0;
        [weakSelf.dynamicList removeAllObjects];
        //添加测试数据
        [weakSelf addTestData];
    }];
    
    //上拉刷新
    [self.tableView addFooterWithRefreshingBlock:^{
        if([weakSelf.tableView isHeaderRefreshing]) {
            [weakSelf.tableView footerEndRefreshing];
            return ;
        }
        
        weakSelf.currentPageIndex ++;
        //添加测试数据
        [weakSelf addTestData];
    }];
}

//添加测试数据
- (void)addTestData {
    [self getReviewWordWithResult:^(BOOL isSucces,id netData) {
        if (isSucces) {
            if ([netData objectForKey:@"commentList"] != nil &&
                ![[netData objectForKey:@"commentList"] isEqual:[NSNull null]]) {
                NSArray *recordList = [netData objectForKey:@"commentList"];
                for (NSDictionary *recordlistItem in recordList) {
                    CommentData *data = [[CommentData alloc] init];
                    [data setData:recordlistItem];
                    [_dynamicList addObject:data];
                }
                _dynamicListCount = _dynamicList.count;
                [self.tableView reloadData];
                [self stopDataRefresh];
            }
        }
    }];
}

#pragma mark    代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataConatainer.count;
    }else{
        return _dynamicList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        RecordInfo_HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordInfo_HeaderCell"];
        [self setUpDataOfCell:cell atIndexPath:indexPath];
        cell.delegate = self;
        cell.weakTableView = self.tableView;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        RecordInfo_ReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordInfo_ReviewCell"];
        [self setUpDataOfCell:cell atIndexPath:indexPath];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return  [tableView fd_heightForCellWithIdentifier:@"RecordInfo_HeaderCell" cacheByIndexPath:indexPath configuration:^(RecordInfo_HeaderCell *cell) {
            [self setUpDataOfCell:cell atIndexPath:indexPath];
        }];
    }else{
        CGFloat heigth = [tableView fd_heightForCellWithIdentifier:@"RecordInfo_ReviewCell" cacheByIndexPath:indexPath configuration:^(RecordInfo_ReviewCell *cell) {
            [self setUpDataOfCell:cell atIndexPath:indexPath];
        }];

        return heigth;
    }
    return 0;
}

//开始刷新
- (void)startDataRefresh {
    [self.tableView headerBeginRefreshing];
}

//停止刷新
- (void)stopDataRefresh {
    if([self.tableView isHeaderRefreshing]) {
        [self.tableView headerEndRefreshing];
    }
    
    if([self.tableView isFooterRefreshing]) {
        [self.tableView footerEndRefreshing];
    }
}

//首次加载
- (void)firstLoad {
    if (_dynamicList == nil || _dynamicListCount == 0) {
        NSLog(@"dynamic first load");
        //开始刷新
        [self startDataRefresh];
    }
}

#pragma mark    设置数据
- (void)setUpDataOfCell:(id)cell atIndexPath:(NSIndexPath *)indexPath{
    id cellData = nil;
    if (indexPath.section == 0) {
        cellData = self.dataConatainer[indexPath.row];
    }else{
        cellData = _dynamicList[indexPath.row];
    }
    [cell setCellsData:cellData withIndexPath:indexPath];
}

#pragma mark    懒加载对象
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BarHeigthPY, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        //        _tableView.bounces                        = NO;
        _tableView.backgroundColor                = RGBA(0, 0, 0, 0.5);
        
    }
    return _tableView;
}

- (UIImageView *)backImageView{
    if (_backImageView == nil) {
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, BarHeigthPY, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        //        _backImageView.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"1.jpg"]];
        
    }
    return _backImageView;
}

#pragma mark    方法
#pragma mark    评论列表
- (void)reviewCellNoteAction:(RecordInfo_ReviewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    APPLog(@"RecordInfo_ReviewCell:noteAction");
    if (![self isLogined]) {
        return;
    }
    
    //防止对自己聊天
    CommentData *data = [_dynamicList objectAtIndex:indexPath.row];
    if ([data.userHxid isEqualToString:[[UserManager manager] userHxid]]) {
        return;
    }
    
    if (self.noteBlock != nil) {
        self.noteBlock(data.userName, data.userHxid);
    }
}

- (void)reviewCellReplyAction:(RecordInfo_ReviewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    APPLog(@"RecordInfo_ReviewCell:replyAction");
    if (![self isLogined]) {
        return;
    }
    if (self.commentBlock != nil) {
        CommentData *data = [_dynamicList objectAtIndex:indexPath.row];
        self.commentBlock(NO, data.commentID);
    }
    
}

- (void)reviewCellPriseAction:(RecordInfo_ReviewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    APPLog(@"RecordInfo_ReviewCell:priseAction");
    if (![self isLogined]) {
        return;
    }
    WeakSelf;
    CommentData *data = [_dynamicList objectAtIndex:indexPath.row];
    if (!data.isPraised) {
        [self setReviewPraiseFlagWithCommentID:data.commentID withResult:^(BOOL isSucces) {
            if (isSucces) {
                [weakSelf changeTableViewCellContentWithIndex:indexPath];
            }
        }];
    }
}

#pragma mark    个人故事
- (void)headerCellNoteAction:(RecordInfo_HeaderCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    APPLog(@"headerCellNoteAction");
    if (![self isLogined]) {
        return;
    }
    //防止对自己聊天
    RecordData*data = [self.dataConatainer objectAtIndex:indexPath.row];
    if ([data.userHxid isEqualToString:[[UserManager manager] userHxid]]) {
        return;
    }
    if (self.noteBlock != nil) {
        self.noteBlock(data.userName, data.userHxid);
    }
}

- (void)headerCellCommentAction:(RecordInfo_HeaderCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    APPLog(@"headerCellCommentAction");
    if (![self isLogined]) {
        return;
    }
    if (self.commentBlock != nil) {
        self.commentBlock(YES, nil);
    }
    
}

- (void)headerCellPriseAction:(RecordInfo_HeaderCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    APPLog(@"headerCellPriseAction");
    if (![self isLogined]) {
        return;
    }
}

- (void)headerCellZoomingPicture:(RecordInfo_HeaderCell *)cell withIndexPath:(NSIndexPath *)indexPath withData:(NSArray *)data{
    APPLog(@"headerCellZoomingPicture");
    if (self.showImageBlock != nil) {
        self.showImageBlock(data,indexPath.row);
    }
}

- (void)headerCellPlayVideo:(RecordInfo_HeaderCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    APPLog(@"headerCellPlayVideo");
    if (self.playVideoBlock != nil) {
        self.playVideoBlock();
    }
}

#pragma mark    加载数据函数
- (void)loadData:(NSMutableArray *)array{
    if (0 == array.count) {
        return;
    }
    WeakSelf;
    [self.dataConatainer removeAllObjects];
    [self.dataConatainer addObjectsFromArray:array];
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:[[array firstObject] userIcon]] placeholderImage:[UIImage imageNamed:@"default_pic.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.backImageView.image = [UIImage imageBlur:image];
    }];
    [self firstLoad];
    [self.tableView reloadData];
}

#pragma mark    判断是否登录
- (BOOL)isLogined{
    //    return YES;
    if (![[UserManager manager] isLogined]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.title = @"登录";
        UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.parentController presentViewController:loginNC animated:YES completion:nil];
        return NO;
    }
    return YES;
}

#pragma mark    更改tableviewCell
- (void)changeTableViewCellContentWithIndex:(NSIndexPath *)indexPath{
    CommentData *data = [_dynamicList objectAtIndex:indexPath.row];
    data.isPraised = YES;
    data.praiseCount++;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark    － 网络数据部分
#pragma mark    获取评论
- (void)getReviewWordWithResult:(void(^)(BOOL isSucces, id netData))result{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *recordID = [[self.dataConatainer firstObject] recordID];
    [parameters setValue:recordID forKey:@"record_id"];
    [parameters setValue:[NSNumber numberWithInteger:_currentPageIndex] forKey:@"page_number"];
    [parameters setValue:[NSNumber numberWithInteger:_pageMaxCount] forKey:@"limit_number"];
    
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_dynamic_comment"] parameters:parameters success:^(id responseObject) {
        NSLog(@"responseObject:%@", responseObject);
        if (publishProtocol(responseObject) == 0) {
            result(YES, responseObject);
        }else{
            result(NO, nil);
        }
    } failure:^(NSError *error) {
        result(NO, nil);
    }];
}

#pragma mark    进行点赞
- (void)setReviewPraiseFlagWithCommentID:(NSString *)commentID
                              withResult:(void(^)(BOOL isSucces))result{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:commentID forKey:@"comment_id"];
    [parameters setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameters setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameters setValue:[NSNumber numberWithInteger:0] forKey:@"from_user"];
    
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_comment_zan"] parameters:parameters success:^(id responseObject) {
        NSLog(@"responseObject:%@", responseObject);
        if (publishProtocol(responseObject) == 0) {
            result(YES);
        }else{
            result(NO);
        }
    } failure:^(NSError *error) {
        result(NO);
    }];
}
@end