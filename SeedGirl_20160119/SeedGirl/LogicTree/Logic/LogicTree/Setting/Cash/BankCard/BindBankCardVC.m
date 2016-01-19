//
//  BindBankCardVC.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/25.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "BindBankCardVC.h"
#import "BindBankCardView.h"
typedef void (^BindBankCardVCOKActionBlockType)();
@interface BindBankCardVC ()
@property (nonatomic, strong) BindBankCardView                    *rootView;
@property (nonatomic, strong) UIAlertController            *alertController;
@property (nonatomic, copy)   BindBankCardVCOKActionBlockType okActionBlock;
@end
@implementation BindBankCardVC
#pragma mark    loadView
- (void)loadView{
    self.rootView = [[BindBankCardView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view     = self.rootView;
}

#pragma mark    viewDidLoad
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(240, 242, 245);
    [self addFunctions];
}

#pragma mark    添加功能
- (void)addFunctions{
    WeakSelf;
    self.rootView.localBlock = ^(){
        [weakSelf presentViewController:weakSelf.alertController animated:YES completion:nil];
    };
    
    self.okActionBlock = ^(){
        [weakSelf bindBankCardAction];
    };
}

#pragma mark    绑定银行卡行为
- (void)bindBankCardAction{
    WeakSelf;
    NSMutableDictionary *parameterDict = [NSMutableDictionary dictionary];
    [parameterDict setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameterDict setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameterDict setValue:[NSNumber numberWithInteger:0] forKey:@"type"];
    [parameterDict setValue:self.rootView.bankRow.inputContentTextFiled.text forKey:@"card_type"];
    [parameterDict setValue:self.rootView.accountRow.inputContentTextFiled.text forKey:@"card_number"];
    [parameterDict setValue:self.rootView.nameRow.inputContentTextFiled.text forKey:@"card_realname"];
    [parameterDict setValue:self.rootView.mobilePhoneNum.inputContentTextFiled.text forKey:@"card_phone"];
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_bink_bank"] parameters:parameterDict success:^(id responseObject) {
        //拿到type后 判断是绑定还是解绑
        if (publishProtocol(responseObject) == 0) {
            NSLog(@"绑定成功");
            [weakSelf popCurrentPageAction];
        }else if(publishProtocol(responseObject) == -21){
            NSLog(@"已绑定");
        }else{
            NSLog(@"绑定失败");
        }
    } failure:^(NSError *error) {
        NSLog(@"绑定失败");
    }];
}

#pragma mark    懒加载对象
- (UIAlertController *)alertController{
    if (_alertController == nil) {
        _alertController = [UIAlertController alertControllerWithTitle:@"请您确认帐号信息" message:[self.rootView getConfirmMessage] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (_okActionBlock) {
                _okActionBlock();
            }
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [_alertController addAction:cancleAction];
        [_alertController addAction:okAction];
    }
    return _alertController;
}
@end