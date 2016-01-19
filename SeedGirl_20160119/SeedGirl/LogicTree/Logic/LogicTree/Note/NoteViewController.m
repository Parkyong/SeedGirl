//
//  NoteViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/17.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "NoteViewController.h"
#import "NoteView.h"

#import "NSString+Expand.h"
#import "ChatViewController.h"
#import "UserData.h"
#import "UserManager.h"
@interface NoteViewController () <ChatViewControllerDelegate, EMChatManagerDelegate>
@property (nonatomic, strong) NoteView          *noteView;           //纸条视图
@property (nonatomic, strong) UIView             *tipView;           //tip
@property (nonatomic, strong) UILabel           *tipLabel;           //tipLabel
//@property (nonatomic, assign) NSInteger conversationCount;           //covnersationCount
@end

@implementation NoteViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger conversationCount =  [[userDefault valueForKey:@"conversationCount"] integerValue];
    if (conversationCount != [self getConversationCount]) {
        [self saveInformation];
        [_noteView startDataRefresh];
    }
    
    if ([self getConversationCount] == 0) {
        [self.view bringSubviewToFront:self.tipView];
    }else{
        [self.view bringSubviewToFront:self.noteView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = AutoScrollViewInsetsFlag;
    [self setTitle:@"纸条"];
    
    //add subViewsf
    [self loadSubviews];
    
    //addObserver
    [self.noteView addObserver];

    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    //注册为SDK的ChatManager的delegate
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    //addBlock
    WeakSelf;
    self.noteView.pushToChatVCBlock=^(NSString *userHxid, NSString *userName){
        ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:userHxid isGroup:NO];
        chatVC.delelgate = weakSelf;
        chatVC.title     = userName;
        [weakSelf.navigationController pushViewController:chatVC animated:YES];
    };
    
    self.noteView.deleteBlcok = ^(){
        if ([weakSelf getConversationCount] == 0) {
            [weakSelf.view bringSubviewToFront:weakSelf.tipView];
        }else{
            [weakSelf.view bringSubviewToFront:weakSelf.noteView];
        }
    };
}

#pragma mark    代理方法
#pragma mark    代理
- (NSString *)avatarWithChatter:(NSString *)chatter{
    if ([chatter isEqualToString:[[UserManager manager] userHxid]]) {
        return [[[UserManager manager] userData] userIcon];
    }else{
        return self.noteView.otherUserData.userIcon;
    }
}

- (NSString *)nickNameWithChatter:(NSString *)chatter{
    if ([chatter isEqualToString:[[UserManager manager] userHxid]]) {
        return [[[UserManager manager] userData] userName];
    }else{
        return self.noteView.otherUserData.userName;
    }
}

#pragma mark - main
//加载子视图
- (void)loadSubviews {
    if ([self getConversationCount] != 0) {
        [self.view addSubview:self.tipView];
        [self.view addSubview:self.noteView];
    }else{
        [self.view addSubview:self.noteView];
        [self.view addSubview:self.tipView];
    }
}

#pragma mark    接收离线消息
- (void)didReceiveOfflineMessages:(NSArray *)offlineMessages{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger conversationCount =  [[userDefault valueForKey:@"conversationCount"] integerValue];
    if (conversationCount != [self getConversationCount]) {
        [self saveInformation];
        [_noteView startDataRefresh];
    }

    if ([self getConversationCount] == 0) {
        [self.view bringSubviewToFront:self.tipView];
    }else{
        [self.view bringSubviewToFront:self.noteView];
        [self.noteView startDataRefresh];
    }
}

- (void)didReceiveMessage:(EMMessage *)message{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger conversationCount =  [[userDefault valueForKey:@"conversationCount"] integerValue];
    if (conversationCount != [self getConversationCount]) {
        [self saveInformation];
        [_noteView startDataRefresh];
    }

    if ([self getConversationCount] == 0) {
        [self.view bringSubviewToFront:self.tipView];
    }else{
        [self.view bringSubviewToFront:self.noteView];
        [self.noteView startDataRefresh];
    }
    
}

