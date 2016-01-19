//
//  SetupPersonalInfoView.m
//  SeedGirl
//
//  Created by ParkHunter on 16/1/4.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "SetupPersonalInfoView.h"
#import "SetupBasicInfoView.h"
#import "SetupBasicSignInfoView.h"
#import "SetupPersonalImageCell.h"

#import "SetupPersonalImageObject.h"
#import "UserManager.h"
#import "UserData.h"
#import "SeedTagData.h"
#import "PersonalInfoCellDelegate.h"

#import "AgePickerView.h"
#import "HeigthPicker.h"
#import "LocationPickerView.h"
@interface UIImageView (SetupPersonalImageCell)

- (void)setCellCopiedImage:(UICollectionViewCell *)cell;

@end

@implementation UIImageView (SetupPersonalImageCell)

- (void)setCellCopiedImage:(UICollectionViewCell *)cell {
    UIGraphicsBeginImageContextWithOptions(cell.bounds.size, NO, 4.f);
    [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = image;
}
@end


@interface SetupPersonalInfoView () <UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UIGestureRecognizerDelegate,
UIActionSheetDelegate,
SetupPersonalImageCellProtocol,
PersonalInfoCellDelegate,
AgePickerViewProtocol,
HeigthPickerViewProtocol,
LocationPickerViewProtocol>
//背景图片
@property (nonatomic, strong) UIImageView     *backgroundImgView;

//scrollView
@property (nonatomic, strong) UIScrollView       *backScrollView;

//阴影
@property (nonatomic, strong) UIView                 *shadowView;

//头像部分
@property (nonatomic, strong) UIView              *headContainer;
@property (nonatomic, strong) UIView       *headUpBackgroundView;
@property (nonatomic, strong) UIView    *subHeadUpBackgroundView;
@property (nonatomic, strong) UIImageView         *headImageView;
@property (nonatomic, strong) UIView       *headUpBackgroundline;

//标签部分
@property (nonatomic, strong) UIView               *tagContainer;
@property (nonatomic, strong) UIButton                     *tag1;
@property (nonatomic, strong) UIButton                     *tag2;
@property (nonatomic, strong) UIButton                     *tag3;


//相册部分
@property (nonatomic, strong) UIView             *albumContainer;
@property (nonatomic, strong) UICollectionView        *albumView;

//基本资料字
@property (nonatomic, strong) UIView         *basicInfoContainer;
@property (nonatomic, strong) UILabel                *titleLabel;
@property (nonatomic, strong) SetupBasicInfoView       *nameView;
@property (nonatomic, strong) SetupBasicInfoView        *ageView;
@property (nonatomic, strong) SetupBasicInfoView     *heightView;
@property (nonatomic, strong) SetupBasicInfoView      *hobbyView;
@property (nonatomic, strong) SetupBasicInfoView       *cityView;
@property (nonatomic, strong) SetupBasicInfoView *professionView;
@property (nonatomic, strong) SetupBasicSignInfoView   *signView;

//commondHeight
@property (nonatomic, assign) CGFloat                       commonHeigth;

//手势
@property (nonatomic, strong) UIPanGestureRecognizer              *panGR;
@property (nonatomic, strong) UILongPressGestureRecognizer  *longPressGR;

//数据
@property (nonatomic, strong) NSMutableArray           *tagDataContainer;
@property (nonatomic, strong) NSMutableArray       *willUpLoadImageArray;

//暂存数据
@property (nonatomic, strong) SetupPersonalImageObject       *basicImage;

//移动相册用的
@property (nonatomic, strong) NSIndexPath       *reorderingCellIndexPath;
@property (nonatomic, assign) CGPoint                 cellFakeViewCenter;
@property (nonatomic, assign) CGPoint                     panTranslation;
@property (nonatomic, strong) UIView                       *cellFakeView;

//actionsheet
@property (nonatomic, strong) UIActionSheet                   *sheetView;

//temp
@property (nonatomic, assign) NSInteger                        tempIndex;

//pickerview
@property (nonatomic, strong) AgePickerView                    *agePicker;
@property (nonatomic, strong) HeigthPicker                  *heigthPicker;
@property (nonatomic, strong) LocationPickerView          *locationPicker;

@end
@implementation SetupPersonalInfoView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self addLimits];
        [self setParameters];
        [self setData];
    }
    return self;
}

#pragma mark    添加试图
- (void)addViews{
    //背景图片
    [self addSubview:self.backgroundImgView];
    
    //阴影图片
    [self.backgroundImgView addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.shadowView];
    
    //头像部分
    [self.shadowView addSubview:self.headContainer];
    [self.headContainer addSubview:self.headUpBackgroundView];
    [self.headUpBackgroundView addSubview:self.subHeadUpBackgroundView];
//    [self.subHeadUpBackgroundView addSubview:self.headUpBackgroundline];
    [self.headContainer addSubview:self.headImageView];
    
    //标签部分
    [self.shadowView addSubview:self.tagContainer];
    
    //相册部分
    [self.shadowView addSubview:self.albumContainer];
    [self.albumContainer addSubview:self.albumView];
    
    //基本资料
    [self.shadowView addSubview:self.basicInfoContainer];
    [self.basicInfoContainer addSubview:self.titleLabel];
    [self.basicInfoContainer addSubview:self.nameView];
    [self.basicInfoContainer addSubview:self.ageView];
    [self.basicInfoContainer addSubview:self.heightView];
    [self.basicInfoContainer addSubview:self.hobbyView];
    [self.basicInfoContainer addSubview:self.cityView];
    [self.basicInfoContainer addSubview:self.professionView];
    [self.basicInfoContainer addSubview:self.signView];
}

