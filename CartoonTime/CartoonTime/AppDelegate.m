//
//  AppDelegate.m
//  CartoonTime
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "AppDelegate.h"
//咨询控制器
#import "ConSultingViewController.h"
#import "CartoonViewController.h"
#import "SelfCenterViewController.h"
//注册第三方
#import <BmobSDK/Bmob.h>
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"



@interface AppDelegate ()

@end

@implementation AppDelegate



#pragma mark---分享代理
//微信
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}







- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    
    //注册bmob，否则登录，注册不成功
    
    [Bmob  registerWithAppKey:@"7f6c19f0c71c4aea3cf83ae7fa525593"];
    
    
    
    [ShareSDK connectQQWithAppId:@"1105113092" qqApiCls:[QQApiAddFriendObject class]];
    
    
     //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"1105113092"
                           appSecret:@"dEN3Ft2itXsfO6Fx"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    
    
    
    
    
    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:@"1127867699"
                               appSecret:@"f22b999fb27d0d3ee1e7ce7f33669ec3"
                             redirectUri:@"http://www.sharesdk.cn"];
    
    //    //添加腾讯微博应用 注册网址 http://dev.t.qq.com
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"];
    
    
        //微信登陆的时候需要初始化
    [ShareSDK connectWeChatWithAppId:@"wx948ab99ff0970cf6"
                           appSecret:@"824b1cd01b6315c884051128af6b7b7b"
                           wechatCls:[WXApi class]];
    
    
    
    
    UITabBarController *tabbar=[[UITabBarController alloc]init];
    
    
    
    ConSultingViewController *con=[[ConSultingViewController alloc]init];
    
    UINavigationController *navCon=[[UINavigationController alloc]initWithRootViewController:con];
    
    //导航栏颜色
    navCon.navigationBar.barTintColor = barColor;
    
    //navCon.tabBarItem.title=@"主页";
    navCon.tabBarItem.image=[UIImage imageNamed:@"ft_home_normal_ic"];
    UIImage *image=[UIImage imageNamed:@"ft_home_selected_ic"];
    //按图片原来状态显示
    navCon.tabBarItem.selectedImage=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //上左下右
    navCon.tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0, -6, 0);

    
    
    CartoonViewController *cartoon=[[CartoonViewController alloc]init];
    
    
    UINavigationController *navCar=[[UINavigationController alloc]initWithRootViewController:cartoon];
    
    navCar.tabBarItem.image=[UIImage imageNamed:@"ft_found_normal_ic"];
    UIImage *disimage=[UIImage imageNamed:@"ft_found_selected_ic"];
    //按图片原来状态显示
    navCar.tabBarItem.selectedImage=[disimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    navCar.tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0, -6, 0);

    //导航栏颜色
    navCar.navigationBar.barTintColor = barColor;
    
    
    
   
    SelfCenterViewController *center=[[SelfCenterViewController alloc]init];
    
    
    UINavigationController *navCenter=[[UINavigationController alloc]initWithRootViewController:center];
    
    
    
    //navCenter.tabBarItem.title=@"我的";
    navCenter.tabBarItem.image=[UIImage imageNamed:@"ft_person_normal_ic"];
    
    UIImage *mineimage=[UIImage imageNamed:@"ft_person_selected_ic"];
    //按图片原来状态显示
    navCenter.tabBarItem.selectedImage=[mineimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    navCenter.tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0, -6, 0);

    //导航栏颜色
    navCenter.navigationBar.barTintColor = [UIColor colorWithRed:241/255.0f green:158/255.0f blue:194/255.0f alpha:1.0];
    
    tabbar.viewControllers=@[navCon,navCar,navCenter];
    
    self.window.rootViewController=tabbar;
    
    
    
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
