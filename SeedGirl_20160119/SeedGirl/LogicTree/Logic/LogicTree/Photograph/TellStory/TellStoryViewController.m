//
//  TellStoryViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/17.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "TellStoryViewController.h"
#import "TellStoryView.h"
#import "TellStoryCell.h"
#import "TellStoryPictureCell.h"
#import "TellStoryVideoCell.h"
#import "PhotographViewController.h"
#import "AlbumViewController.h"
#import "NetworkImageUploader.h"
#import "OwnProgressHUD.h"
#import "LoginViewController.h"
#import "CacheDataManager.h"
#import "MainTabBarViewController.h"
#import "ImageCompressTool.h"
#import "SetupPersonalImageObject.h"
#import "RecordInfoShowImageVC.h"
#import "SeedPlayer.h"


@interface TellStoryViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, TellStoryCellProtocol, UIActionSheetDelegate, UITextViewDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) TellStoryView                 *rootView;
@property (nonatomic, strong) UIActionSheet              *actionSheet;
@end
@implementation TellStoryViewController
- (void)loadView{
    self.rootView = [[TellStoryView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view     = self.rootView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark    viewDidLoad
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setParameters];
    [self setRightBarButton];
    self.automaticallyAdjustsScrollViewInsets = AutoScrollViewInsetsFlag;
}

#pragma mark    设置参数
- (void)setParameters{
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"redAddImageView.png"]];
    SetupPersonalImageObject *addImage = [[SetupPersonalImageObject alloc] init];
    addImage.isBundleData = YES;
    addImage.isVideoData  = NO;
    addImage.image        = image;
    addImage.isEdit       = NO;
    self.collectionDataContainer = [NSMutableArray array];
    
    [self.collectionDataContainer addObject:addImage];
    self.rootView.downCollectionView.delegate   = self;
    self.rootView.downCollectionView.dataSource = self;
    self.rootView.textArea.delegate             = self;
    [self.rootView.tapGR addTarget:self action:@selector(dismissKeyboardAction:)];
    [self.rootView.downCollectionView registerClass:[TellStoryVideoCell class] forCellWithReuseIdentifier:@"TellStoryVideoCell"];
    [self.rootView.downCollectionView registerClass:[TellStoryPictureCell class]
                         forCellWithReuseIdentifier:@"TellStoryPictureCell"];
    [self.rootView.downCollectionView registerClass:[TellStoryCell class]
                         forCellWithReuseIdentifier:@"TellStoryCell"];
}