- (void)addLimits{
    WeakSelf;
    self.commonHeigth = [Adaptor returnAdaptorValue:106] +
    [Adaptor returnAdaptorValue:18] +
    9 +
    [Adaptor returnAdaptorValue:20] +
    18 +
    [Adaptor returnAdaptorValue:36] * 12;
    
    CGFloat heigth = self.commonHeigth + (ScreenWidth-8*2)/4+8*2;
    self.shadowView.frame = CGRectMake(0, 0, SCREEN_WIDTH, heigth);
    self.backScrollView.contentSize = CGSizeMake(0, heigth);
    
    
    //头像部分
    [self.headContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.shadowView.mas_top).with.offset(BarHeigthYULEI);
        make.left.equalTo(weakSelf.shadowView.mas_left);
        make.right.equalTo(weakSelf.shadowView.mas_right);
        make.height.equalTo([NSNumber numberWithFloat:[Adaptor returnAdaptorValue:106]]);
    }];
    
    [self.headUpBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headContainer.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo([NSNumber numberWithFloat:[Adaptor returnAdaptorValue:106/2]]);
    }];
    [self.subHeadUpBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headUpBackgroundView.mas_top);
        make.left.equalTo(weakSelf.headUpBackgroundView.mas_left);
        make.bottom.equalTo(weakSelf.headUpBackgroundView.mas_bottom);
        make.right.equalTo(weakSelf.headUpBackgroundView.mas_right);
    }];
    
//    [self.headUpBackgroundline mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.subHeadUpBackgroundView.mas_left);
//        make.right.equalTo(weakSelf.subHeadUpBackgroundView.mas_right);
//        make.top.equalTo(weakSelf.subHeadUpBackgroundView.mas_top);
//        make.height.equalTo(@1);
//    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:88], [Adaptor returnAdaptorValue:88]));
        make.center.equalTo(weakSelf.headContainer);
    }];
    
    //标签部分
    [self.tagContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(88);
        make.right.equalTo(weakSelf.mas_right).with.offset(-88);
        make.top.equalTo(weakSelf.headContainer.mas_bottom);
        make.height.mas_equalTo([Adaptor returnAdaptorValue:18]);
    }];
//        self.tagContainer.backgroundColor = [UIColor redColor];
    
    //相册部分
    [self.albumContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.tagContainer.mas_bottom).with.offset(9);
        make.height.equalTo(@((ScreenWidth-8*2)/4+8*2));
    }];
    
    [self.albumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.albumContainer.mas_left);
        make.right.equalTo(weakSelf.albumContainer.mas_right);
        make.top.equalTo(weakSelf.albumContainer.mas_top);
        make.bottom.equalTo(weakSelf.albumContainer.mas_bottom);
    }];
    //    self.albumContainer.backgroundColor = [UIColor blueColor];
    //基本资料
    [self.basicInfoContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.albumContainer.mas_bottom);
        make.left.equalTo(weakSelf.shadowView.mas_left);
        make.bottom.equalTo(weakSelf.shadowView.mas_bottom);
        make.right.equalTo(weakSelf.shadowView.mas_right);
    }];
    
    //基本信息字样
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.basicInfoContainer.mas_top);
        make.left.equalTo(weakSelf.basicInfoContainer.mas_left).with.offset(8);
        make.right.equalTo(weakSelf.basicInfoContainer.mas_right).with.offset(-8);
        make.height.equalTo([NSNumber numberWithFloat:[Adaptor returnAdaptorValue:20]]);
    }];
    
    //姓名
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf.basicInfoContainer.mas_left);
        make.right.equalTo(weakSelf.basicInfoContainer.mas_right);
        make.height.mas_equalTo([Adaptor returnAdaptorValue:36]);
    }];
    
    //年龄
    [self.ageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameView.mas_bottom);
        make.left.equalTo(weakSelf.basicInfoContainer.mas_left);
        make.right.equalTo(weakSelf.basicInfoContainer.mas_right);
        make.height.equalTo(weakSelf.nameView.mas_height);
    }];
    
    //身高
    [self.heightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.ageView.mas_bottom);
        make.left.equalTo(weakSelf.basicInfoContainer.mas_left);
        make.right.equalTo(weakSelf.basicInfoContainer.mas_right);
        make.height.equalTo(weakSelf.nameView.mas_height);
    }];
    
    //爱好
    [self.hobbyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.heightView.mas_bottom);
        make.left.equalTo(weakSelf.basicInfoContainer.mas_left);
        make.right.equalTo(weakSelf.basicInfoContainer.mas_right);
        make.height.equalTo(weakSelf.nameView.mas_height);
    }];
    
    //城市
    [self.cityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.hobbyView.mas_bottom);
        make.left.equalTo(weakSelf.basicInfoContainer.mas_left);
        make.right.equalTo(weakSelf.basicInfoContainer.mas_right);
        make.height.equalTo(weakSelf.nameView.mas_height);
    }];
    
    //    self.cityView.backgroundColor = [UIColor redColor];
    //职业
    [self.professionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.cityView.mas_bottom);
        make.left.equalTo(weakSelf.basicInfoContainer.mas_left);
        make.right.equalTo(weakSelf.basicInfoContainer.mas_right);
        make.height.equalTo(weakSelf.nameView.mas_height);
    }];
    //    self.basicInfoContainer.backgroundColor = [UIColor yellowColor];
    
    //个性签名
    [self.signView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.professionView.mas_bottom);
        make.left.equalTo(weakSelf.basicInfoContainer.mas_left);
        make.bottom.equalTo(weakSelf.basicInfoContainer.mas_bottom);
        make.right.equalTo(weakSelf.basicInfoContainer.mas_right);
    }];
}

#pragma mark    -
#pragma mark    设置参数
- (void)setParameters{
    self.albumView.delegate   = self;
    self.albumView.dataSource = self;
    self.longPressGR.delegate = self;
    self.panGR.delegate       = self;
    self.isShaking            = NO;
    self.tempIndex            = -1;
    self.collectionImageArray = [NSMutableArray array];
    self.willUpLoadImageArray = [NSMutableArray array];
    self.tagDataContainer     = [NSMutableArray array];
    [self.albumView addGestureRecognizer:self.panGR];
    [self.albumView addGestureRecognizer:self.longPressGR];

    self.basicImage = [[SetupPersonalImageObject alloc] init];
    self.basicImage.isBundleData = YES;
    self.basicImage.isImageData  = YES;
    self.basicImage.isEdit       = NO;
    self.basicImage.image        = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"addHeadImageButton.png"]];
    
    [self.albumView registerClass:[SetupPersonalImageCell class]
       forCellWithReuseIdentifier:@"SetupPersonalImageCell"];
}

