//
//  XMPPMangaer.h
//  0834XMPP
//
//  Created by lanou3g on 15/11/24.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  xmpp  管理类
 
 
 */
@interface XMPPManager : NSObject
/**
 *  xmpp 通讯管道（就像是电话中的电话线）
    通信管道的另一端是服务器
 
 */
@property (nonatomic ,strong) XMPPStream * stream ;
/**
 *  单例方法
 *
 *  @return 单例对象
 */
+ (XMPPManager *)sharedManager;
/**
 *  登陆方法
 *
 *  @param userName 登录用户名
 *  @param password 登陆密码
 */
- (void)xmppManagerLoginWithUserName:(NSString *)userName password:(NSString *)password;
/**
 *  注册事件
 *
 *  @param username 用户名 
 *  @param password 密码
 */

-(void)xmppmanagerRegisterWtihUserName:(NSString *)username password:(NSString *)password;
@end
