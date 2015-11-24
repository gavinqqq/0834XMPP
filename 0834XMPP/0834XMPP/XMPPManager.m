//
//  XMPPMangaer.m
//  0834XMPP
//
//  Created by lanou3g on 15/11/24.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

/*
#import "XMPPManager.h"


typedef enum :NSUInteger{
    Connect4Login,
    Connect4Register,
}   ConnectType ;

@interface  XMPPManager ()<XMPPStreamDelegate>
//创建属性，记录登陆密码
@property (nonatomic ,copy) NSString * loginPassword;
//记录注册密码
@property (nonatomic ,copy) NSString * regPassword ;
//记录下一个连接
@property (nonatomic ,assign) ConnectType * connectType ;



@end

@implementation XMPPManager

static XMPPManager * manager = nil ;
+ (XMPPManager *)sharedManager{
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager =[XMPPManager new];
       
    });
    return manager;
}
- (instancetype)init{
    self =[super init];
    if (self) {
    //----------------配置通讯管道-------
    self.stream =[[XMPPStream alloc]init];
    //设置通信管道目标服务器地址
    _stream.hostName =kHostName;

    //设置完成之后才可以和服务器通信
    _stream.hostPort =kHostPort;
    //设置代理
    [_stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    }
    return self;

}

//登陆
- (void)xmppManagerLoginWithUserName:(NSString *)userName password:(NSString *)password{
    //记录登陆密码
    self.loginPassword =password;
    [self connectWithUserName:userName];
}
//xmpp 协议规定，连接时可以不告诉服务器密码，但是一定要告诉服务器是谁在连接它
- (void)connectWithUserName:(NSString *)userName{
   //根据一个用户名，构造一个xmppjid
    XMPPJID *myjid =[XMPPJID jidWithUser:userName domain:kDomin resource:kResource];
    
    //根据通信管道的jid
    _stream.myJID =myjid;
    //调用连接服务器
    [self connectToServer];
}

//注册
-(void)xmppmanagerRegisterWtihUserName:(NSString *)username password:(NSString *)password{
    //记录注册密码
    self.regPassword =password;
    //记录连接的目的
    self.connectType = Connect4Login;
    //连接服务器
    [self connectWithUserName:username];
    
    
}


//XMPPJid -XMPP系统中的用户类

//连接服务器
- (void)connectToServer{
    //先判断一下是否连接过服务器
    if ([_stream isConnected]) {
        NSLog(@"已经连接过了，先断开，再连接");
        [_stream disconnect];
    }
    //发起连接
    BOOL result = [_stream connectWithTimeout:30 error:nil];
    if (result) {
        NSLog(@"连接服务器成功");
    }else{
        NSLog(@"连接服务器失败");
    }
}
#pragma mark---XMPPStreamDelegate
//连接服务器成功的回调方法
- (void)xmppStreamDidSecure:(XMPPStream *)sender{
    NSLog(@"$$$$连接服务器成功$$$$---回调方法");
    switch (self.connectType) {
            
        case Connect4Login:
           [_stream authenticateWithPassword:self.loginPassword error:nil];
            break;
        case Connect4Register:
            [_stream registerWithPassword:self.regPassword error:nil];
        default:
            NSLog(@"忘记记录连接目的了");
            break;
    }
#warning 属性传回密码
    //在连接成功会发起登陆事件
   // [_stream authenticateWithPassword:self.loginPassword error:nil];
    //在连接之后注册
   // [_stream registerWithPassword:self.regPassword error:nil];
    
}
//连接超时的回调方法
-(void)xmppStreamConnectDidTimeout:(XMPPStream *)sender{

    NSLog(@"连接超时--回调方法");
}
//断开连接(或连接失败)的回调方法
-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    NSLog(@"断开连接---回调方法");
    if (error) {
        NSLog(@"%@",error);
    }
    //离线消息（离线通知）
    XMPPPresence * presence =[XMPPPresence presenceWithType:@"unavarlable"];
    //发送离线通知
    [_stream sendElement:presence];

}
//登陆成功的回调事件
-(void)xmppStream:(XMPPStream *)sender didAuthenticate:(DDXMLElement *)error{
    NSLog(@"登陆成功了哦！！！");
    //出席消息（上线通知）
    XMPPPresence * presence =[XMPPPresence presenceWithType:@"avarlable"];
    //发送上线通知
    [_stream sendElement:presence];

}

//登陆失败的回调事件
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    NSLog(@"登录失败：%@",error);
}

//注册成功的回调事件
-(void)xmppStreamDidRegister:(XMPPStream *)sender{
    NSLog(@"注册成功");
}
//
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    NSLog(@"注册失败，error%@",error);

}



@end
*/
#import "XMPPManager.h"

