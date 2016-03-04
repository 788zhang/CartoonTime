//
//  DetailWebViewController.m
//  CartoonTime
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "DetailWebViewController.h"
#import "ProgressHUD.h"
@interface DetailWebViewController ()

@end

@implementation DetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButtonWithImage:@"back"];
    
    
   
    self.view.backgroundColor=[UIColor whiteColor];
    
    if (self.isCell == YES) {
        [self loadCellData];
    }else{
        
        //加载网页
        [self loadWebView];

    }
    
    
    
}


-(void)loadCellData{
    self.navigationItem.title=self.model.title;
    
    
    UIWebView *webview=[[UIWebView alloc]initWithFrame:self.view.frame];
    
    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.model.shareUrl]];
    [webview loadRequest:request];
    [self.view addSubview:webview];
    
    
    
}

//轮播图的详细Web
-(void)loadWebView{
    
    NSString *str=self.messageinfo[@"content"];
    
    if (str.length<=0) {
        
        [ProgressHUD showError:@"加载失败"];
        
    }else{
        
        [ProgressHUD showSuccess:@"加载成功"];
        
        self.navigationItem.title=self.messageinfo[@"title"];
        
        UIWebView *webView=[[UIWebView alloc]initWithFrame:self.view.frame];
        
        
        [webView loadHTMLString:str baseURL:nil];
        [self.view addSubview:webView];

        
        
    }
    
    
    
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