#pragma mark    添加观察者
- (void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)removeObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark    －
#pragma mark    懒加载对象
#pragma mark    － 背景图片
- (UIImageView *)backgroundImgView{
    if (_backgroundImgView == nil) {
        _backgroundImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+162)];
//        _backgroundImgView.image = [UIImage imageNamed:@"1.jpg"];
        _backgroundImgView.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundImgView.userInteractionEnabled = YES;
        _backgroundImgView.autoresizesSubviews    = NO;
    }
    return _backgroundImgView;
}

#pragma mark    - scrollView
- (UIScrollView *)backScrollView{
    if (_backScrollView == nil) {
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backScrollView.showsHorizontalScrollIndicator = NO;
        _backScrollView.showsVerticalScrollIndicator   = NO;
        _backScrollView.scrollEnabled                  = YES;
        _backScrollView.userInteractionEnabled         = YES;
        _backScrollView.bounces                        = NO;
    }
    return _backScrollView;
}

#pragma mark    - 阴影图片
- (UIView *)shadowView{
    if (_shadowView == nil) {
        _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _shadowView.backgroundColor =  RGBA(0, 0, 0, 0.2);
    }
    return _shadowView;
}

#pragma mark    - 头像部分
- (UIView *)headContainer{
    if (_headContainer == nil) {
        _headContainer = [[UIView alloc] init];
        [_headContainer addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stopHeaderImageViewShakeAction)]];
    }
    return _headContainer;
}

- (UIView *)headUpBackgroundView{
    if (_headUpBackgroundView == nil) {
        _headUpBackgroundView = [[UIView alloc] init];
        _headUpBackgroundView.backgroundColor = [UIColor clearColor];
    }
    return _headUpBackgroundView;
}

- (UIView *)subHeadUpBackgroundView{
    if (_subHeadUpBackgroundView == nil) {
        _subHeadUpBackgroundView = [[UIView alloc] init];
        _subHeadUpBackgroundView.backgroundColor = RGBA(232,93,119,0.85);
//        _subHeadUpBackgroundView.backgroundColor = [UIColor redColor];
    }
    return _subHeadUpBackgroundView;

}

- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.cornerRadius = [Adaptor returnAdaptorValue:88]/2;
        _headImageView.userInteractionEnabled = YES;
        [_headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeHeadeImage:)]];
        _headImageView.layer.borderWidth  = 2;
        _headImageView.layer.borderColor  = RGB(132, 107, 104).CGColor;
        _headImageView.clipsToBounds      = YES;
    }
    return _headImageView;
}

- (UIView *)headUpBackgroundline{
    if (_headUpBackgroundline == nil) {
        _headUpBackgroundline = [[UIView alloc] init];
        _headUpBackgroundline.backgroundColor = RGBA(255, 255, 255, 0.4);
    }
    return _headUpBackgroundline;
}

#pragma mark    - 标签部分
- (UIView *)tagContainer{
    if (_tagContainer == nil) {
        _tagContainer = [[UIView alloc] init];
    }
    return _tagContainer;
}

#pragma mark    - 相册部分
- (UIView *)albumContainer{
    if (_albumContainer == nil) {
        _albumContainer = [[UIView alloc] init];
        _albumContainer.backgroundColor = [UIColor clearColor];
    }
    return _albumContainer;
}

- (UICollectionView *)albumView{
    if (_albumView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _albumView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _albumView.showsHorizontalScrollIndicator = YES;
        _albumView.showsVerticalScrollIndicator   = YES;
        _albumView.scrollEnabled                  = NO;
        _albumView.backgroundColor = [UIColor clearColor];
    }
    return _albumView;
}

#pragma mark    － 基本资料
- (UIView *)basicInfoContainer{
    if (_basicInfoContainer == nil) {
        _basicInfoContainer = [[UIView alloc] init];
    }
    return _basicInfoContainer;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"基本信息";
    }
    return _titleLabel;
}

//姓名
- (SetupBasicInfoView *)nameView{
    if (_nameView == nil) {
        _nameView = [[SetupBasicInfoView alloc] initWithFrame:CGRectZero];
        _nameView.name = @"姓名";
        _nameView.index = 0;
        _nameView.delegate = self;
        _nameView.isShowKeyboard = YES;
    }
    return _nameView;
}

//年龄
- (SetupBasicInfoView *)ageView{
    if (_ageView == nil) {
        _ageView = [[SetupBasicInfoView alloc] initWithFrame:CGRectZero];
        _ageView.name = @"年龄";
        _ageView.index = 1;
        _ageView.delegate = self;
        _ageView.isShowKeyboard = NO;
    }
    return _ageView;
}

//身高
- (SetupBasicInfoView *)heightView{
    if (_heightView == nil) {
        _heightView = [[SetupBasicInfoView alloc] initWithFrame:CGRectZero];
        _heightView.name = @"身高";
        _heightView.index = 2;
        _heightView.delegate = self;
        _heightView.isShowKeyboard = NO;
    }
    return _heightView;
}

//爱好
- (SetupBasicInfoView *)hobbyView{
    if (_hobbyView == nil) {
        _hobbyView = [[SetupBasicInfoView alloc] initWithFrame:CGRectZero];
        _hobbyView.name = @"爱好";
        _hobbyView.index = 3;
        _hobbyView.delegate = self;
        _hobbyView.isShowKeyboard = YES;
    }
    return _hobbyView;
}

//城市
- (SetupBasicInfoView *)cityView{
    if (_cityView == nil) {
        _cityView = [[SetupBasicInfoView alloc] initWithFrame:CGRectZero];
        _cityView.name = @"城市";
        _cityView.index = 4;
        _cityView.delegate = self;
        _cityView.isShowKeyboard = NO;
    }
    return _cityView;
}

//职业
- (SetupBasicInfoView *)professionView{
    if (_professionView == nil) {
        _professionView = [[SetupBasicInfoView alloc] initWithFrame:CGRectZero];
        _professionView.name = @"职业";
        _professionView.index = 5;
        _professionView.delegate = self;
        _professionView.isShowKeyboard = YES;
    }
    return _professionView;
}

//个性签名
- (SetupBasicSignInfoView *)signView{
    if (_signView == nil) {
        CGFloat heigth = [Adaptor returnAdaptorValue:36] * 4;
        _signView = [[SetupBasicSignInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, heigth)];
        _signView.name = @"个性签名";
        _signView.index = 6;
        _signView.delegate = self;
        _signView.isShowKeyboard = YES;
    }
    return _signView;
}

