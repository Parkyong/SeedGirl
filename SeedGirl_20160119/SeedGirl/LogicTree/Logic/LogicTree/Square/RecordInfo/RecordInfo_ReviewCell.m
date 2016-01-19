//
//  RecordInfo_ReviewCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/4.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "RecordInfo_ReviewCell.h"
#import "CommentData.h"
#import "DateTool.h"

@interface RecordInfo_ReviewCell ()
@property (nonatomic, strong) UILabel          *levelLabel;
@property (nonatomic, strong) UILabel    *reviewWordsLabel;
@property (nonatomic, strong) UILabel *subReviewWordsLabel;
@property (nonatomic, strong) UIImageView   *headImageView;
@property (nonatomic, strong) UILabel       *nickNameLabel;
@property (nonatomic, strong) UILabel           *timeLabel;
@property (nonatomic, strong) UIView            *container;
@property (nonatomic, strong) UIView      *reviewContainer;
@property (nonatomic, strong) UIButton         *noteButton;
@property (nonatomic, strong) UIButton        *replyButton;
@property (nonatomic, strong) UIButton       *praiseButton;
@property (nonatomic, strong) UIView                 *line;
@end
@implementation RecordInfo_ReviewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
        [self addLimits];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark    添加试图
- (void)addViews{
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nickNameLabel];
    [self.contentView addSubview:self.levelLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.reviewContainer];
    [self.reviewContainer addSubview:self.reviewWordsLabel];
    [self.reviewContainer addSubview:self.subReviewWordsLabel];
    [self.contentView addSubview:self.container];
    [self.container addSubview:self.noteButton];
    [self.container addSubview:self.replyButton];
    [self.container addSubview:self.praiseButton];
    [self.contentView addSubview:self.line];
    
//    self.headImageView.backgroundColor = [UIColor redColor];
//    self.nickNameLabel.backgroundColor = [UIColor yellowColor];
//    self.levelLabel.backgroundColor = [UIColor greenColor];
//    self.timeLabel.backgroundColor = [UIColor purpleColor];
//    self.reviewWordsLabel.backgroundColor = [UIColor blueColor];
//    self.container.backgroundColor = [UIColor blackColor];
}

#pragma mark    添加约束
- (void)addLimits{
    WeakSelf;
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).with.offset([Adaptor returnAdaptorValue:9]);
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset([Adaptor returnAdaptorValue:11]);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:28], [Adaptor returnAdaptorValue:28]));
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headImageView.mas_top);
        make.left.equalTo(weakSelf.headImageView.mas_right).with.offset([Adaptor returnAdaptorValue:9]);
        make.width.equalTo(weakSelf.levelLabel.mas_width);
        make.height.mas_equalTo([Adaptor returnAdaptorValue:15]);
    }];
    
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headImageView.mas_top);
        make.left.equalTo(weakSelf.nickNameLabel.mas_right);
        make.width.equalTo(weakSelf.nickNameLabel.mas_width);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-[Adaptor returnAdaptorValue:11]);
        make.height.mas_equalTo([Adaptor returnAdaptorValue:15]);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nickNameLabel.mas_bottom).with.offset([Adaptor returnAdaptorValue:3]);
        make.left.equalTo(weakSelf.nickNameLabel.mas_left);
        make.bottom.equalTo(weakSelf.headImageView.mas_bottom);
        make.right.equalTo(weakSelf.levelLabel.mas_right);
    }];
    
    [self.reviewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timeLabel.mas_bottom).with.offset([Adaptor returnAdaptorValue:10]);
        make.left.equalTo(weakSelf.timeLabel.mas_left);
        make.right.equalTo(weakSelf.timeLabel.mas_right);
    }];

    [self.reviewWordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.reviewContainer.mas_top);
        make.left.equalTo(weakSelf.reviewContainer.mas_left);
//        make.right.equalTo(weakSelf.reviewContainer.mas_right);

    }];

    [self.subReviewWordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.reviewWordsLabel.mas_bottom);
        make.left.equalTo(weakSelf.reviewContainer.mas_left);
//        make.right.equalTo(weakSelf.reviewContainer.mas_right);
        make.bottom.equalTo(weakSelf.reviewContainer.mas_bottom);
    }];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.reviewContainer.mas_bottom).with.offset([Adaptor returnAdaptorValue:10]);
        make.width.mas_equalTo([Adaptor returnAdaptorValue:196]);
        make.height.mas_equalTo([Adaptor returnAdaptorValue:22]);
        make.right.equalTo(weakSelf.timeLabel.mas_right);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.container.mas_bottom).with.offset([Adaptor returnAdaptorValue:13]);
        make.left.equalTo(weakSelf.headImageView.mas_left);
        make.height.equalTo(@1);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.right.equalTo(weakSelf.container.mas_right);
    }];
    
    [self.noteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.container.mas_top);
        make.left.equalTo(weakSelf.container.mas_left);
        make.bottom.equalTo(weakSelf.container.mas_bottom);
        make.width.equalTo(weakSelf.replyButton.mas_width);
    }];
    
    [self.replyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.container.mas_top);
        make.left.equalTo(weakSelf.noteButton.mas_right).with.offset([Adaptor returnAdaptorValue:9]);
        make.bottom.equalTo(weakSelf.container.mas_bottom);
        make.width.equalTo(weakSelf.noteButton.mas_width);
    }];
    
    [self.praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.container.mas_top);
        make.left.equalTo(weakSelf.replyButton.mas_right).with.offset([Adaptor returnAdaptorValue:9]);
        make.bottom.equalTo(weakSelf.container.mas_bottom);
        make.right.equalTo(weakSelf.container.mas_right);
        make.width.equalTo(weakSelf.replyButton.mas_width);
    }];
}

