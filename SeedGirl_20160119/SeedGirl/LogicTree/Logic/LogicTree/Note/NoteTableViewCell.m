//
//  NoteTableViewCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/9.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "NoteTableViewCell.h"
@interface NoteTableViewCell ()
@property (nonatomic, strong) UIImageView       *headImageView;
@property (nonatomic, strong) UIView           *firstContainer;
@property (nonatomic, strong) UILabel                *nickName;
@property (nonatomic, strong) UIView          *secondContainer;
@property (nonatomic, strong) UILabel     *acquireMessageLabel;
@property (nonatomic, strong) UILabel      *statusMessageLabel;
@property (nonatomic, strong) UILabel               *timeLabel;
@property (nonatomic, strong) UIButton             *deleButton;
@property (nonatomic, strong) UIImageView     *statusImageView;
@end
@implementation NoteTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
    }
    return self;
}

#pragma mark     初始化
- (void)initialize{
    [self addViews];
    [self addLimit];
}

#pragma mark     添加试图
- (void)addViews{
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.firstContainer];
    [self.firstContainer addSubview:self.nickName];
    [self.firstContainer addSubview:self.acquireMessageLabel];
    [self.firstContainer addSubview:self.timeLabel];
    [self.firstContainer addSubview:self.deleButton];
    [self.contentView addSubview:self.statusImageView];
    
//    self.headImageView.backgroundColor       = [UIColor blueColor];
//    self.firstContainer.backgroundColor      = [UIColor yellowColor];
//    self.nickName.backgroundColor            = [UIColor redColor];
//    self.acquireMessageLabel.backgroundColor = [UIColor purpleColor];
//    self.statusMessageLabel.backgroundColor  = [UIColor blueColor];
//    self.secondContainer.backgroundColor     = [UIColor greenColor];
//    self.timeLabel.backgroundColor           = [UIColor redColor];
//    self.deleButton.backgroundColor          = [UIColor yellowColor];
}

- (void)setCellData:(NoteData *)_data{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_data.userIcon]];
    self.nickName.text = _data.userName;
    self.acquireMessageLabel.text = [NSString stringWithFormat:@"%@", _data.lastMSG];
    self.timeLabel.text = _data.timeStamp;
    self.statusImageView.hidden = _data.isRead;
}

#pragma mark     添加限制
- (void)addLimit{
    WeakSelf;
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:58], [Adaptor returnAdaptorValue:58]));
        make.left.equalTo(weakSelf.mas_left).with.offset(11);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [self.statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:10], [Adaptor returnAdaptorValue:10]));
        make.top.equalTo(weakSelf.headImageView.mas_top).with.offset([Adaptor returnAdaptorValue:3]);
        make.right.equalTo(weakSelf.headImageView.mas_right).with.offset(-[Adaptor returnAdaptorValue:3]);
    }];
    
    [self.firstContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageView.mas_right).with.offset(9);
        make.height.equalTo(@([Adaptor returnAdaptorValue:56]));
        make.right.equalTo(weakSelf.mas_right).with.offset(-11);
        make.centerY.equalTo(weakSelf.mas_centerY).with.offset(8);
    }];
    
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.firstContainer.mas_left);
        make.top.equalTo(weakSelf.firstContainer.mas_top);
        make.height.equalTo(@([Adaptor returnAdaptorValue:16]));
        make.width.equalTo(weakSelf.timeLabel.mas_width);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nickName.mas_right);
        make.top.equalTo(weakSelf.firstContainer.mas_top);
        make.height.equalTo(@([Adaptor returnAdaptorValue:16]));
        make.right.equalTo(weakSelf.firstContainer.mas_right);
        make.width.equalTo(weakSelf.nickName.mas_width);
    }];
    
    [self.deleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:38], [Adaptor returnAdaptorValue:38]));
        make.top.equalTo(weakSelf.timeLabel.mas_bottom);
        make.right.equalTo(weakSelf.firstContainer.mas_right).with.offset(-8);
    }];
    
    [self.acquireMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.firstContainer.mas_left);
        make.height.equalTo(@([Adaptor returnAdaptorValue:12]));
        make.centerY.equalTo(weakSelf.deleButton.mas_centerY);
        make.right.equalTo(weakSelf.deleButton.mas_left);
    }];
}

#pragma mark    懒加载对象
- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.contentMode = UIViewContentModeScaleToFill;
        _headImageView.layer.cornerRadius = [Adaptor returnAdaptorValue:58]/2;
        _headImageView.clipsToBounds = YES;
    }
    return _headImageView;
}

- (UIView *)firstContainer{
    if (_firstContainer == nil) {
        _firstContainer = [[UIView alloc] init];
    }
    return _firstContainer;
}

- (UILabel *)nickName{
    if (_nickName == nil) {
        _nickName = [[UILabel alloc] init];
        _nickName.textAlignment = NSTextAlignmentLeft;
        _nickName.font = [UIFont boldSystemFontOfSize:15];
        _nickName.textColor = RGB(51, 51, 51);
    }
    return _nickName;
}

- (UIView *)secondContainer{
    if (_secondContainer == nil) {
        _secondContainer = [[UIView alloc] init];
    }
    return _secondContainer;
}

- (UILabel *)acquireMessageLabel{
    if (_acquireMessageLabel == nil) {
        _acquireMessageLabel = [[UILabel alloc] init];
        _acquireMessageLabel.textAlignment = NSTextAlignmentLeft;
        _acquireMessageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        _acquireMessageLabel.textColor = RGBA(51, 51, 51, 0.8);
    }
    return _acquireMessageLabel;
}

- (UILabel *)statusMessageLabel{
    if (_statusMessageLabel == nil) {
        _statusMessageLabel = [[UILabel alloc] init];
        _statusMessageLabel.textAlignment = NSTextAlignmentLeft;
        _statusMessageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        _statusMessageLabel.textColor = RGBA(51, 51, 51, 0.8);
    }
    return _statusMessageLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        _timeLabel.textColor = RGBA(51, 51, 51, 0.7);
    }
    return _timeLabel;
}

- (UIButton *)deleButton{
    if (_deleButton == nil) {
        _deleButton = [[UIButton alloc] init];
        [_deleButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"trash.png"]] forState:UIControlStateNormal];
        [_deleButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"trash.png"]] forState:UIControlStateHighlighted];
        [_deleButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"trash.png"]] forState:UIControlStateSelected];
        [_deleButton addTarget:self action:@selector(deleAction:) forControlEvents:UIControlEventTouchUpInside];
//        _deleButton.backgroundColor = [UIColor blueColor];
    }
    return _deleButton;
}

- (UIImageView *)statusImageView{
    if (_statusImageView == nil) {
        _statusImageView = [[UIImageView alloc] init];
        _statusImageView.backgroundColor = RGB(244, 53, 49);
        _statusImageView.layer.cornerRadius = [Adaptor returnAdaptorValue:10]/2;
    }
    return _statusImageView;
}

#pragma mark    删除会话
- (void)deleAction:(UIButton *)sender{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(deleteNoteListConversationWithCell:withIndexPath:)]) {
        [self.delegate deleteNoteListConversationWithCell:self withIndexPath:_indexPath];
    }
}
@end
