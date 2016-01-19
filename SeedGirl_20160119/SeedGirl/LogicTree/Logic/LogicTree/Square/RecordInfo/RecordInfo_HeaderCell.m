//
//  RecordInfo_HeaderCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/5.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "RecordInfo_HeaderCell.h"
#import "RecordCustomButton.h"
#import "RecordData.h"
#import "SetupPersonalImageObject.h"
#import "RecordInfo_HeaderCollectionCell.h"
#import "RecordInfo_HeaderCollectionVideoCell.h"

@interface RecordInfo_HeaderCell ()<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIView                *upContainer;
@property (nonatomic, strong) UIView          *subUp_upContainer;
@property (nonatomic, strong) UIView        *subDown_upContainer;
@property (nonatomic, strong) UIImageView         *headImageBack;
@property (nonatomic, strong) UIImageView         *headImageView;
@property (nonatomic, strong) UILabel             *nickNameLabel;
@property (nonatomic, strong) UILabel                *levelLabel;
@property (nonatomic, strong) UIImageView        *clockImageView;
@property (nonatomic, strong) UILabel                 *timeLabel;
@property (nonatomic, strong) UIView                 *reviewBack;
@property (nonatomic, strong) UILabel               *reviewLabel;
@property (nonatomic, strong) UIView             *imageContainer;
@property (nonatomic, strong) UICollectionView*subImageContainer;
@property (nonatomic, strong) UIView              *downContainer;
@property (nonatomic, strong) UILabel               *symbolLabel;
@property (nonatomic, strong) UIView                       *line;
@property (nonatomic, strong) RecordCustomButton    *broseButton;
@property (nonatomic, strong) RecordCustomButton     *noteButton;
@property (nonatomic, strong) RecordCustomButton  *commentButton;
@property (nonatomic, strong) RecordCustomButton    *priseButton;
@property (nonatomic, strong) NSMutableArray*imageDataContainter;
@end
@implementation RecordInfo_HeaderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setParameters];
        [self addViews];
        [self addLimits];
        [self addFunction];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setParameters{
    self.imageDataContainter          = [NSMutableArray array];
    [self.subImageContainer registerClass:[RecordInfo_HeaderCollectionCell class] forCellWithReuseIdentifier:@"RecordInfo_HeaderCollectionCell"];
    [self.subImageContainer registerClass:[RecordInfo_HeaderCollectionVideoCell class] forCellWithReuseIdentifier:@"RecordInfo_HeaderCollectionVideoCell"];
    self.subImageContainer.delegate   = self;
    self.subImageContainer.dataSource = self;
}

- (void)addViews{
    [self.contentView addSubview:self.upContainer];
    [self.contentView addSubview:self.reviewBack];
    [self.contentView addSubview:self.imageContainer];
    [self.contentView addSubview:self.downContainer];
    [self.contentView addSubview:self.symbolLabel];
    [self.contentView addSubview:self.line];
    
    [self.upContainer addSubview:self.subUp_upContainer];
    [self.upContainer addSubview:self.subDown_upContainer];
    [self.upContainer addSubview:self.headImageBack];
    [self.headImageBack addSubview:self.headImageView];
    
    [self.subUp_upContainer addSubview:self.nickNameLabel];
    [self.subUp_upContainer addSubview:self.levelLabel];
    [self.subDown_upContainer addSubview:self.clockImageView];
    [self.subDown_upContainer addSubview:self.timeLabel];
    
    [self.reviewBack addSubview:self.reviewLabel];
    [self.imageContainer addSubview:self.subImageContainer];
    
    [self.downContainer addSubview:self.broseButton];
    [self.downContainer addSubview:self.noteButton];
    [self.downContainer addSubview:self.commentButton];
    [self.downContainer addSubview:self.priseButton];
    
//        self.upContainer.backgroundColor = [UIColor yellowColor];
//        self.imageContainer.backgroundColor = [UIColor redColor];
//        self.reviewLabel.backgroundColor = [UIColor purpleColor];
//        self.reviewBack.backgroundColor  = [UIColor blueColor];
//        self.downContainer.backgroundColor = [UIColor blueColor];
//        self.headImageView.backgroundColor = [UIColor redColor];
//        self.levelLabel.backgroundColor = [UIColor blueColor];
//        self.nickNameLabel.backgroundColor = [UIColor purpleColor];
}

