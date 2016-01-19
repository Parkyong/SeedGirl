//
//  RecordTableViewCell.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/26.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "CashRecordCell.h"
#import "CashRecordData.h"

@interface CashRecordCell ()
//时间
@property (nonatomic, strong) UILabel *timeLabel;
//金钱
@property (nonatomic, strong) UILabel *moneyLabel;
//状态
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation CashRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSubviews];
    }
    return self;
}

//加载子视图
- (void)loadSubviews {
    [self addSubview:self.timeLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.statusLabel];
    
    [self addConstraints];
}

//添加约束
- (void)addConstraints {
    WeakSelf;
    //时间
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(10.0f);
        make.right.equalTo(weakSelf).with.offset(-10.0f);
        make.height.equalTo(weakSelf.mas_height).multipliedBy(0.5);
    }];
    //金钱
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timeLabel.mas_bottom);
        make.left.equalTo(weakSelf.timeLabel.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.lessThanOrEqualTo(weakSelf.mas_width).multipliedBy(0.5);
    }];
    //状态
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.moneyLabel.mas_centerY);
        make.left.equalTo(weakSelf.moneyLabel.mas_right).with.offset(2.0f);
        make.right.equalTo(weakSelf).with.offset(-10);
    }];
}

#pragma mark - Main
//设置显示数据
- (void)setShowData:(CashRecordData *)data {
    self.timeLabel.text = [NSString stringWithFormat:@"提现时间：%@", data.recordTime];
    self.moneyLabel.text = [NSString stringWithFormat:@"提现额：￥%ld", (long)data.recordMoney];
    
    //0正在审核1审核通过2成功-1失败
    switch (data.recordStatus) {
        case 0:
        {
            self.statusLabel.text = @"正在审核";
            self.statusLabel.textColor = [UIColor grayColor];
            break;
        }
        case 1:
        {
            self.statusLabel.text = @"审核通过，转账中...";
            self.statusLabel.textColor = [UIColor grayColor];
            break;
        }
        case 2:
        {
            self.statusLabel.text = @"转账成功";
            self.statusLabel.textColor = [UIColor grayColor];
            break;
        }
        case -1:
        {
            self.statusLabel.text = @"转账失败，钻石已回退\n如有疑问请联系客服";
            self.statusLabel.textColor = [UIColor redColor];
            break;
        }
        default:
            break;
    }
}

#pragma mark - lazyload
//时间
- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = RGB(51, 51, 51);
        _timeLabel.font = [UIFont systemFontOfSize:15.0f];
        _timeLabel.text = @"提现时间：";
    }
    return _timeLabel;
}
//金钱
- (UILabel *)moneyLabel {
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.backgroundColor = [UIColor clearColor];
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        _moneyLabel.textColor = RGB(51, 51, 51);
        _moneyLabel.font = [UIFont systemFontOfSize:15.0f];
        _moneyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _moneyLabel.numberOfLines = 1;
        _moneyLabel.text = @"提现额：￥";
    }
    return _moneyLabel;
}
//状态
- (UILabel *)statusLabel {
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textAlignment = NSTextAlignmentRight;
        _statusLabel.textColor = [UIColor grayColor];
        _statusLabel.font = [UIFont systemFontOfSize:13.0f];
        _statusLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _statusLabel.numberOfLines = 2;
        _statusLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds);
    }
    return _statusLabel;
}

@end
