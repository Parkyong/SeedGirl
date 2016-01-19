//
//  NoteView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/9.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "NoteView.h"
#import "NoteTableViewCell.h"
#import "DateTool.h"

#import "UIScrollView+OwnRefresh.h"
#import "EMChatManagerDefs.h"
@interface NoteView () <UITableViewDataSource, UITableViewDelegate, NoteTableViewCellProtocol>
@property (nonatomic, strong) UITableView     *tableView;              //tableView
@property (nonatomic, strong) UIView            *tipView;              //提示试图
@property (nonatomic, strong) UILabel          *tipLabel;              //提示标签
@property (strong, nonatomic) NSMutableArray   *noteList;              //请求数据
@property (assign, nonatomic) NSInteger    noteListCount;              //请求数据数量
@property (assign, nonatomic) NSInteger     pageMaxCount;              //一页列表最大数量
@property (assign, nonatomic) NSInteger currentPageIndex;              //当前页码索引
@end

@implementation NoteView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加试图
        [self addViews];
        
        //属性布局
        [self attributeLayout];
        
        //设置刷新
        [self setDataRefresh];
    }
    return self;
}

//添加观察者
- (void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(whenLogOutViewReloadData)
                                                 name:kUserLogout object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(whenLoginViewReloadData)
                                                 name:kUserLogin object:nil];
}

//删除观察者
- (void)removeObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kUserLogout
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kUserLogin
                                                  object:nil];
}

//推出登录时刷新数据
- (void)whenLogOutViewReloadData{
    [_noteList removeAllObjects];
    _noteListCount = _noteList.count;
    [self.tableView reloadData];
}

- (void)whenLoginViewReloadData{
    [self addTestData];
}

//添加试图
- (void)addViews{
    [self addSubview:self.tableView];
}

//属性布局
- (void)attributeLayout {
    [self.tableView registerClass:[NoteTableViewCell class]
           forCellReuseIdentifier:NSStringFromClass([NoteTableViewCell class])];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
}

//设置刷新
- (void)setDataRefresh {
    _currentPageIndex = 0;
    _pageMaxCount     = 10;
    _noteList = [[NSMutableArray alloc] initWithCapacity:_pageMaxCount];
    _noteListCount    = 0;
    
    WeakSelf;
    //下拉刷新
    [self.tableView addHeaderWithRefreshingBlock:^{
        if ([weakSelf.tableView isFooterRefreshing]) {
            [weakSelf.tableView headerEndRefreshing];
            return ;
        }
        
        [weakSelf.tableView footerResetNoMoreData];
        
        weakSelf.currentPageIndex = 0;
        [weakSelf.noteList removeAllObjects];
        //添加测试数据
        [weakSelf addTestData];
    }];
    
    //    //上拉刷新
    //    [self.tableView addFooterWithRefreshingBlock:^{
    //        if([weakSelf.tableView isHeaderRefreshing]) {
    //            [weakSelf.tableView footerEndRefreshing];
    //            return ;
    //        }
    //
    //        weakSelf.currentPageIndex ++;
    //        //添加测试数据
    //        [weakSelf addTestData];
    //    }];
    [self startDataRefresh];
}

#pragma mark - main
//首次加载
- (void)firstLoad {
    if (_noteList == nil || _noteListCount == 0) {
        NSLog(@"note first load");
        //开始刷新
        [self startDataRefresh];
    }
}

//添加测试数据
- (void)addTestData {
    WeakSelf;
    NSMutableDictionary *localData = [NSMutableDictionary dictionaryWithContentsOfFile:[self filePath]];
    NSArray *conversations = [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:NO];
    
    for (EMConversation *conversationItem in conversations) {
        NoteData *data = [[NoteData alloc] init];
        data.userName  = [[localData objectForKey:[conversationItem chatter]] objectForKey:@"name"];
        data.userIcon  = [[localData objectForKey:[conversationItem chatter]] objectForKey:@"icon"];
        data.userHxid  = [conversationItem chatter];
        [weakSelf combineDataWith:data withConversation:conversationItem];
        [_noteList addObject:data];
    }
    _noteListCount = _noteList.count;
    [self.tableView reloadData];
    [self stopDataRefresh];
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

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.noteListCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NoteTableViewCell class]) forIndexPath:indexPath];
    NoteData *data = [self.noteList objectAtIndex:indexPath.row];
    [cell setCellData:data];
    cell.delegate = self;
    cell.indexPath = indexPath;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NoteData *data = [self.noteList objectAtIndex:indexPath.row];
    if (self.pushToChatVCBlock != nil) {
        self.otherUserData = data;
        self.pushToChatVCBlock(data.userHxid, data.userName);
    }
    data.isRead = YES;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)deleteNoteListConversationWithCell:(NoteTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    NoteData *data = [self.noteList objectAtIndex:indexPath.row];
    //网络请求
    [[EaseMob sharedInstance].chatManager removeConversationByChatter:data.userHxid
                                                       deleteMessages:YES append2Chat:NO];
    [self.noteList removeObjectAtIndex:indexPath.row];
    self.noteListCount = self.noteList.count;
    [self.tableView reloadData];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:[NSNumber numberWithInteger:self.noteListCount] forKey:@"conversationCount"];
    
    NSMutableDictionary *localData = [NSMutableDictionary dictionaryWithContentsOfFile:[self filePath]];
    [localData removeObjectForKey:data.userHxid];
    [localData writeToFile:[self filePath] atomically:YES];
    if (self.deleteBlcok != nil) {
        self.deleteBlcok();
    }
}