#pragma mark    存储头像 昵称
- (void)saveInformation{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager
                              loadAllConversationsFromDatabaseWithAppend2Chat:NO];
    //创建文件
    if (![self isFileExist]) {
        [self createFile];
    }
    
    if (conversations.count == 0) {
        return;
    }
    
    BOOL isHaveData = NO;
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:[self filePath]];
    if (data == nil) {
        isHaveData = NO;
        data = [NSMutableDictionary dictionary];
    }else{
        isHaveData = YES;
    }
    
    for (EMConversation *conversation in conversations) {
        NSString *chatter = [conversation chatter];
        if (isHaveData) {
            NSArray *chatterArray = [data allKeys];
            BOOL haveEqualString  = NO;
            for (NSString *chatterID in chatterArray) {
                if ([chatterID isEqualToString:chatter]) {
                    haveEqualString = YES;
                    break;
                }
            }
            if (!haveEqualString) {
                [self getChatterInformationWithChatter:chatter withResult:^(BOOL isSuccess, NSDictionary *infomation) {
                    if (isSuccess) {
                        [data setValue:infomation forKey:chatter];
                        [data writeToFile:[self filePath] atomically:YES];
                        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                        [userDefault setValue:[NSNumber numberWithInteger:data.count] forKey:@"conversationCount"];
                    }else{
                        //没办法
                     }
                }];
            }
        }else{
            [self getChatterInformationWithChatter:chatter withResult:^(BOOL isSuccess, NSDictionary *infomation) {
                if (isSuccess) {
                    [data setValue:infomation forKey:chatter];
                    [data writeToFile:[self filePath] atomically:YES];
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setValue:[NSNumber numberWithInteger:data.count] forKey:@"conversationCount"];
                }else{
                    //没办法
                }
            }];
        }
    }
}

- (NSInteger)getConversationCount{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager
                              loadAllConversationsFromDatabaseWithAppend2Chat:NO];
    return conversations.count;
}

//创建文件夹
- (BOOL)createFile{
    // 创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //创建一个目录
    BOOL isSuccess = [fileManager createFileAtPath:[self filePath] contents:nil attributes:nil];
    
    return isSuccess;
}

#pragma mark    是否存在文件
- (BOOL)isFileExist{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:[self filePath]];
}

#pragma mark    获取文件路径
- (NSString *)filePath{
    
    NSString *documentsDirectory= [NSHomeDirectory()
                                   stringByAppendingPathComponent:@"Documents"];
    
    return  [documentsDirectory stringByAppendingString:@"/MyFriendShip.plist"];
}


- (void)getChatterInformationWithChatter:(NSString *)chatter withResult:(void (^)(BOOL isSuccess, NSDictionary *infomation))resultBlock{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:chatter forKey:@"hxid"];
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_hxid_to_userinfo"]
                            parameters:parameter
                               success:^(id responseObject) {
                                   if (publishProtocol(responseObject)== 0) {
                                       if ([responseObject objectForKey:@"userinfo"] != nil &&
                                           ![[responseObject objectForKey:@"userinfo"] isEqual:[NSNull null]]) {
                                           resultBlock(YES,[responseObject objectForKey:@"userinfo"]);
                                       }
                                   }else{
                                       resultBlock(NO, nil);                                       
                                   }

                               } failure:^(NSError *error) {
                                   NSLog(@"squareDynamic error is %@",error.localizedDescription);
                                   resultBlock(NO, nil);
                               }];
}

#pragma mark - lazyload
//纸条视图
- (NoteView *)noteView {
    if (_noteView == nil) {
        _noteView = [[NoteView alloc] initWithFrame:CGRectMake(0, BarHeigthYULEI,
                                                               SCREEN_WIDTH, SCREEN_HEIGHT- BarHeigthYULEI)];
        _noteView.backgroundColor = RGB(240, 242, 245);
        //        _noteView.contentMode = UIEdgeInsetsMake(0, 0, BottomTabBarHeight, 0);
    }
    return _noteView;
}

- (UIView *)tipView{
    if (_tipView == nil) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, BarHeigthYULEI,
                                                            SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tipView.backgroundColor = RGB(240, 242, 245);
        [_tipView addSubview:self.tipLabel];
    }
    return _tipView;
}

- (UILabel *)tipLabel{
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT -40)/2-BarHeigthYULEI,
                                                              SCREEN_WIDTH, 40)];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"赶紧跟粉丝聊天去吧~";
    }
    return _tipLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end