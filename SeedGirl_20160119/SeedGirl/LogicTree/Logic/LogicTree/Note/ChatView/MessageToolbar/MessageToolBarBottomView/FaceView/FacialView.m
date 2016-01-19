/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "FacialView.h"
#import "Emoji.h"

@interface FacialView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView  *mainScrollView;
@property (nonatomic, strong) UIView       *bottomContainer;
@property (nonatomic, strong) UIPageControl    *pageControl;
@property (nonatomic, strong) UIButton          *sendButton;
@end

@implementation FacialView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _faces = [Emoji allEmoji];
        [self addViews];
    }
    return self;
}
//添加试图
- (void)addViews{
    [self addSubview:self.mainScrollView];
    [self addSubview:self.bottomContainer];
    [self.bottomContainer addSubview:self.pageControl];
    [self.bottomContainer addSubview:self.sendButton];
}


//给faces设置位置
-(void)loadFacialView:(int)page size:(CGSize)size{
    int maxRow = 3;
    int maxCol = 7;
    CGFloat itemWidth = self.frame.size.width / maxCol;
    CGFloat itemHeight = (self.frame.size.height - CGRectGetHeight(self.bottomContainer.frame))/ maxRow;
    int index = 0;
    int pageIndex  = 0;
    do{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(pageIndex *self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        view.backgroundColor = [UIColor whiteColor];
        view.tag = 300+pageIndex;
        [self.mainScrollView addSubview:view];
        
        
        for (int row = 0; row < maxRow; row++) {
            for (int col = 0; col < maxCol; col++) {
                if (index < [_faces count]) {
                    if (row * maxCol + col == 20) {
                        break;
                    }
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    [button setBackgroundColor:[UIColor clearColor]];
                    [button setFrame:CGRectMake(col * itemWidth, row * itemHeight, itemWidth, itemHeight)];
                    [button.titleLabel setFont:[UIFont fontWithName:@"AppleColorEmoji" size:29.0]];
                    [button setTitle: [_faces objectAtIndex:(index)] forState:UIControlStateNormal];
                    NSLog(@"%@", button.titleLabel.text);
                    button.tag = index;
                    [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
                    [view addSubview:button];
                    index++;
                    
                }
                else{
                    break;
                }
            }
        }
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton setBackgroundColor:[UIColor clearColor]];
        [deleteButton setFrame:CGRectMake((maxCol - 1) * itemWidth, (maxRow - 1) * itemHeight, itemWidth, itemHeight)];
        [deleteButton setImage:[UIImage imageNamed:@"faceDelete"] forState:UIControlStateNormal];
        deleteButton.tag = 10000;
        [deleteButton addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:deleteButton];
        pageIndex++;
    }while (index < [_faces count]);
}


- (void)selected:(UIButton*)bt
{
    if (bt.tag == 10000 && _delegate) {
        [_delegate deleteSelected:nil];
    }else{
        NSString *str = [_faces objectAtIndex:bt.tag];
        if (_delegate) {
            [_delegate selectedFacialView:str];
        }
    }
}

- (void)sendAction:(id)sender
{
    if (_delegate) {
        [_delegate sendFace];
    }
}

#pragma mark    懒加载对象
- (UIScrollView *)mainScrollView{
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-30)];
        NSInteger index = _faces.count/20==0?_faces.count/20:_faces.count/20+1;
        _mainScrollView.contentSize = CGSizeMake(self.frame.size.width*index, 0);
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces       = NO;
        _mainScrollView.delegate      = self;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator   = NO;
    }
    return _mainScrollView;
}

- (UIView *)bottomContainer{
    if (_bottomContainer == nil) {
        _bottomContainer = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mainScrollView.frame), self.frame.size.width, 30)];
        _bottomContainer.backgroundColor = [UIColor clearColor];
    }
    return _bottomContainer;
}

- (UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,
                                                                       (self.bottomContainer.frame.size.height -20)/2, self.frame.size.width, 20)];
        _pageControl.numberOfPages          = ([_faces count]%20==0)?[_faces count]/20:[_faces count]/20+1;
        _pageControl.currentPage            = 0;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
        //        [_pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventValueChanged];
        _pageControl.backgroundColor = [UIColor clearColor];
    }
    return _pageControl;
}

- (UIButton *)sendButton{
    if (_sendButton == nil) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        int maxCol = 7;
        CGFloat itemWidth = self.frame.size.width / maxCol;
        CGFloat itemHeight = CGRectGetHeight(self.bottomContainer.frame);
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setFrame:CGRectMake(self.frame.size.width - (itemWidth + 10),
                                         03, itemWidth + 10, itemHeight)];
        [_sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sendButton setBackgroundColor:RGB(255, 122, 147)];
    }
    return _sendButton;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/self.frame.size.width;
    NSLog(@"index%ld",index);
    self.pageControl.currentPage = index;
}
@end
