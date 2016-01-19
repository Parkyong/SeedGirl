//
//  AlbumData.h
//  SeedGirl
//
//  Created by ParkHunter on 15/12/21.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface AlbumData : NSObject
@property (nonatomic, strong) ALAsset  *assetItem;
@property (nonatomic, assign) BOOL     isSelected;
@end
