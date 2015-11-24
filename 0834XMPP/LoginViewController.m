//
//  LoginViewController.m
//  0834XMPP
//
//  Created by lanou3g on 15/11/24.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "LoginViewController.h"
#import "XMPPManager.h"
#import "JDStatusBarNotification.h"

@interface LoginViewController ()<XMPPStreamDelegate>
@property (weak, nonatomic) IBOutlet UITextField *text4name;
@property (weak, nonatomic) IBOutlet UITextField *text4PassWord;

@property (nonatomic ,assign) CGFloat  progressTime ;



@end

@implementation LoginViewController
- (IBAction)action4login:(id)sender {
    //1设置通信管道的目标地址和端口->2,设置通信管道的创建者->3连接目标服务器
    [[XMPPManager sharedManager]xmppManagerLoginWithUserName:self.text4name.text password:self.text4PassWord.text];
    //点击登陆
    [self progrressBar];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    //取到单例类的通讯管道
    XMPPStream * stream =[XMPPManager sharedManager].stream;
    //设置通讯管道的代理为这个控制器
    [stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}
#pragma makr ----加载条
-(void)progrressBar{
    
    //三秒后消失
    [JDStatusBarNotification dismissAfter:3];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(clickTime) userInfo:nil repeats:YES];
    self.progressTime =0;
    NSString *str =[JDStatusBarNotification addStyleNamed:@"正在加载" prepare:^JDStatusBarStyle *(JDStatusBarStyle *style) {
        //改变bar的状态
        style.barColor =[UIColor lightGrayColor];
        style.textColor=[UIColor lightTextColor];
        style.font =[UIFont systemFontOfSize :17];
        //改变阴影的状态
        style.textShadow = [[NSShadow alloc]init];
        style.textShadow.shadowColor = [UIColor greenColor];
       // style.textShadow.shadowOffset = CGSizeMake(2, 2);
        //进图条的状态
        style.progressBarColor = [UIColor blueColor];
        style.progressBarHeight = 20;
        style.progressBarPosition =JDStatusBarProgressBarPositionCenter;
        style.animationType = JDStatusBarAnimationTypeFade;
        return style;
    }];
    [JDStatusBarNotification showWithStatus:str styleName:@"正在加载"];
}
-(void)clickTime{
    _progressTime+=(1.0 / 30.0);
    [JDStatusBarNotification showProgress:_progressTime];
}
#pragma mark ----代理
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"登录成功");
    //取到模态
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    //当登陆成功消失
    [JDStatusBarNotification dismiss];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
