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


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
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
