//
//  RecordInfoShowImageVC.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/9.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "RecordInfoShowImageVC.h"

@interface RecordInfoShowImageVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIPageControl    *pageControl;
@end

@implementation RecordInfoShowImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.mainScrollView];

    
    
    for (int i = 0; i < self.localData.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i *SCREEN_WIDTH, 0, SCREEN_WIDTH, ScreenHeight)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenHeight)];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.tag = 500+i;
        view.backgroundColor = [UIColor clearColor];
        [view addSubview:imageView];
        [self.mainScrollView addSubview:view];
    }
    [self showImage:self.currenIndex];
}

#pragma mark    代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/ScreenWidth;
    self.pageControl.currentPage = index;
    [self showImage:index];
}

#pragma mark    观看图片
- (void)showImage:(NSInteger)index{
    UIImageView *imageView = (UIImageView *)[self.mainScrollView viewWithTag:500+index];
    CGPoint point = self.mainScrollView.contentOffset;
    self.mainScrollView.contentOffset = CGPointMake(ScreenWidth *index, point.y);
    SetupPersonalImageObject *data = [self.localData objectAtIndex:index];
    if (data.isImageData) {
        imageView.image = data.image;
    }else{
        [imageView sd_setImageWithURL:[NSURL URLWithString:data.imagePath]];
    }
    if (imageView.image == nil) {
        return;
    }
    CGFloat scale    = ScreenWidth/imageView.image.size.width;
    imageView.frame  = CGRectMake(0, 0, ScreenWidth, imageView.image.size.height *scale);
    imageView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIScrollView *)mainScrollView{
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator   = NO;
        _mainScrollView.bounces                        = NO;
        _mainScrollView.pagingEnabled                  = YES;
        _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH *self.localData.count, 0);
        _mainScrollView.delegate                       = self;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissAction)];
        [_mainScrollView addGestureRecognizer:tapGR];
    }
    return _mainScrollView;
}

- (UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, ScreenHeight-60, SCREEN_WIDTH, 60)];
        _pageControl.numberOfPages = self.localData.count;
        _pageControl.currentPage   = self.currenIndex;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor        = [UIColor grayColor];
    }
    return _pageControl;
}


- (void)dissmissAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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