//手势
- (UIPanGestureRecognizer *)panGR{
    if (_panGR == nil) {
        _panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                         action:@selector(panGRAction:)];
    }
    return _panGR;
}

- (UILongPressGestureRecognizer *)longPressGR{
    if (_longPressGR == nil) {
        _longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                     action:@selector(longPressAction:)];
    }
    return _longPressGR;
}

- (UIActionSheet *)sheetView{
    if (_sheetView == nil) {
        _sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    }
    return _sheetView;
}

#pragma mark    pickerview
#pragma mark    年龄选择器
- (AgePickerView *)agePicker{
    if (_agePicker == nil) {
        _agePicker = [[AgePickerView alloc] init];
        _agePicker.frame = CGRectMake(0,
                                      SCREEN_HEIGHT,
                                      SCREEN_WIDTH,
                                      162);
        //        NSLog(@"agePicker%f", _agePicker.frame.size.height);
        _agePicker.delegate = self;
        _agePicker.backgroundColor = RGB(240,242,245);
    }
    return _agePicker;
}

#pragma mark    身高选择器
- (HeigthPicker *)heigthPicker{
    if (_heigthPicker == nil) {
        _heigthPicker = [[HeigthPicker alloc] init];
        _heigthPicker.frame = CGRectMake(0,
                                         SCREEN_HEIGHT,
                                         SCREEN_WIDTH, 162);
        _heigthPicker.viewDelegate = self;
        _heigthPicker.backgroundColor =  RGB(240,242,245);
    }
    return _heigthPicker;
}

#pragma mark    地理位置选择器
- (LocationPickerView *)locationPicker{
    if (_locationPicker == nil) {
        _locationPicker = [[LocationPickerView alloc] init];
        _locationPicker.frame = CGRectMake(0,
                                           SCREEN_HEIGHT,
                                           SCREEN_WIDTH, 162);
        _locationPicker.viewDelegate = self;
        _locationPicker.backgroundColor =  RGB(240,242,245);
    }
    return _locationPicker;
}

- (UIButton *)tag1{
    if (_tag1 == nil) {
        _tag1 = [[UIButton alloc] init];
        [_tag1 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"tagBackground.png"]] forState:UIControlStateNormal];
        [_tag1 addTarget:self action:@selector(tagButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_tag1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _tag1.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _tag1.layer.cornerRadius = 3;
        _tag1.tag = 1;
    }
    return _tag1;
}

- (UIButton *)tag2{
    if (_tag2 == nil) {
        _tag2 = [[UIButton alloc] init];
        [_tag2 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"tagBackground.png"]] forState:UIControlStateNormal];
        [_tag2 addTarget:self action:@selector(tagButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_tag2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _tag2.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _tag2.layer.cornerRadius = 3;
        _tag2.tag = 2;
    }
    return _tag2;
}

- (UIButton *)tag3{
    if (_tag3 == nil) {
        _tag3 = [[UIButton alloc] init];
        [_tag3 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"tagBackground.png"]] forState:UIControlStateNormal];
        [_tag3 addTarget:self action:@selector(tagButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_tag3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _tag3.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _tag3.layer.cornerRadius = 3;
        _tag3.tag = 1;
    }
    return _tag3;
}


#pragma mark    -代理方法
#pragma mark    代理
#pragma mark    collection Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionImageArray.count;
}

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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SetupPersonalImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SetupPersonalImageCell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate  = self;
    SetupPersonalImageObject *cellData = [self.collectionImageArray objectAtIndex:indexPath.row];
    if (cellData.isImageData) {
        cell.headImageView.image = cellData.image;
    }else{
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:cellData.imagePath] placeholderImage:[UIImage imageNamed:@"icon_girl.png"]];
    }
    
    cell.isEdit = cellData.isEdit;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
       itemAtIndexPath:(NSIndexPath *)fromIndexPath
    didMoveToIndexPath:(NSIndexPath *)toIndexPath{
    SetupPersonalImageObject *fromData = [self.collectionImageArray objectAtIndex:fromIndexPath.item];
    [self.collectionImageArray removeObjectAtIndex:fromIndexPath.item];
    [self.collectionImageArray insertObject:fromData atIndex:toIndexPath.item];
    for (int i = 0; i < self.collectionImageArray.count-1; i++) {
        SetupPersonalImageObject *data = [self.collectionImageArray objectAtIndex:i];
        data.index = i;
    }
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.hidden = NO;
    [self.albumView reloadData];
}

- (BOOL)collectionView:(UICollectionView *)collectionView
       itemAtIndexPath:(NSIndexPath *)fromIndexPath
    canMoveToIndexPath:(NSIndexPath *)toIndexPath{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)setupPersonalImageCellTapAction:(SetupPersonalImageCell *)cell withIndex:(NSIndexPath *)indexPath{
//    SetupPersonalImageObject *data = [self.collectionImageArray objectAtIndex:indexPath.row];
//    if (data.isBundleData) {
//        [self stopHeaderImageViewShakeAction];
//        self.sheetView.tag = 500;
//        [self.sheetView showInView:[[UIApplication sharedApplication] keyWindow]];
//    }else{
//        NSMutableArray *imageContainer = [NSMutableArray array];
//        [imageContainer addObjectsFromArray:self.collectionImageArray];
//        [imageContainer removeLastObject];
//        if (self.pushToShowImageControllerBlock != nil) {
//            self.pushToShowImageControllerBlock(indexPath, imageContainer);
//        }
//    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SetupPersonalImageObject *data = [self.collectionImageArray objectAtIndex:indexPath.row];
    if (data.isBundleData) {
        [self stopHeaderImageViewShakeAction];
        self.sheetView.tag = 500;
        [self.sheetView showInView:[[UIApplication sharedApplication] keyWindow]];
    }else{
        NSMutableArray *imageContainer = [NSMutableArray array];
        [imageContainer addObjectsFromArray:self.collectionImageArray];
        [imageContainer removeLastObject];
        if (self.pushToShowImageControllerBlock != nil) {
            self.pushToShowImageControllerBlock(indexPath, imageContainer);
        }
    }
}

