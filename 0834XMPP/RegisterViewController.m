//
//  RegisterViewController.m
//  0834XMPP
//
//  Created by lanou3g on 15/11/24.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "RegisterViewController.h"
#import "XMPPManager.h"
#import "MBProgressHUD.h"

@interface RegisterViewController ()<MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UITextField *text4name;
@property (weak, nonatomic) IBOutlet UITextField *text4PassWord;
//小菊花
@property (nonatomic ,retain) MBProgressHUD * HUD ;

@end

@implementation RegisterViewController
- (IBAction)action4Register:(id)sender {
    [[XMPPManager sharedManager]xmppmanagerRegisterWtihUserName:self.text4name.text password:self.text4PassWord.text];
    [self progressHUD];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//小菊花
-(void)progressHUD{
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //_HUD.backgroundColor = [UIColor redColor];
    _HUD.labelText = @"注册";
    _HUD.delegate = self;
    _HUD.detailsLabelText = @"正在注册";
    _HUD.dimBackground = YES;
    [_HUD hide:YES afterDelay:1.0];
    

}
//小菊花消失
- (void)hudWasHidden:(MBProgressHUD *)hud{
    
    [hud removeFromSuperview];
    hud = nil;
}

@end
