//
//  ResigerViewController.m
//  CartoonTime
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "ResigerViewController.h"
#import <BmobSDK/BmobUser.h>
#import "ProgressHUD.h"



@interface ResigerViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;


@property (weak, nonatomic) IBOutlet UITextField *userPassword;


@property (weak, nonatomic) IBOutlet UITextField *userRewritePassword;


@end

@implementation ResigerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=barColor;
    self.navigationItem.title=@"注册";
    [self showBarButtonWithImage:@"back"];
 
    
    
}


- (IBAction)resignBtn:(id)sender {
    
    //如果为true
    if ([self verifyInput]) {
        BmobUser *bUser=[[BmobUser alloc]init];
        
        ZPFLog(@"%@%@",self.userName.text,self.userPassword.text)
        
        [bUser setUsername:self.userName.text];
        [bUser setPassword:self.userPassword.text];
      
       
        [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
            if (isSuccessful){
               
                
                [ProgressHUD showSuccess:@"恭喜你，你已经注册成功"];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                
            } else {
                
                [ProgressHUD showError:@"改用户已经注册"];
              
              
            }
        }];

        
        
        
    }
    
    
    
    
    
    
    
    
}




-(BOOL)verifyInput{
    //判断输入不能为空
    if ([self.userName.text stringByReplacingOccurrencesOfString:@" " withString:@""].length<=0 &&
        [self.userPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""].length<=0&&
        [self.userPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""].length<=0)
    {
        [ProgressHUD showError:@"输入不能为空"];
        return NO;
        
    }//判断俩次输入密码是否一致
    if (![self.userPassword.text isEqualToString:self.userRewritePassword.text]) {
        [ProgressHUD showError:@"俩次输入密码不一致"];
        return NO;
    }//判断密码长度是否大于6；
    if ([self.userPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""].length<6) {
        [ProgressHUD showError:@"密码最小长度为6"];
        return NO;
    }
    
    
    
    
    return YES;

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