#pragma mark    设置右侧发表按钮
- (void)setRightBarButton{
    UIButton *rigtButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rigtButton setTitle:@"发表" forState:UIControlStateNormal];
    [rigtButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rigtButton setTitleColor:RGB(209, 210, 212) forState:UIControlStateDisabled];
    [rigtButton addTarget:self action:@selector(uploadAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigtButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark    上传图片或则视频
- (void)uploadAction:(UIBarButtonItem *)sender{
    [self.rootView.textArea endEditing:NO];
    if (![self isLogined]) {
        return;
    }
    
    if (self.rootView.textArea.text.length == 0 &&
        self.collectionDataContainer.count == 1) {
        return;
    }

    OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:self.view animated:YES];
    [progressHUD showProgressText:@"上传中"];
    NSArray *willUploadImage = [self getWilUploadImages:self.collectionDataContainer];
    WeakSelf;
    //视频与文件
    if (self.willUploadVideoUrl != nil) {
        [[NetworkImageUploader manager] uploadDynamicVideo:self.willUploadVideoUrl withResult:^(BOOL isSuccess, NSString*videoPath) {
            if (isSuccess) {
                [[NetworkImageUploader manager] uploadVideoCoverImage:[ImageCompressTool compressImage:[willUploadImage firstObject]] withResult:^(BOOL isSuccess, NSMutableArray *iconContainer) {
                    if (isSuccess) {
                        [self uploadVideoBlogWithBlog:self.rootView.textArea.text
                                         withAlbumIds:videoPath
                                          withVideoID:[iconContainer firstObject]
                                             withType:1
                                           withResult:^(BOOL isSuccess) {
                                               if (isSuccess) {
                                                   [self uploadSuccessAction];
                                                   [progressHUD showProgressText:@"发表成功"];
                                               }else{
                                                   [progressHUD showProgressText:@"发表失败"];
                                               }
                                               [progressHUD hide:YES afterDelay:1];
                                           }];
                    }else{
                        [progressHUD showProgressText:@"发表失败"];
                        [progressHUD hide:YES afterDelay:1];
                    }
                }];
            }else{
                [progressHUD showProgressText:@"发表失败"];
                [progressHUD hide:YES afterDelay:1];
            }
        }];
        //上传图片
    }else {
        if (self.collectionDataContainer.count <= 1 && self.rootView.textArea.text.length == 0) {
            [self showMessage:@"请添加内容后，发表"];
            return;
        }
        //图文
        if (self.collectionDataContainer.count > 1) {
            //里面有一个➕号图片， 为了删除里面这个图片
            [[NetworkImageUploader manager] uploadDynamicBackgroundImages:[ImageCompressTool compressImage:willUploadImage] withResult:^(BOOL isSuccess, NSMutableArray *iconContainer) {
                if (isSuccess) {
                    NSLog(@"success");
                    NSLog(@"iconContainer%@", iconContainer);
                    //走上传发表文接口
                    [weakSelf uploadImageBlogWithBlog:self.rootView.textArea.text withAlbumIDs:iconContainer withType:0 withResult:^(BOOL isSuccess) {
                        if (isSuccess) {
                            [self uploadSuccessAction];
                            [progressHUD showProgressText:@"发表成功"];
                            
                        }else{
                            [progressHUD showProgressText:@"发表失败"];
                        }
                        [progressHUD hide:YES afterDelay:1];
                    }];
                }else{
                    [progressHUD showProgressText:@"发表失败"];
                    [progressHUD hide:YES afterDelay:1];
                }
            }];
            
        }else{
            //文字
            [weakSelf uploadImageBlogWithBlog:self.rootView.textArea.text withAlbumIDs:nil withType:2 withResult:^(BOOL isSuccess) {
                if (isSuccess) {
                    [self uploadSuccessAction];
                    [progressHUD showProgressText:@"发表成功"];
                }else{
                    [progressHUD showProgressText:@"发表失败"];
                }
                [progressHUD hide:YES afterDelay:1];
            }];
        }
    }
}

#pragma mark    collectionview代理方法
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width  = (ScreenWidth-8*2)/4;
    CGFloat height = width;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionDataContainer.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SetupPersonalImageObject *item = [self.collectionDataContainer objectAtIndex:indexPath.row];
    TellStoryCell *cell = nil;
    if (item.isBundleData) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TellStoryCell" forIndexPath:indexPath];
        cell.indexPath = indexPath;
        cell.delegate  = self;
        [cell setDeleteButtonHidden:YES];
    }else{
        if (item.isVideoData) {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TellStoryVideoCell" forIndexPath:indexPath];
            cell.indexPath = indexPath;
            cell.delegate  = self;
        }else{
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TellStoryPictureCell" forIndexPath:indexPath];
            cell.indexPath = indexPath;
            cell.delegate  = self;
        }
        [cell setDeleteButtonHidden:NO];
    }

    cell.headImageView.image = item.image;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //点击最后一张图片
    if (indexPath.item != self.collectionDataContainer.count-1) {
        SetupPersonalImageObject *object = [self.collectionDataContainer objectAtIndex:indexPath.row];
        if (object.isVideoData) {
            SeedPlayer *seedVC = [[SeedPlayer alloc] init];
            seedVC.movieUrl    = self.willUploadVideoUrl.absoluteString;
            seedVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:seedVC animated:YES completion:nil];
        }else{
            NSRange range;
            range.length   = self.collectionDataContainer.count-1;
            range.location = 0;
            NSArray *showimages = [self.collectionDataContainer subarrayWithRange:range];
            RecordInfoShowImageVC *showImageVC = [[RecordInfoShowImageVC alloc] init];
            showImageVC.localData = showimages;
            showImageVC.currenIndex = indexPath.row;
            showImageVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:showImageVC animated:YES completion:nil];
          }
        return;
    }
    
    //选择图片数量不能超过9张
    if (self.collectionDataContainer.count -1 >= 9) {
        [self showMessage:@"不能超过9张图片"];
        return;
    }
    
    [self showActionSheetAction];
}

#pragma mark    actionsheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self commonActionSheetClickedButtonAtIndex:buttonIndex];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        self.willUploadVideoUrl = nil;
        [self.collectionDataContainer removeObjectAtIndex:0];
        [self commonActionSheetClickedButtonAtIndex:buttonIndex];
    }
}