- (void)addLimits{
    WeakSelf;
    [self.upContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).with.offset(HeigthForNavigationBar);
        make.left.equalTo(weakSelf.contentView.mas_left);
        make.right.equalTo(weakSelf.contentView.mas_right);
        make.height.mas_equalTo([Adaptor returnAdaptorValue:108]);
    }];
    
    [self.subUp_upContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.upContainer.mas_top);
        make.left.equalTo(weakSelf.upContainer.mas_left);
        make.right.equalTo(weakSelf.upContainer.mas_right);
        make.height.equalTo(weakSelf.subDown_upContainer.mas_height);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageBack.mas_right).with.offset([Adaptor returnAdaptorValue:11]);
        make.height.mas_equalTo([Adaptor returnAdaptorValue:22]);
        make.bottom.mas_equalTo(-[Adaptor returnAdaptorValue:5]);
    }];
    
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nickNameLabel.mas_right);
        make.height.equalTo(weakSelf.nickNameLabel.mas_height);
        make.bottom.equalTo(weakSelf.nickNameLabel.mas_bottom);
        make.right.equalTo(weakSelf.subUp_upContainer.mas_right).with.offset(-[Adaptor returnAdaptorValue:10]);
    }];
    
    [self.subDown_upContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.subUp_upContainer.mas_bottom);
        make.left.equalTo(weakSelf.upContainer.mas_left);
        make.right.equalTo(weakSelf.upContainer.mas_right);
        make.bottom.equalTo(weakSelf.upContainer.mas_bottom);
        make.height.equalTo(weakSelf.subUp_upContainer.mas_height);
    }];
    
    [self.clockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageBack.mas_right).with.offset([Adaptor returnAdaptorValue:11]);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:22], [Adaptor returnAdaptorValue:22]));
        make.top.mas_equalTo([Adaptor returnAdaptorValue:5]);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.clockImageView.mas_right).with.offset([Adaptor returnAdaptorValue:7]);
        make.top.equalTo(weakSelf.clockImageView.mas_top);
        make.height.equalTo(weakSelf.clockImageView.mas_height);
        make.right.equalTo(weakSelf.subDown_upContainer.mas_right);
    }];
    
    [self.headImageBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.upContainer.mas_left).with.offset([Adaptor returnAdaptorValue:11]);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:86], [Adaptor returnAdaptorValue:86]));
        make.centerY.mas_equalTo(weakSelf.upContainer.mas_centerY);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.headImageBack.mas_centerX);
        make.centerY.equalTo(weakSelf.headImageBack.mas_centerY);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:80], [Adaptor returnAdaptorValue:80]));
    }];
    
    [self.reviewBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.upContainer.mas_bottom);
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset([Adaptor returnAdaptorValue:11]);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-[Adaptor returnAdaptorValue:11]);
    }];
    
    [self.reviewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.reviewBack.mas_top).with.offset([Adaptor returnAdaptorValue:12]);
        make.left.equalTo(weakSelf.reviewBack.mas_left).with.offset([Adaptor returnAdaptorValue:12]);
        make.bottom.equalTo(weakSelf.reviewBack.mas_bottom).with.offset(-[Adaptor returnAdaptorValue:12]);
        make.right.equalTo(weakSelf.reviewBack.mas_right).with.offset(-[Adaptor returnAdaptorValue:12]);
    }];
    
    [self.imageContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.reviewBack.mas_bottom);
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset([Adaptor returnAdaptorValue:15]);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-[Adaptor returnAdaptorValue:15]);
    }];
    
    [self.subImageContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imageContainer.mas_top).with.offset([Adaptor returnAdaptorValue:23]);
        make.left.equalTo(weakSelf.imageContainer.mas_left);
        make.right.equalTo(weakSelf.imageContainer.mas_right);
        make.bottom.equalTo(weakSelf.imageContainer.mas_bottom);
    }];
    
    [self.downContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imageContainer.mas_bottom).with.offset([Adaptor returnAdaptorValue:23]);
        make.left.equalTo(weakSelf.reviewBack.mas_left);
        make.right.equalTo(weakSelf.reviewBack.mas_right);
        make.height.mas_equalTo([Adaptor returnAdaptorValue:29]);
    }];
    
    [self.broseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.downContainer.mas_top);
        make.left.equalTo(weakSelf.downContainer.mas_left);
        make.bottom.equalTo(weakSelf.downContainer.mas_bottom);
        make.width.equalTo(weakSelf.noteButton.mas_width);
    }];
    
    [self.noteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.downContainer.mas_top);
        make.left.equalTo(weakSelf.broseButton.mas_right).with.offset([Adaptor returnAdaptorValue:6]);
        make.bottom.equalTo(weakSelf.downContainer.mas_bottom);
        make.width.equalTo(weakSelf.broseButton.mas_width);
    }];
    
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.downContainer.mas_top);
        make.left.equalTo(weakSelf.noteButton.mas_right).with.offset([Adaptor returnAdaptorValue:6]);
        make.bottom.equalTo(weakSelf.downContainer.mas_bottom);
        make.width.equalTo(weakSelf.broseButton.mas_width);
    }];
    
    [self.priseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.downContainer.mas_top);
        make.left.equalTo(weakSelf.commentButton.mas_right).with.offset([Adaptor returnAdaptorValue:6]);
        make.bottom.equalTo(weakSelf.downContainer.mas_bottom);
        make.right.equalTo(weakSelf.downContainer.mas_right);
        make.width.equalTo(weakSelf.broseButton.mas_width);
    }];
    
    [self.symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.downContainer.mas_bottom).with.offset([Adaptor returnAdaptorValue:30]);
        make.left.equalTo(weakSelf.reviewBack.mas_left);
        make.right.equalTo(weakSelf.reviewBack.mas_right);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.symbolLabel.mas_bottom).with.offset([Adaptor returnAdaptorValue:9]);
        make.left.equalTo(weakSelf.reviewBack.mas_left);
        make.right.equalTo(weakSelf.reviewBack.mas_right);
        make.height.equalTo(@1);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
    }];
}

