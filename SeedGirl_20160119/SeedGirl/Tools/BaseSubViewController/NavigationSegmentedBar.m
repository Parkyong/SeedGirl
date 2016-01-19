//
//  NavigationSegmentedBar.m
//  SeedGirl
//
//  Created by Admin on 15/10/16.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "NavigationSegmentedBar.h"
#import "OwnNewMessageImage.h"

@interface NavigationSegmentedBar ()
//视频消息提醒图片
@property (nonatomic, strong) OwnNewMessageImage *newMessageImage;
@end

@implementation NavigationSegmentedBar

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray*)items {
    if (self = [super initWithItems:items]) {
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        self.tintColor = RGB(232, 93, 119);
        self.selectedSegmentIndex = 0;
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             [UIColor whiteColor], NSForegroundColorAttributeName,
                             [UIFont systemFontOfSize:18.0f], NSFontAttributeName,
                             nil];
        [self setTitleTextAttributes:dic forState:UIControlStateNormal];
        [self setTitleTextAttributes:dic forState:UIControlStateSelected];
        [self addTarget:self action:@selector(segementedControlSelected:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:self.newMessageImage];
        [self.newMessageImage setHidden:YES];
        
        NSString *str = [items objectAtIndex:1];
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:18.0f]
                            WithMaxSize:CGSizeMake(frame.size.width/2, frame.size.height)
                        ByLineBreakMode:NSLineBreakByTruncatingTail];
        CGFloat x = frame.size.width*0.75f + size.width/2+1.0f;
        [self.newMessageImage setFrame:CGRectMake(x, 1.0f, 6.0f, 6.0f)];
        self.newMessageImage.layer.cornerRadius = 3.0f;
    }
    return self;
}

//是否显示新消息提醒
- (void)showNewMessage:(BOOL)status {
    [self.newMessageImage setHidden:!status];
}

- (void)segementedControlSelected:(UISegmentedControl *)control {
    if (self.selectedBlock) {
        self.selectedBlock(control.selectedSegmentIndex);
    }
}

#pragma mark - lazyload
//纸条消息提醒图片
- (OwnNewMessageImage *)newMessageImage {
    if (_newMessageImage == nil) {
        _newMessageImage = [[OwnNewMessageImage alloc] init];
    }
    return _newMessageImage;
}

@end