#pragma mark    调用方法
- (void)commonActionSheetClickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        PhotographViewController *photographVC   = [[PhotographViewController alloc] init];
        photographVC.isPushStyle                 = YES;
        photographVC.isChangeHeadImage           = NO;
        photographVC.viewType                    = CAMERAANDRECORDVIEW;
        [self.navigationController pushViewController:photographVC animated:YES];
    }else if(buttonIndex == 1){
        if (self.willUploadVideoUrl != nil && self.collectionDataContainer.count > 1) {
            [self showGiveUpActionSheet];
        }else{
            AlbumViewController *albumVC             = [[AlbumViewController alloc] init];
            albumVC.isChangeHeadImage                = NO;
            albumVC.isRequireMultibleButton          = YES;
            albumVC.isPushStyle                      = YES;
            [self.navigationController pushViewController:albumVC animated:YES];
        }
    }
}

#pragma mark    删除
- (void)deleteImageWithCell:(TellStoryCell *)cell withIndex:(NSIndexPath *)index{
    [self.collectionDataContainer removeObjectAtIndex:index.row];
    self.willUploadVideoUrl = nil;
    [self.rootView.downCollectionView reloadData];
    if (self.rootView.textArea.text.length == 0 &&
        self.collectionDataContainer.count == 1) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

#pragma mark    刷新页面
- (void)refreshCollectionViewAction:(NSArray *)imageArray withFlag:(BOOL)isVideoFlag{
    self.isVideoFlag = isVideoFlag;
    NSMutableArray *temArray          = [NSMutableArray array];
    NSMutableArray *afterChangeImages = [NSMutableArray array];
    [temArray addObjectsFromArray:self.collectionDataContainer];
    [self.collectionDataContainer removeAllObjects];
    if (self.isVideoFlag) {
        SetupPersonalImageObject *videoImage = [[SetupPersonalImageObject alloc] init];
        videoImage.isVideoData  = YES;
        videoImage.isBundleData = NO;
        videoImage.isImageData  = YES;
        videoImage.image        = [imageArray firstObject];
        videoImage.index        = 0;
        [afterChangeImages addObject:videoImage];
    }else{
        NSInteger i = 0;
        for (UIImage *image in imageArray) {
            SetupPersonalImageObject *picImage = [[SetupPersonalImageObject alloc] init];
            picImage.isVideoData  = NO;
            picImage.isBundleData = NO;
            picImage.isImageData  = YES;
            picImage.image        = image;
            picImage.index        = i;
            [afterChangeImages addObject:picImage];
            i++;
        }
    }
    [self.collectionDataContainer addObjectsFromArray:afterChangeImages];
    
    NSInteger i = 0+afterChangeImages.count;
    for (SetupPersonalImageObject *object in temArray) {
        object.index = i;
        i++;
    }
    [self.collectionDataContainer addObjectsFromArray:temArray];
    temArray = nil;
    
    [self.rootView.downCollectionView reloadData];
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

#pragma mark    代理方法
#pragma mark    防止手势冲突
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [self.rootView addGestureRecognizer:self.rootView.tapGR];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [self.rootView removeGestureRecognizer:self.rootView.tapGR];
    return YES;
}

#pragma mark    键盘隐藏
- (void)dismissKeyboardAction:(UITapGestureRecognizer *)tapGR{
    [self.rootView endEditing:NO];
}

#pragma mark    textview变化
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length != 0 ||
        self.collectionDataContainer.count != 1) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }else{
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

#pragma mark    清空
- (void)clearContainer{
    [self.collectionDataContainer removeAllObjects];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"redAddImageView.png"]];
    SetupPersonalImageObject *addImage = [[SetupPersonalImageObject alloc] init];
    addImage.isBundleData = YES;
    addImage.isVideoData  = NO;
    addImage.image        = image;
    addImage.isEdit       = NO;
    [self.collectionDataContainer addObject:addImage];
    [self.rootView.downCollectionView reloadData];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark    - 网络请求
/*!
 type:
 0:照片，1:视频，2:文字
 */
#pragma mark    上传图片博文
- (void)uploadImageBlogWithBlog:(NSString*)blog
              withAlbumIDs:(id)albumIDs
                  withType:(NSInteger)type
                withResult:(void (^)(BOOL isSuccess))result{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameter setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameter setValue:blog forKey:@"blog"];
    [parameter setValue:[self getParameterAlbumIDString:albumIDs] forKey:@"album_id"];
    [parameter setValue:[NSNumber numberWithInteger:type] forKey:@"type"];
    [self uploadBlogWithParameter:parameter withResult:^(BOOL isSuccess) {
        if (isSuccess) {
            result(YES);
        }else{
            result(NO);
        }
    }];
}

