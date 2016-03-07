//
//  VarifyEmailViewController.m
//  CartoonTime
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "VarifyEmailViewController.h"
#import <BmobSDK/BmobUser.h>
@interface VarifyEmailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTF;





@end

@implementation VarifyEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=barColor;
    self.navigationItem.title=@"找回密码";
    [self showBarButtonWithImage:@"back"];

}

//邮箱验证
- (IBAction)varifyEmailBtn:(id)sender {
    
    
    [BmobUser requestPasswordResetInBackgroundWithEmail:self.emailTF.text];
    
    
    
    
    
    
    
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