#pragma mark    长按
- (void)longPressAction:(UILongPressGestureRecognizer *)longGR{
    [self startHeaderImageViewShakeAction];
    switch (longGR.state) {
        case UIGestureRecognizerStateBegan: {
            NSIndexPath *indexPath = [self.albumView indexPathForItemAtPoint:[longGR locationInView:self.albumView]];
            if ([self respondsToSelector:@selector(collectionView:canMoveItemAtIndexPath:)]) {
                if (![self collectionView:self.albumView canMoveItemAtIndexPath:indexPath]) {
                    return;
                }
            }
            UICollectionViewCell *cell = [self.albumView cellForItemAtIndexPath:indexPath];
            _cellFakeView = [[UIView alloc] initWithFrame:cell.frame];
            _cellFakeView.layer.shadowColor     = [UIColor blackColor].CGColor;
            _cellFakeView.layer.shadowOffset    = CGSizeMake(0, 0);
            _cellFakeView.layer.shadowOpacity   = .5f;
            _cellFakeView.layer.shadowRadius    = 3.f;
            UIImageView *cellFakeImageView      = [[UIImageView alloc] initWithFrame:cell.bounds];
            cellFakeImageView.contentMode       = UIViewContentModeScaleAspectFill;
            cellFakeImageView.autoresizingMask  = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            [cellFakeImageView setCellCopiedImage:cell];
            [self.albumView addSubview:_cellFakeView];
            [_cellFakeView addSubview:cellFakeImageView];
            _cellFakeViewCenter      = _cellFakeView.center;
            _reorderingCellIndexPath = indexPath;
            cell.hidden = YES;
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            //            NSLog(@"UIGestureRecognizerStateCancelled");
            NSIndexPath *currentCellIndexPath = _reorderingCellIndexPath;
            [UIView animateWithDuration:.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                _cellFakeView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [_cellFakeView removeFromSuperview];
                _cellFakeView = nil;
                _cellFakeViewCenter = CGPointZero;
                if (finished) {
                    //did end dragging
                    if ([self respondsToSelector:@selector(collectionView:layout:didEndDraggingItemAtIndexPath:)]) {
                        [self collectionView:self.albumView layout:self.albumView.collectionViewLayout didEndDraggingItemAtIndexPath:currentCellIndexPath];
                    }
                }
            }];
            break;
        }
        default:
            break;
    }
}

