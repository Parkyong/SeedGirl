//
//  TagView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/29.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RemoveTagBlockType) (NSInteger);
@interface TagView : UIView
@property (nonatomic, strong) NSMutableDictionary *selectedTagsDict;
@property (nonatomic, copy)   RemoveTagBlockType removeTagBlock;
- (void)addTagsAction:(NSString *)tagTitle;
@end