#pragma mark    添加方法
- (void)addFunction{
    WeakSelf;
    //纸条
    [self.noteButton addActionBlock:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(headerCellNoteAction:withIndexPath:)]) {
            [weakSelf.delegate headerCellNoteAction:weakSelf withIndexPath:weakSelf.indexPath];
        }
    }];
    
    //评论
    [self.commentButton addActionBlock:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(headerCellCommentAction:withIndexPath:)]) {
            [weakSelf.delegate headerCellCommentAction:weakSelf withIndexPath:weakSelf.indexPath];
        }
    }];
    
    //赞
    [self.priseButton addActionBlock:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(headerCellPriseAction:withIndexPath:)]) {
            [weakSelf.delegate headerCellPriseAction:weakSelf withIndexPath:weakSelf.indexPath];
        }
    }];
}

#pragma mark     懒加载对象
- (UIView *)upContainer{
    if (_upContainer == nil) {
        _upContainer = [[UIView alloc] initWithFrame:CGRectZero];
        _upContainer.backgroundColor = [UIColor clearColor];
    }
    return _upContainer;
}

- (UIView *)subUp_upContainer{
    if (_subUp_upContainer == nil) {
        _subUp_upContainer = [[UIView alloc] initWithFrame:CGRectZero];
        _subUp_upContainer.backgroundColor = RGBA(232,93,119,0.85);//RGBA(232, 93, 119, 1);
    }
    return _subUp_upContainer;
}

- (UIView *)subDown_upContainer{
    if (_subDown_upContainer == nil) {
        _subDown_upContainer = [[UIView alloc] initWithFrame:CGRectZero];
        _subDown_upContainer.backgroundColor = [UIColor clearColor];
    }
    return _subDown_upContainer;
}

- (UILabel *)reviewLabel{
    if (_reviewLabel == nil) {
        _reviewLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _reviewLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        _reviewLabel.textColor = [UIColor whiteColor];
        _reviewLabel.backgroundColor = [UIColor clearColor];//RGBA(0, 0, 0, 0.6);
        _reviewLabel.layer.cornerRadius = 5;
        _reviewLabel.layer.masksToBounds = YES;
        _reviewLabel.numberOfLines = 0;
    }
    return _reviewLabel;
}

- (UIView *)reviewBack{
    if (_reviewBack == nil) {
        _reviewBack = [[UIView alloc] initWithFrame:CGRectZero];
        _reviewBack.backgroundColor = RGBA(0, 0, 0, 0.3);
        _reviewBack.layer.cornerRadius = 5;
        _reviewBack.layer.masksToBounds = YES;
    }
    return _reviewBack;
}

- (UIView *)imageContainer{
    if (_imageContainer == nil) {
        _imageContainer = [[UIView alloc] initWithFrame:CGRectZero];
        _imageContainer.backgroundColor = [UIColor clearColor];

        _imageContainer.userInteractionEnabled = YES;
    }
    return _imageContainer;
}

- (UIView *)downContainer{
    if (_downContainer == nil) {
        _downContainer = [[UIView alloc] initWithFrame:CGRectZero];
        _downContainer.backgroundColor = [UIColor clearColor];
    }
    return _downContainer;
}

- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headImageView.image = [UIImage imageNamed:@"1.jpg"];
        _headImageView.layer.cornerRadius = [Adaptor returnAdaptorValue:80]/2;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds = YES;
    }
    return _headImageView;
}

- (UIImageView *)headImageBack{
    if (_headImageBack == nil) {
        _headImageBack = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headImageBack.image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"headImageBack.png"]];
        _headImageBack.layer.cornerRadius = [Adaptor returnAdaptorValue:86]/2;
        _headImageBack.clipsToBounds = YES;
    }
    return _headImageBack;
}

- (UILabel *)nickNameLabel{
    if (_nickNameLabel == nil) {
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nickNameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
        _nickNameLabel.textColor = [UIColor whiteColor];
        _nickNameLabel.shadowOffset = CGSizeMake(3, 0);
        _nickNameLabel.shadowColor = RGBA(0, 0, 0, 0.18);
    }
    return _nickNameLabel;
}

- (UILabel *)levelLabel{
    if (_levelLabel == nil) {
        _levelLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _levelLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        _levelLabel.textColor = [UIColor whiteColor];
        _levelLabel.textAlignment = NSTextAlignmentRight;
    }
    return _levelLabel;
}

- (UIImageView *)clockImageView{
    if (_clockImageView == nil) {
        _clockImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _clockImageView.image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"clock.png"]];
        _clockImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _clockImageView;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        _timeLabel.textColor = RGB(236, 236, 236);
    }
    return _timeLabel;
}

- (UILabel *)symbolLabel{
    if (_symbolLabel == nil) {
        _symbolLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _symbolLabel.font = [UIFont boldSystemFontOfSize:18];
        _symbolLabel.textColor = [UIColor whiteColor];
        _symbolLabel.text = @"Latest Comment";
    }
    return _symbolLabel;
}

- (UIView *)line{
    if (_line == nil) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = RGBA(255, 255, 255, 0.3);
    }
    return _line;
}

- (UIView *)subImageContainer{
    if (_subImageContainer == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _subImageContainer = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _subImageContainer.showsHorizontalScrollIndicator = NO;
        _subImageContainer.showsVerticalScrollIndicator   = NO;
        _subImageContainer.delegate                       = self;
        _subImageContainer.scrollEnabled                  = NO;
        _subImageContainer.backgroundColor = [UIColor clearColor];
    }
    return _subImageContainer;
}

- (RecordCustomButton *)broseButton{
    if (_broseButton == nil) {
        _broseButton = [[RecordCustomButton alloc] initWithFrame:CGRectZero];
        _broseButton.backgroundImagePath = @"button_background.png";
        _broseButton.symbolImagePath     = @"recordInfo_browse.png";
        _broseButton.text                = @"0";
    }
    return _broseButton;
}

- (RecordCustomButton *)noteButton{
    if (_noteButton == nil) {
        _noteButton = [[RecordCustomButton alloc] initWithFrame:CGRectZero];
        _noteButton.backgroundImagePath = @"button_background.png";
        _noteButton.symbolImagePath     = @"recordInfo_note.png";
        _noteButton.text                = @"纸条";
    }
    return _noteButton;
}

- (RecordCustomButton *)commentButton{
    if (_commentButton == nil) {
        _commentButton = [[RecordCustomButton alloc] initWithFrame:CGRectZero];
        _commentButton.backgroundImagePath = @"button_background.png";
        _commentButton.symbolImagePath     = @"recordInfo_comment.png";
        _commentButton.text                = @"0";
    }
    return _commentButton;
}

- (RecordCustomButton *)priseButton{
    if (_priseButton == nil) {
        _priseButton = [[RecordCustomButton alloc] initWithFrame:CGRectZero];
        _priseButton.backgroundImagePath = @"button_background.png";
        _priseButton.symbolImagePath     = @"recordInfo_prise.png";
        _priseButton.text                = @"0";
    }
    return _priseButton;
}

