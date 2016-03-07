//
//  LoginViewController.m
//  CartoonTime
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "LoginViewController.h"
#import <BmobSDK/BmobUser.h>
#import "ProgressHUD.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.navigationItem.title=@"登陆中心";
//    navCar.navigationBar.barTintColor = barColor;

    self.navigationController.navigationBar.barTintColor=barColor;
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self showBarButtonWithImage:@"back"];
    
    
    
    
}


//注册
- (IBAction)registerBtn:(id)sender {
    
    
    
    
}


//忘记密码
- (IBAction)forgetPasswordBtn:(id)sender {
    
    
    
    [BmobUser requestPasswordResetInBackgroundWithEmail:@"sdhas"];
    
    
}


//登陆
- (IBAction)loginBtn:(id)sender {
    
    [BmobUser loginInbackgroundWithAccount:self.userNameLabel.text andPassword:self.userPasswordlable.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            NSLog(@"%@",user);
            [ProgressHUD showSuccess:@"恭喜你，已经登录成功"];
            
            
            
        } else {
            NSLog(@"%@",error);
            [ProgressHUD showError:@"该用户不存在，请先注册"];
        }
    }];
    
    
    
    
}



#pragma mark --- 第三方登陆按钮


- (IBAction)thirdLoginQQ:(id)sender {
}



- (IBAction)thirdLoginWeixin:(id)sender {
}


- (IBAction)thirdLoginWeibo:(id)sender {
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
