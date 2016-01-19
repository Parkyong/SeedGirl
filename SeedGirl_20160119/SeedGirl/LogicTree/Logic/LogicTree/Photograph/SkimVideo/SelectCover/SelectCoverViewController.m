//
//  SelectCoverViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/16.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SelectCoverViewController.h"
#import "SelectCoverView.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>

@interface SelectCoverViewController ()
@property (nonatomic, strong) SelectCoverView *rootView;
@property (nonatomic, strong) NSMutableArray    *images;
@end

@implementation SelectCoverViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)loadView{
    self.rootView = [[SelectCoverView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view     = self.rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addFunction];
    
    self.images = [NSMutableArray array];
//    NSLog(@"%f", self.videoDuration);
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:self.videoURL options:nil];
    Float64 durationSeconds = CMTimeGetSeconds([asset duration]);

    for (int i = 0; i < 12; i++) {
        NSTimeInterval time = durationSeconds/12 *i;
        UIImage *image = [self thumbnailImageForVideo:self.videoURL atTime:time];
        [self.images addObject:image];
    }
    [self.rootView setShowImage:[self.images objectAtIndex:0]];
    [self.rootView setCoverScrollViewWithImages:self.images];
}

- (void)addFunction{
    [self.rootView.returnButton addTarget:self
                                   action:@selector(returnButtonAction:)
                         forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark    return
- (void)returnButtonAction:(UIButton *)sender{
    if (self.localBlock != nil) {
        self.localBlock(self.rootView.coverImage);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark    方法
#pragma mark    获取帧
- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    asset = nil;
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode =AVAssetImageGeneratorApertureModeEncodedPixels;
    assetImageGenerator.requestedTimeToleranceBefore   = kCMTimeZero;
    assetImageGenerator.requestedTimeToleranceAfter    = kCMTimeZero;

    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMakeWithSeconds(thumbnailImageTime,30)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage:thumbnailImageRef]  : nil;
    
    return thumbnailImage;
}

#pragma mark    viewDidAppear
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

#pragma mark    隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