typedef enum: NSUInteger{
    
    Connect4Login,
    Connect4Register,
    
}ConnectType; //链接的目的

@interface XMPPManager ()<XMPPStreamDelegate>

//记录登陆密码
@property (nonatomic, retain) NSString *loginPassword;

//记录注册密码
@property (nonatomic, retain) NSString *registerPassword;

//记录一下链接的目的
@property (nonatomic, assign) ConnectType connectType;

@end

@implementation XMPPManager

static  XMPPManager *manager = nil;

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[XMPPManager alloc] init];
        
    });
    
    return manager;
}

- (instancetype)init{
    if (self = [super init]) {
        
        //------------配置通信管道---------------
        self.stream = [[XMPPStream alloc] init];
        
        //设置通信管道的目标服务器地址
        _stream.hostName = kHostName;
        
        //设置目标服务器 xmpp server 的端口
        _stream.hostPort = kHostPort;
        
        //设置完成后才可以和服务器通信
        //        [_stream connectWithTimeout:30 error:nil];
        
        //设置代理
        [_stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
    }
    return self;
}

//登入
- (void)xmppManagerLoginWithUserName:(NSString *)userName password:(NSString *)password{
    
    //记录登入密码
    self.loginPassword = password;
    
    //记录链接的目的
    self.connectType = Connect4Login;
    
    [self connectWithUserName:userName];
}
//注册
- (void)xmppmanagerRegisterWtihUserName:(NSString *)username password:(NSString *)password{
    //记录注册密码
    self.registerPassword = password;
    
    //记录链接的目的
    self.connectType = Connect4Register;
    
    //链接服务器
    [self connectWithUserName:username];
    
}

//xmpp 协议规定,链接时可以不告诉服务器密码,但是一定要告诉服务器是谁在链接它
- (void) connectWithUserName:(NSString *)userName{
    
    //根据一个用户名构造一个xmppjid
    XMPPJID *myjid = [XMPPJID jidWithUser:userName domain:kDomin resource:kResource];
    
    //设置通信管道的jid
    _stream.myJID = myjid;
    
    //链接服务器
    [self connectToServer];
    
}



//XMPPJid - xmpp系统中的用户类

//链接服务器
- (void)connectToServer{
    
    //先判断一下是否连接过服务器
    if ([_stream isConnected]) {
        
        NSLog(@"已经链接过了,先断开,在连接");
        [_stream disconnect];
    }
    
    BOOL result = [_stream connectWithTimeout:30 error:nil];
    
    if (result) {
        
        //        NSLog(@"链接服务器成功");
        
    }else{
        
        //        NSLog(@"链接服务器失败");
        
    }
}

#pragma mark -- XMPPStreamDelegate
//链接服务器成功的回调方法
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    
    NSLog(@"链接服务器成功 -- 回调方法");
    
    switch (self.connectType) {
        case Connect4Login:
            //在链接成功后发起登陆事件
            [_stream authenticateWithPassword:self.loginPassword error:nil];
            break;
        case Connect4Register:
            //在链接成功后进行注册
            [_stream registerWithPassword:self.registerPassword error:nil];
            break;
        default:
            NSLog(@"一定是忘记 记录链接的目的了");
            break;
    }
    
    
    
}
//链接超时的回调方法
- (void)xmppStreamConnectDidTimeout:(XMPPStream *)sender{
    
    NSLog(@"链接超时 -- 回调方法");
}
//断开链接的回调方法
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    
    NSLog(@"断开链接 -- 回调方法");
    
    if (error) {
        NSLog(@"%@",error);
    }
    //出席消息(下线通知)
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    
    //发送下线通知
    [_stream sendElement:presence];
}
//登陆成功的回调事件
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    
    
    NSLog(@"登陆成功");
    //出席消息(上线通知)
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"available"];
    
    //发送上线通知
    [_stream sendElement:presence];
}
//登入失败的回调事件
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    
    NSLog(@"登陆失败:%@",error);
    
}
//注册成功的回调事件
- (void)xmppStreamDidRegister:(XMPPStream *)sender{
    
    NSLog(@"注册成功");
}
//注册失败回调事件
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    
    NSLog(@"注册失败,error:%@",error);
};


@end