#pragma mark    懒加载对象
- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _headImageView;
}

- (UILabel *)nickNameLabel{
    if (_nickNameLabel == nil) {
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nickNameLabel.textColor = RGB(255, 255, 255);
        _nickNameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    }
    return _nickNameLabel;
}

- (UILabel *)levelLabel{
    if (_levelLabel == nil) {
        _levelLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _levelLabel.backgroundColor = [UIColor clearColor];
        _levelLabel.textColor = RGB(255, 255, 255);
        _levelLabel.textAlignment = NSTextAlignmentRight;
        _levelLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    }
    return  _levelLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = RGBA(255, 255, 255, 0.4);
        _timeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
    }
    return _timeLabel;
}

- (UIView *)reviewContainer{
    if (_reviewContainer == nil) {
        _reviewContainer = [[UIView alloc] init];
    }
    return _reviewContainer;
}

- (UILabel *)reviewWordsLabel{
    if (_reviewWordsLabel == nil) {
        _reviewWordsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _reviewWordsLabel.backgroundColor = [UIColor clearColor];
        _reviewWordsLabel.textColor = RGBA(255, 255, 255, 1);
        _reviewWordsLabel.font = [UIFont systemFontOfSize:14.0f];
        _reviewWordsLabel.numberOfLines = 0;
        _reviewWordsLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _reviewWordsLabel.preferredMaxLayoutWidth = ScreenWidth - [Adaptor returnAdaptorValue:28] - [Adaptor returnAdaptorValue:11]*2;
    }
    return _reviewWordsLabel;
}

- (UILabel *)subReviewWordsLabel{
    if (_subReviewWordsLabel == nil) {
        _subReviewWordsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subReviewWordsLabel.backgroundColor = [UIColor clearColor];
        _subReviewWordsLabel.textColor = RGBA(255, 255, 255, 1);
        _subReviewWordsLabel.font = [UIFont systemFontOfSize:14.0f];
        _subReviewWordsLabel.numberOfLines = 0;
        _subReviewWordsLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _subReviewWordsLabel.preferredMaxLayoutWidth = ScreenWidth - [Adaptor returnAdaptorValue:28] - [Adaptor returnAdaptorValue:11]*2;
    }
    return _subReviewWordsLabel;
}


- (UIView *)container{
    if (_container == nil) {
        _container = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _container;
}

- (UIButton *)noteButton{
    if (_noteButton == nil) {
        _noteButton = [[UIButton alloc] init];
        [_noteButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"button_background.png"]] forState:UIControlStateNormal];
        [_noteButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"button_background.png"]] forState:UIControlStateHighlighted];
        [_noteButton setTitle:@"纸条" forState:UIControlStateNormal];
        _noteButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _noteButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_noteButton addTarget:self action:@selector(noteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noteButton;
}

- (UIButton *)replyButton{
    if (_replyButton == nil) {
        _replyButton = [[UIButton alloc] init];
        [_replyButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"button_background.png"]] forState:UIControlStateNormal];
        [_replyButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"button_background.png"]] forState:UIControlStateHighlighted];
        [_replyButton setTitle:@"回复" forState:UIControlStateNormal];
        _replyButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _replyButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_replyButton addTarget:self action:@selector(replyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replyButton;
}

- (UIButton *)praiseButton{
    if (_praiseButton == nil) {
        _praiseButton = [[UIButton alloc] init];
        [_praiseButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"button_background.png"]] forState:UIControlStateNormal];
        [_praiseButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"button_background.png"]] forState:UIControlStateHighlighted];
        _praiseButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _praiseButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_praiseButton addTarget:self action:@selector(praiseButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _praiseButton;
}

- (UIView *)line{
    if (_line == nil) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = RGBA(255, 255, 255, 0.3);
    }
    return _line;
}
#pragma mark    方法
- (void)setCellsData:(CommentData *)data withIndexPath:(NSIndexPath *)indexPath
{
    if (data == nil) {
        return;
    }
    self.indexPath = indexPath;
    self.nickNameLabel.text     = data.userName;
    self.levelLabel.text        = [NSString stringWithFormat:@"Lv.%ld", data.userLevel];
    self.timeLabel.text         = [DateTool getTimeString:data.commentTime];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:data.userIcon]];
    [self.praiseButton setTitle:[NSString stringWithFormat:@"赞 %ld", data.praiseCount] forState:UIControlStateNormal];
    self.reviewWordsLabel.backgroundColor = [UIColor clearColor];
    if (data.isSubComment){
        self.reviewWordsLabel.text = [NSString stringWithFormat:@"@%@ %@", data.toUserName, data.subCommentText];
        self.subReviewWordsLabel.text = data.commentText;
        self.reviewWordsLabel.backgroundColor = RGBA(0, 0, 0, 0.3);
    }else{
        self.reviewWordsLabel.text  = data.commentText;
        self.subReviewWordsLabel.text = data.subCommentText;
    }
}

- (void)noteButtonAction:(UIButton *)sender{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(reviewCellNoteAction: withIndexPath:)]) {
        [self.delegate reviewCellNoteAction:self withIndexPath:self.indexPath];
    }
}

- (void)replyButtonAction:(UIButton *)sender{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(reviewCellReplyAction:withIndexPath:)]) {
        [self.delegate reviewCellReplyAction:self withIndexPath:self.indexPath];
    }
}

- (void)praiseButtonAction:(UIButton *)sender{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(reviewCellPriseAction: withIndexPath:)]) {
        [self.delegate reviewCellPriseAction:self withIndexPath:self.indexPath];
    }
}
@end