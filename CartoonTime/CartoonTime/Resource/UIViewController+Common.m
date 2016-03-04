//
//  UIViewController+Common.m
//  Happyholiday
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "UIViewController+Common.h"

@implementation UIViewController (Common)

-(void)showBarButtonWithImage:(NSString *)imageName{
    
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *legtbtn=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=legtbtn;
    
    
}


-(void)backButtonAction{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}

- (void)showRightBarButtonWithTitle:(NSString *)title{
    
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 44, 44);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *legtbtn=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem=legtbtn;
    

    
    
    
}

@end