//#pragma mark    用户纸条列表
//- (void)getNoteListDataWithResult:(void (^)(BOOL isSuccess, id netData))result{
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    [parameters setValue:[[UserManager manager] userID] forKey:@"user_id"];
//    [parameters setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
//    [parameters setValue:[NSNumber numberWithInteger:_currentPageIndex] forKey:@"page"];
//    [parameters setValue:[NSNumber numberWithInteger:_pageMaxCount] forKey:@"limit"];
//    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_noteList"] parameters:parameters success:^(id responseObject) {
//        if (publishProtocol(responseObject) == 0) {
//            NSArray *dataList = [responseObject objectForKey:@"user_list"];
//            result(YES, dataList);
//        }else{
//            result(NO, nil);
//        }
//    } failure:^(NSError *error) {
//        result(NO, nil);
//    }];
//}

#pragma mark    数据合成
- (NoteData *)combineDataWith:(NoteData *)data withConversation:(EMConversation *)conversation{
    if (conversation == nil) {
        return data;
    }
    
    EMMessage *message        = [conversation latestMessage];
    if ([conversation unreadMessagesCount] == 0) {
        data.isRead = YES;
    }else{
        data.isRead = NO;
    }
    if (message == nil) {
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:conversation.chatter
                                                           deleteMessages:YES append2Chat:NO];
        return data;
    }
    
    long long timestamp       = [message timestamp];            //最后发送消息时间
    id messageBody            = [[message messageBodies] lastObject];
    NSString    *lastMessage  = nil;
    if ([[messageBody class] isSubclassOfClass:[EMImageMessageBody class]]) {
        lastMessage = @"[图片]";
    } else  if([[messageBody class] isSubclassOfClass:[EMTextMessageBody class]]){
        lastMessage = [messageBody text];
    }else if([[messageBody class] isSubclassOfClass:[EMVideoMessageBody class]]){
        lastMessage = @"[视频]";
    }else if([[messageBody class] isSubclassOfClass:[EMLocationMessageBody class]]){
        lastMessage = [messageBody address];
    }else if ([[messageBody class] isSubclassOfClass:[EMVoiceMessageBody class]]){
        lastMessage = @"[语音]";
    }
    data.lastMSG   = lastMessage;
    data.timeStamp = [DateTool getDefaultDate:[NSString stringWithFormat:@"%lld",timestamp]] ;
    return data;
}

//#pragma mark    删除会话接口
//- (void)removeConversationListWithUserHxid:(NSString *)toUserHxid withResult:(void(^)(BOOL isSuccess))result{
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    [parameters setValue:[[UserManager manager] userID] forKey:@"user_id"];
//    [parameters setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
//    [parameters setValue:toUserHxid forKey:@"toUserHxid"];
//    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_conversation_del"] parameters:parameters success:^(id responseObject) {
//        NSLog(@"responseObject:%@", responseObject);
//        if (publishProtocol(responseObject) == 0) {
//            result(YES);
//        }else{
//            result(NO);
//        }
//    } failure:^(NSError *error) {
//        result(NO);
//        APPLog(@"%@", error);
//    }];
//}

#pragma mark    懒加载对象
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-BarHeigthYULEI-49)
                                                  style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (UIView *)tipView{
    if (_tipView == nil) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tipView.backgroundColor = RGB(240, 242, 245);
    }
    return _tipView;
}

- (UILabel *)tipLabel{
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT -40)/2, SCREEN_WIDTH, 40)];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"赶紧跟粉丝聊天去吧~";
        _tipLabel.backgroundColor = [UIColor redColor];
    }
    return _tipLabel;
}

#pragma mark    获取文件路径
- (NSString *)filePath{
    
    NSString *documentsDirectory= [NSHomeDirectory()
                                   stringByAppendingPathComponent:@"Documents"];
    
    return  [documentsDirectory stringByAppendingString:@"/MyFriendShip.plist"];
}

@end