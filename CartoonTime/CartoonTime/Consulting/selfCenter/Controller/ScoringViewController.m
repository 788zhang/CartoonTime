//
//  ScoringViewController.m
//  CartoonTime
//评分视图
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "ScoringViewController.h"
#import "LPLevelView.h"
@interface ScoringViewController ()

@property(nonatomic, strong)  LPLevelView *lplevel;
@property(nonatomic, strong) UILabel *currentLabel;

@property(nonatomic, strong) UILabel *scrolingLabel;

@end

@implementation ScoringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title=@"评分中心";
    
    [self.view addSubview:self.lplevel];
    [self.view addSubview:self.currentLabel];
    [self.view addSubview:self.scrolingLabel];
    
    self.currentLabel.text=[NSString stringWithFormat:@"当前评分为：%.2f",self.lplevel.level];
}


- (UILabel *)scrolingLabel{
    
    if (_scrolingLabel==nil) {
        _scrolingLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, KScreenHeight/3, 80, 44)];
        
        _scrolingLabel.text=@"请评分:";
    }
    
    return _scrolingLabel;
    
}



- (UILabel *)currentLabel{
    
    if (_currentLabel == nil) {
        _currentLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight*2/3-KScreenHeight/3/2, KScreenWidth-20, 44)];
        self.currentLabel.text=@"当前评分为：";
        
        _currentLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _currentLabel;
}


- (LPLevelView *)lplevel{
    if (_lplevel==nil) {
        
        //纯代码初始化
        self.lplevel = [[LPLevelView alloc]init];
        self.lplevel.frame = CGRectMake(100, KScreenHeight/3, KScreenWidth-100-20,44);
        self.lplevel.iconColor = [UIColor orangeColor];
        self.lplevel.iconSize = CGSizeMake(20, 20);
        self.lplevel.canScore = YES;
        self.lplevel.animated = YES;
        self.lplevel.level = 3.5;
        
        __block ScoringViewController *selfblock=self;
        [self.lplevel setScoreBlock:^(float level) {
            NSLog(@"打分：%f", level);
            
             selfblock.currentLabel.text=[NSString stringWithFormat:@"当前评分为：%.2f",selfblock.lplevel.level];
        }];
        
    }
    
    return _lplevel;
    
    
    
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
