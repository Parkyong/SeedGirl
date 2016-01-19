//
//  TellStoryView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/17.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TellStoryView : UIView
@property (nonatomic, strong) UICollectionView *downCollectionView;
@property (nonatomic, strong) UITextView                 *textArea;
@property (nonatomic, strong) UITapGestureRecognizer        *tapGR;
@end