#pragma mark    拖动
- (void)panGRAction:(UIPanGestureRecognizer *)panGR{
    if (!self.isShaking) {
        return;
    }
    switch (panGR.state) {
        case UIGestureRecognizerStateChanged: {
            _panTranslation = [panGR translationInView:self.albumView];
            _cellFakeView.center = CGPointMake(_cellFakeViewCenter.x + _panTranslation.x, _cellFakeViewCenter.y + _panTranslation.y);
            //move layout
            [self moveItemIfNeeded];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            break;
        default:
            break;
    }
}

- (void)moveItemIfNeeded
{
    NSIndexPath *atIndexPath = _reorderingCellIndexPath;
    NSIndexPath *toIndexPath = [self.albumView indexPathForItemAtPoint:_cellFakeView.center];
    NSIndexPath *forbidIndexPath = [NSIndexPath indexPathForRow:self.collectionImageArray.count-1 inSection:0];
    if (toIndexPath == nil || [atIndexPath isEqual:toIndexPath] || [toIndexPath isEqual:forbidIndexPath]) {
        return;
    }
    //can move
    if ([self respondsToSelector:@selector(collectionView:itemAtIndexPath:canMoveToIndexPath:)]) {
        if (![self collectionView:self.albumView itemAtIndexPath:atIndexPath canMoveToIndexPath:toIndexPath]) {
            return;
        }
    }
    
    //move
    [self.albumView performBatchUpdates:^{
        //update cell indexPath
        _reorderingCellIndexPath = toIndexPath;
        //did move
        if ([self respondsToSelector:@selector(collectionView:itemAtIndexPath:didMoveToIndexPath:)]) {
            [self collectionView:self.albumView itemAtIndexPath:atIndexPath didMoveToIndexPath:toIndexPath];
        }
        [self.albumView moveItemAtIndexPath:atIndexPath toIndexPath:toIndexPath];
    } completion:nil];
}

#pragma mark    停止抖动
- (void)stopHeaderImageViewShakeAction{
    self.isShaking = NO;
    for (int i = 0; i < self.collectionImageArray.count-1; i++) {
        SetupPersonalImageObject *data = [self.collectionImageArray objectAtIndex:i];
        data.isEdit = NO;
    }
    SetupPersonalImageObject *data = [self.collectionImageArray lastObject];
    data.isEdit = NO;
    [self.albumView reloadData];
}

#pragma mark    开始抖动
- (void)startHeaderImageViewShakeAction{
    if (self.isShaking == NO) {
        for (int i = 0; i < self.collectionImageArray.count-1; i++) {
            SetupPersonalImageObject *data = [self.collectionImageArray objectAtIndex:i];
            data.isEdit = YES;
        }
        SetupPersonalImageObject *data = [self.collectionImageArray lastObject];
        data.isEdit = NO;
        [self.albumView reloadData];
    }
    self.isShaking = YES;
}

#pragma mark    删除元素
- (void)setupPersonalImageCellDeleteAction:(SetupPersonalImageCell *)cell withIndex:(NSIndexPath *)indexPath{
    [self.albumView performBatchUpdates:^{
        [self.collectionImageArray removeObjectAtIndex:indexPath.item];
        [self.albumView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self changeFrame];
        [self.albumView reloadData];
    }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([_panGR isEqual:gestureRecognizer]) {
        if (_longPressGR.state == 0 || _longPressGR.state == 5) {
            return NO;
        }
    }else if ([_longPressGR isEqual:gestureRecognizer]) {
        if (self.albumView.panGestureRecognizer.state != 0 && self.albumView.panGestureRecognizer.state != 5) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([_panGR isEqual:gestureRecognizer]) {
        if (_longPressGR.state != 0 && _longPressGR.state != 5) {
            if ([_longPressGR isEqual:otherGestureRecognizer]) {
                return YES;
            }
            return NO;
        }
    }else if ([_longPressGR isEqual:gestureRecognizer]) {
        if ([_panGR isEqual:otherGestureRecognizer]) {
            return YES;
        }
    }else if ([self.albumView.panGestureRecognizer isEqual:gestureRecognizer]) {
        if (_longPressGR.state == 0 || _longPressGR.state == 5) {
            return NO;
        }
    }
    return YES;
}

- (void)pickerViewActionWithIndexPath:(NSInteger)indexPath{
    if (self.tempIndex == 1 ||
        self.tempIndex == 2 ||
        self.tempIndex == 4 ) {
        [self hidePickerViewAction:self.tempIndex];
    }
    
    
    if (indexPath == 1 ||
        indexPath == 2 ||
        indexPath == 4) {
        [self showPickerViewAction:indexPath];
    }
    
    self.tempIndex = indexPath;
}

- (void)textFieldActionWithIndexPath:(NSInteger)indexPath{
    if (self.tempIndex == 1 ||
        self.tempIndex == 2 ||
        self.tempIndex == 4 ) {
        [self hidePickerViewAction:self.tempIndex];
    }
    self.tempIndex = indexPath;
}

//hidepicker
#pragma mark     - 方法
#pragma mark    成功获取数据后刷新页面
- (void)successRefreshAction{
    [self.collectionImageArray removeAllObjects];
    NSArray *imagePathContainer = [[[UserManager manager] userData] userShowList];
    
    //排序
    NSArray *container = [imagePathContainer sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([[obj1 objectForKey:@"position"] integerValue] > [[obj2 objectForKey:@"position"] integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([[obj1 objectForKey:@"position"] integerValue] < [[obj2 objectForKey:@"position"] integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    for (int i = 0; i < container.count; i++) {
        NSDictionary *imageDict  = [container objectAtIndex:i];
        SetupPersonalImageObject *data = [[SetupPersonalImageObject alloc] init];
        data.isImageData  = NO;
        data.isEdit       = NO;
        data.isBundleData = NO;
        data.index        = [[imageDict objectForKey:@"position"] integerValue];
        data.imagePath    = [imageDict objectForKey:@"icon"];
        data.pid          = [imageDict objectForKey:@"pid"];
        [self.collectionImageArray addObject:data];
    }
    self.basicImage.index = container.count-1;
    [self.collectionImageArray addObject:self.basicImage];
    [self commonDataSetting];
}

#pragma mark    获取数据失败后刷新页面
- (void)failedRefreshAction{
    [self.collectionImageArray removeAllObjects];
    [self.collectionImageArray addObject:self.basicImage];
    [self commonDataSetting];
}

#pragma mark    本地数据更新后刷新数据
- (void)refreshHeaderImageCollectionView:(NSArray *)imageContainer{
    NSMutableArray *dataArray      = [NSMutableArray array];
    NSMutableArray * tempArray     = [NSMutableArray array];
    
    for (int i = 0; i < imageContainer.count; i++) {
        UIImage *image = [imageContainer objectAtIndex:i];
        SetupPersonalImageObject *data = [[SetupPersonalImageObject alloc] init];
        data.isBundleData = NO;
        data.isImageData  = YES;
        data.isEdit       = NO;
        data.image        = image;
        data.index        = self.collectionImageArray.count+i-1;
        [dataArray addObject:data];
    }
    [tempArray addObjectsFromArray:self.collectionImageArray];
    [self.collectionImageArray removeAllObjects];
    [self.collectionImageArray addObjectsFromArray:dataArray];
    [self.collectionImageArray addObjectsFromArray:tempArray];
    dataArray = nil;
    tempArray = nil;
    [self changeFrame];
    [self.albumView reloadData];
}

#pragma mark    commondDataSetting
- (void)commonDataSetting{
    WeakSelf;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[[[UserManager manager] userData] userIcon]] ];
    [self.backgroundImgView sd_setImageWithURL:[NSURL URLWithString:[[[UserManager manager] userData] userIcon]] placeholderImage:[UIImage imageNamed:@"default_pic.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.backgroundImgView.image = [UIImage imageBlur:image];
    }];
    self.nameView.contentText   = [[[UserManager manager] userData] userName];
    self.ageView.contentText    = [NSString stringWithFormat:@"%ld",(long)[[[UserManager manager] userData] userAge]];
    self.heightView.contentText = [NSString stringWithFormat:@"%ld",(long)[[[UserManager manager] userData] userHeigth]];
    self.hobbyView.contentText  = [[[UserManager manager] userData] userInterst];
    self.cityView.contentText   = [[[UserManager manager] userData] userCity];
    self.professionView.contentText = [[[UserManager manager] userData] userVocation];
    self.signView.contentText   = [[[UserManager manager] userData] userDescription];
    [self setData];
    [self changeFrame];
    [self.albumView reloadData];
}

- (void)changeFrame{
    WeakSelf;
    if (self.collectionImageArray.count > 4) {
        //相册部分
        [self.albumContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.right.equalTo(weakSelf.mas_right);
            make.top.equalTo(weakSelf.tagContainer.mas_bottom).with.offset(9);
            make.height.equalTo(@((ScreenWidth-8*2)/4*2+8*3));
        }];
        CGFloat heigth = self.commonHeigth + (ScreenWidth-8*2)/4*2+8*3;
        self.shadowView.frame = CGRectMake(0, 0, SCREEN_WIDTH, heigth);
        self.backScrollView.contentSize = CGSizeMake(0, heigth);
    }else{
        //相册部分
        [self.albumContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.right.equalTo(weakSelf.mas_right);
            make.top.equalTo(weakSelf.tagContainer.mas_bottom).with.offset(9);
            make.height.equalTo(@((ScreenWidth-8*2)/4+8*2));
        }];
        CGFloat heigth = self.commonHeigth + (ScreenWidth-8*2)/4+8*2;
        self.shadowView.frame = CGRectMake(0, 0, SCREEN_WIDTH, heigth);
        self.backScrollView.contentSize = CGSizeMake(0, heigth);
    }
}

#pragma mark    获取要上传的头像
- (NSArray *)getUploadImages{
    NSMutableArray *array = [NSMutableArray array];
    for (SetupPersonalImageObject *data in self.collectionImageArray) {
        if (!data.isBundleData && data.isImageData) {
            [self.willUpLoadImageArray addObject:data];
            [array addObject:data.image];
        }
    }
    return array;
}

- (NSString *)getUploadImagesParameters:(NSArray *)PIDContainer{
    for (int i = 0; i < PIDContainer.count; i++) {
        SetupPersonalImageObject *data = [self.willUpLoadImageArray objectAtIndex:i];
        data.pid = [PIDContainer objectAtIndex:i];
    }
    
    NSMutableArray *returnArray = [NSMutableArray array];
    for (int i = 0; i < self.collectionImageArray.count-1; i++) {
        SetupPersonalImageObject *data = [self.collectionImageArray objectAtIndex:i];
        NSDictionary *dict = @{@"pid":data.pid,
                               @"index":[NSNumber numberWithInteger:data.index]};
        [returnArray addObject:dict];
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:returnArray options:NSJSONWritingPrettyPrinted error:&error];//此处data参数是我上面提到的key为"data"的数组
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

- (NSArray *)getUploadBasicInfo{
    NSArray *basicInfo = @[self.nameView.contentText?self.nameView.contentText:@" ",
                           self.ageView.contentText?self.ageView.contentText:@"0",
                           self.heightView.contentText?self.heightView.contentText:@"0",
                           self.hobbyView.contentText?self.hobbyView.contentText:@" ",
                           self.cityView.contentText?self.cityView.contentText:@" ",
                           self.professionView.contentText?self.professionView.contentText:@" ",
                           self.signView.contentText?self.signView.contentText:@" "];
    return basicInfo;
}

#pragma mark    代理数据
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if (self.pushToImagePickerBlock != nil) {
            if (actionSheet.tag == 500) {
                self.pushToImagePickerBlock(YES, NO);
            }else{
                self.pushToImagePickerBlock(YES, YES);
            }
        }
    }else if(buttonIndex == 1){
        if (self.pushToImagePickerBlock != nil) {
            if (actionSheet.tag == 500) {
                self.pushToImagePickerBlock(NO, NO);
            }else{
                self.pushToImagePickerBlock(NO,YES);
            }
        }
    }
}

#pragma mark    tag按钮动作
- (void)tagButtonAction:(UIButton *)sender{
    if (self.pushToTagControllerBlock != nil) {
        self.pushToTagControllerBlock();
    }
}

#pragma mark    更换头像
- (void)changeHeadeImage:(UITapGestureRecognizer *)tapGR{
    self.sheetView.tag = 600;
    [self.sheetView showInView:[[UIApplication sharedApplication] keyWindow]];
}

- (void)endPersonalInfoCellEdit{
    [self.nameView editedStatus];
    [self.hobbyView editedStatus];
    [self.professionView editedStatus];
    [self.signView editedStatus];
}

#pragma mark   - 展示pickerView
- (void)showPickerViewAction:(NSInteger)index{
    [self endPersonalInfoCellEdit];
    switch (index) {
        case 1:
        {
            [self.backgroundImgView addSubview:self.agePicker];
            [self raiseBackgroundImageAction];
            break;
        }
        case 2:
        {
            [self.backgroundImgView addSubview:self.heigthPicker];
            [self raiseBackgroundImageAction];
            break;
        }
        case 4:
        {
            [self.backgroundImgView addSubview:self.locationPicker];
            [self raiseBackgroundImageAction];
            break;
        }
    }
}
#pragma mark   - 隐藏pickerView
- (void)hidePickerViewAction:(NSInteger)index{
    if (self.agePicker != nil && index == 1) {
        [self.ageView editedStatus];
        [self.agePicker removeFromSuperview];
        self.agePicker = nil;
        [self reduceBackgroundImageAction];
    }
    
    if (self.heigthPicker != nil && index == 2) {
        [self.heightView editedStatus];
        [self.heigthPicker removeFromSuperview];
        self.heigthPicker = nil;
        [self reduceBackgroundImageAction];
    }
    
    if (self.locationPicker != nil && index == 4) {
        [self.cityView editedStatus];
        [self.locationPicker removeFromSuperview];
        self.locationPicker = nil;
        [self reduceBackgroundImageAction];
    }
}

- (void)raiseBackgroundImageAction{
    CGRect fromFrame = self.backgroundImgView.frame;
    CGRect toFrame   = CGRectMake(fromFrame.origin.x,
                                  fromFrame.origin.y-162,
                                  fromFrame.size.width,
                                  fromFrame.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundImgView.frame = toFrame;
    }];
}

- (void)reduceBackgroundImageAction{
    CGRect fromFrame = self.backgroundImgView.frame;
    CGRect toFrame   = CGRectMake(fromFrame.origin.x,
                                  fromFrame.origin.y+162,
                                  fromFrame.size.width,
                                  fromFrame.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundImgView.frame = toFrame;
    }];
}

#pragma mark  - 控制键盘
- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame        = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect beginFrame      = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration       = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    void(^animations)() = ^{
        [self willShowKeyboardFromFrame:beginFrame toFrame:endFrame];
    };
    
    void(^completion)(BOOL) = ^(BOOL finished){
    };
    
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:animations completion:completion];
}