#pragma mark    方法
- (void)setCellsData:(RecordData *)data withIndexPath:(NSIndexPath *)indexPath{
    if (data == nil) {
        return;
    }
    self.indexPath = indexPath;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:data.userIcon]];
    self.nickNameLabel.text     = data.userName;
    self.levelLabel.text        = [NSString stringWithFormat:@"Lv.%ld", data.userLevel];
    self.timeLabel.text         = data.recordTime;
    self.broseButton.text       = [NSString stringWithFormat:@"%ld", data.watchCount];
    self.commentButton.text     = [NSString stringWithFormat:@"%ld", data.commentCount];
    self.priseButton.text       = [NSString stringWithFormat:@"%ld", data.praiseCount];
    
    [self.imageDataContainter removeAllObjects];
    if (data.picList.count == 0) {
        if (data.videoThumbnail.length != 0) {
            SetupPersonalImageObject *dataItem = [[SetupPersonalImageObject alloc] init];
            dataItem.imagePath   = data.videoThumbnail;
            dataItem.isVideoData = YES;
            [self.imageDataContainter addObject:dataItem];
        }
    }else{
        for (NSString *imagePath in data.picList) {
            SetupPersonalImageObject *dataItem = [[SetupPersonalImageObject alloc] init];
            dataItem.imagePath  = imagePath;
            [self.imageDataContainter addObject:dataItem];
        }
    }
    
    WeakSelf;
    if (data.recordText != nil &&
        data.recordText.length != 0 &&
        ![data.recordText isKindOfClass:[NSNull class]]) {
        self.reviewLabel.text = data.recordText;
    }else{
        [self.reviewLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.reviewBack.mas_top);
            make.left.equalTo(weakSelf.reviewBack.mas_left);
            make.bottom.equalTo(weakSelf.reviewBack.mas_bottom);
            make.right.equalTo(weakSelf.reviewBack.mas_right);
        }];
    }
    
    [self setCellFrame];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageDataContainter.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width  = 0;
    CGFloat height = 0;
    if (self.imageDataContainter.count == 1) {
        width  = (ScreenWidth-(4*3)-(2*[Adaptor returnAdaptorValue:15]))/2;
    }else{
        width  = (ScreenWidth-4*4-2*[Adaptor returnAdaptorValue:15])/3;
    }
    height = width;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(8, 0, 8, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SetupPersonalImageObject *cellData = [self.imageDataContainter objectAtIndex:indexPath.row];
    if (cellData.isVideoData) {
        RecordInfo_HeaderCollectionVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecordInfo_HeaderCollectionVideoCell" forIndexPath:indexPath];
        cell.indexPath = indexPath;
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:cellData.imagePath]];
        return cell;
    }else{
        RecordInfo_HeaderCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecordInfo_HeaderCollectionCell" forIndexPath:indexPath];
        cell.indexPath = indexPath;
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:cellData.imagePath]];
        return cell;
    }

    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SetupPersonalImageObject *dataItem = [self.imageDataContainter objectAtIndex:indexPath.row];
    if (dataItem.isVideoData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(headerCellPlayVideo:withIndexPath:)]) {
            [self.delegate headerCellPlayVideo:self withIndexPath:indexPath];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(headerCellZoomingPicture:withIndexPath: withData:)]) {
            [self.delegate headerCellZoomingPicture:self withIndexPath:indexPath withData:self.imageDataContainter];
        }
    }
}

#pragma mark
- (void)setCellFrame{
    WeakSelf;
    if (self.imageDataContainter.count == 0) {
        [self.subImageContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.imageContainer.mas_top);
            make.left.equalTo(weakSelf.imageContainer.mas_left);
            make.right.equalTo(weakSelf.imageContainer.mas_right);
            make.bottom.equalTo(weakSelf.imageContainer.mas_bottom);
        }];
        return;
    }
    
    NSInteger verticalCellCount = ((self.imageDataContainter.count%3)==0?
                                   (self.imageDataContainter.count/3):
                                   (self.imageDataContainter.count/3)+1);
    
    CGFloat cellHeight = (self.imageDataContainter.count == 1)?
                         (ScreenWidth-(4*3)-(2*[Adaptor returnAdaptorValue:15]))/2:
                         (ScreenWidth-4*4-2*[Adaptor returnAdaptorValue:15])/3;
    
    CGFloat collectionHeigth = (verticalCellCount-1)*8+cellHeight*verticalCellCount+8*2+[Adaptor returnAdaptorValue:23];

    [self.imageContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.reviewBack.mas_bottom);
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset([Adaptor returnAdaptorValue:15]);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-[Adaptor returnAdaptorValue:15]);
        make.height.mas_equalTo(collectionHeigth);
    }];
    
    [self.subImageContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imageContainer.mas_top).with.offset([Adaptor returnAdaptorValue:23]);
        make.left.equalTo(weakSelf.imageContainer.mas_left);
        make.right.equalTo(weakSelf.imageContainer.mas_right);
        make.bottom.equalTo(weakSelf.imageContainer.mas_bottom);
    }];
    
    [self.subImageContainer reloadData];
}
@end