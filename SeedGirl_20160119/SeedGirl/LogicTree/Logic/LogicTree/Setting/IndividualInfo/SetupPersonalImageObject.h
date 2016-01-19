//
//  SetupPersonalImageObject.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/18.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetupPersonalImageObject : NSObject
@property (nonatomic, copy) NSString    *imagePath;
@property (nonatomic, copy) NSString          *pid;
@property (nonatomic, assign) NSInteger      index;
@property (nonatomic, strong) UIImage       *image;
@property (nonatomic, assign) BOOL    isBundleData;
@property (nonatomic, assign) BOOL     isVideoData;
@property (nonatomic, assign) BOOL     isImageData;
@property (nonatomic, assign) BOOL          isEdit;
- (instancetype)init;
@end