- (void)willShowKeyboardFromFrame:(CGRect)beginFrame toFrame:(CGRect)toFrame{
    CGRect frame = self.backgroundImgView.frame;
    self.backgroundImgView.frame = CGRectMake(frame.origin.x,
                                              frame.origin.y+(toFrame.origin.y - beginFrame.origin.y),
                                              frame.size.width,
                                              frame.size.height);
//                                              frame.size.height+(toFrame.size.height - beginFrame.size.height));
}

#pragma mark    -
#pragma mark    设置数据
- (void)setData{
    [self setTagData];
}

#pragma mark    设置标签数据
- (void)setTagData{
    WeakSelf;
    [self.tagDataContainer removeAllObjects];
    [self.tagDataContainer addObjectsFromArray:[[[UserManager manager] userData] userTagList]];
    
    [self.tag1 removeFromSuperview];
    self.tag1 = nil;
    [self.tag2 removeFromSuperview];
    self.tag2 = nil;
    [self.tag3 removeFromSuperview];
    self.tag3 = nil;
    NSInteger tagCount = self.tagDataContainer.count;
    if (tagCount == 0) {
        [self.tag1 setTitle:@"+标签" forState:UIControlStateNormal];
        [self.tagContainer addSubview:self.tag1];
        [self.tag1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tagContainer.mas_top);
            make.centerX.equalTo(weakSelf.tagContainer.mas_centerX);
            make.bottom.equalTo(weakSelf.tagContainer.mas_bottom);
            make.width.equalTo(weakSelf.tagContainer.mas_width).multipliedBy(1/3.0);
        }];
    }
    if (tagCount == 1) {
        SeedTagData *tagOneData = [self.tagDataContainer objectAtIndex:0];
        [self.tag1 setTitle:tagOneData.TagText forState:UIControlStateNormal];
        self.tag1.backgroundColor = tagOneData.TagColor;
        [self.tag1 setBackgroundImage:nil forState:UIControlStateNormal];
        
        [self.tagContainer addSubview:self.tag1];
        [self.tag1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tagContainer.mas_top);
            make.left.equalTo(weakSelf.tagContainer.mas_left);
            make.bottom.equalTo(weakSelf.tagContainer.mas_bottom);
            make.width.equalTo(weakSelf.tagContainer.mas_width).multipliedBy(1/3.0);
        }];
        
        [self.tag2 setTitle:@"+标签" forState:UIControlStateNormal];
        [self.tagContainer addSubview:self.tag2];
        [self.tag2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tagContainer.mas_top);
            make.left.equalTo(weakSelf.tag1.mas_right).with.offset(3);
            make.bottom.equalTo(weakSelf.tagContainer.mas_bottom);
            make.width.mas_equalTo(self.tag1.mas_width);
        }];
    }
    
    if (tagCount == 2) {
        SeedTagData *tagOneData = [self.tagDataContainer objectAtIndex:0];
        [self.tag1 setTitle:tagOneData.TagText forState:UIControlStateNormal];
        self.tag1.backgroundColor = tagOneData.TagColor;
        [self.tag1 setBackgroundImage:nil forState:UIControlStateNormal];
        [self.tagContainer addSubview:self.tag1];
        [self.tag1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tagContainer.mas_top);
            make.left.equalTo(weakSelf.tagContainer.mas_left);
            make.bottom.equalTo(weakSelf.tagContainer.mas_bottom);
            make.width.mas_equalTo(weakSelf.tagContainer.mas_width).multipliedBy(1/3.0);
        }];
        
        SeedTagData *tagTwoData = [self.tagDataContainer objectAtIndex:1];
        [self.tag2 setTitle:tagTwoData.TagText forState:UIControlStateNormal];
        self.tag2.backgroundColor = tagTwoData.TagColor;
        [self.tag2 setBackgroundImage:nil forState:UIControlStateNormal];
        [self.tagContainer addSubview:self.tag2];
        [self.tag2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tagContainer.mas_top);
            make.left.equalTo(weakSelf.tag1.mas_right).with.offset(3);
            make.bottom.equalTo(weakSelf.tagContainer.mas_bottom);
            make.width.mas_equalTo(self.tag1.mas_width);
        }];
        
        [self.tag3 setTitle:@"+标签" forState:UIControlStateNormal];
        [self.tagContainer addSubview:self.tag3];
        [self.tag3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tagContainer.mas_top);
            make.left.equalTo(weakSelf.tag2.mas_right).with.offset(3);
            make.bottom.equalTo(weakSelf.tagContainer.mas_bottom);
            make.width.mas_equalTo(self.tag2.mas_width);
        }];
    }
    
    if (tagCount == 3) {
        SeedTagData *tagOneData = [self.tagDataContainer objectAtIndex:0];
        [self.tag1 setTitle:tagOneData.TagText forState:UIControlStateNormal];
        self.tag1.backgroundColor = tagOneData.TagColor;
        [self.tag1 setBackgroundImage:nil forState:UIControlStateNormal];
        [self.tagContainer addSubview:self.tag1];
        [self.tag1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tagContainer.mas_top);
            make.left.equalTo(weakSelf.tagContainer.mas_left);
            make.bottom.equalTo(weakSelf.tagContainer.mas_bottom);
            make.width.equalTo(weakSelf.tagContainer.mas_width).multipliedBy(1/3.0);
        }];
        
        SeedTagData *tagTwoData = [self.tagDataContainer objectAtIndex:1];
        [self.tag2 setTitle:tagTwoData.TagText forState:UIControlStateNormal];
        self.tag2.backgroundColor = tagTwoData.TagColor;
        [self.tag2 setBackgroundImage:nil forState:UIControlStateNormal];
        [self.tagContainer addSubview:self.tag2];
        [self.tag2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tagContainer.mas_top);
            make.left.equalTo(weakSelf.tag1.mas_right).with.offset(3);
            make.bottom.equalTo(weakSelf.tagContainer.mas_bottom);
            make.width.mas_equalTo(self.tag1.mas_width);
        }];
        
        SeedTagData *tagThreeData = [self.tagDataContainer objectAtIndex:2];
        [self.tag3 setTitle:tagThreeData.TagText forState:UIControlStateNormal];
        self.tag3.backgroundColor = tagThreeData.TagColor;
        [self.tag3 setBackgroundImage:nil forState:UIControlStateNormal];
        [self.tagContainer addSubview:self.tag3];
        [self.tag3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tagContainer.mas_top);
            make.left.equalTo(weakSelf.tag2.mas_right).with.offset(3);
            make.bottom.equalTo(weakSelf.tagContainer.mas_bottom);
            make.width.mas_equalTo(self.tag2.mas_width);
        }];
    }
}

#pragma mark    获取年龄
- (void)getAgeAction:(NSString *)age{
    self.ageView.contentText = age;
}

#pragma mark    获取身高
- (void)getHeigthAction:(NSString *)heigth{
    self.heightView.contentText = heigth;
}

#pragma mark    获取所在城市
- (void)getLocationAction:(NSString *)location{
    self.cityView.contentText = location;
}

#pragma mark 结束编辑
- (void)saveAction{
    [self.shadowView endEditing:YES];
    [self hidePickerViewAction:self.tempIndex];
}
@end