#pragma mark    上传视频博文
- (void)uploadVideoBlogWithBlog:(NSString *)blog
                  withAlbumIds:(id)albumIDs
                    withVideoID:(NSString *)videoID
                       withType:(NSInteger)type
                    withResult:(void (^)(BOOL isSuccess))result{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameter setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameter setValue:blog forKey:@"blog"];
    [parameter setValue:[self getParameterAlbumIDString:albumIDs] forKey:@"album_id"];
    [parameter setValue:[NSNumber numberWithInteger:type] forKey:@"type"];
    [parameter setValue:videoID forKey:@"cover_id"];
    [parameter setValue:[self getParameterAlbumIDString:albumIDs] forKey:@"video_id"];
    [self uploadBlogWithParameter:parameter withResult:^(BOOL isSuccess) {
        if (isSuccess) {
            result(YES);
        }else{
            result(NO);
        }
    }];
}

#pragma mark    发布动态
- (void)uploadBlogWithParameter:(NSDictionary *)parameter
                     withResult:(void (^)(BOOL isSuccess))result{
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_publish_blog"] parameters:parameter success:^(id responseObject) {
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

#pragma mark    获取数组转变字符串参数
- (NSMutableString *)getParameterAlbumIDString:(id)albums{
    if (albums == nil) {
        return nil;
    }
    if ([albums isKindOfClass:[NSString class]]) {
        return albums;
    }
    
    NSMutableString *albumIDString = [NSMutableString string];
    for (int i = 0; i < ((NSArray *)albums).count-1; i++) {
        [albumIDString appendFormat:@"%@,", [albums objectAtIndex:i]];
    }
    [albumIDString appendString:[albums lastObject]];
    return  albumIDString;
}

#pragma mark    获取上传照片
- (NSArray *)getWilUploadImages:(NSMutableArray *)images{
    NSMutableArray *retArray = [NSMutableArray array];
    for (int i = 0; i < self.collectionDataContainer.count -1; i++) {
        SetupPersonalImageObject *objectItem = [images objectAtIndex:i];
        [retArray addObject:objectItem.image];
    }
    return retArray;
}

#pragma mark    展示消息
- (void)showMessage:(NSString *)message{
    OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [progressHUD showText:message];
    [progressHUD hide:YES afterDelay:1];
}

#pragma mark    判断是否登录
- (BOOL)isLogined{
    //    return YES;
    if (![[UserManager manager] isLogined]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.title = @"登录";
        UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:loginNC animated:YES completion:nil];
        return NO;
    }
    return YES;
}

#pragma mark    上传成功
- (void)uploadSuccessAction{
    SetupPersonalImageObject *addObjectImage = [self.collectionDataContainer lastObject];
    [self.collectionDataContainer removeAllObjects];
    [self.collectionDataContainer addObject:addObjectImage];
    self.rootView.textArea.text = nil;
    self.willUploadVideoUrl = nil;
    [self.rootView.downCollectionView reloadData];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [[CacheDataManager sharedInstance] setIsForcedUpdateIndividualDynamic:YES];
    UIViewController *vc = self.navigationController.parentViewController;
    if ([vc isKindOfClass:[MainTabBarViewController class]]) {
        [(MainTabBarViewController *)vc showIndividualController];
    }
}
#pragma mark    展示是否放弃Actionsheet
- (void)showGiveUpActionSheet{
    WeakSelf;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"放弃之前选择上传的照片" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"放弃"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
                                                            weakSelf.willUploadVideoUrl = nil;
                                                            [weakSelf.collectionDataContainer removeObjectAtIndex:0];
                                                            [weakSelf commonActionSheetClickedButtonAtIndex:1];
                                                        }];
    [alertController addAction:albumAction];
    [alertController.view setTintColor:RGB(51, 51, 51)];
    [self presentViewController:alertController animated:YES completion:nil];
    
#else
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"放弃之前选择上传的照片" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"放弃", nil];
    alertView.tag = 200;
    [alertView show];
#endif
}

#pragma mark    展示Actionsheet
- (void)showActionSheetAction{
    WeakSelf;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    
    //拍摄
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍摄"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             //action
                                                             [weakSelf commonActionSheetClickedButtonAtIndex:0];
                                                         }];
    [alertController addAction:cameraAction];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
                                                            //action
                                                            [weakSelf commonActionSheetClickedButtonAtIndex:1];
                                                        }];
    [alertController addAction:albumAction];
    [alertController.view setTintColor:RGB(51, 51, 51)];
    [self presentViewController:alertController animated:YES completion:nil];
    
#else
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍摄",@"相册",nil];
    actionSheet.tag = 100;
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
#endif
}
@end