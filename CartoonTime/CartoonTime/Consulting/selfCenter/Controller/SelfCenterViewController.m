//
//  SelfCenterViewController.m
//  CartoonTime
//

//需求分析： 登陆中心，注册，找回密码，第三方授权，手机短信验证，qq邮箱验证



//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "SelfCenterViewController.h"
#import "LoginViewController.h"
#import <MessageUI/MessageUI.h>
#import "ProgressHUD.h"
#import "ScoringViewController.h"
#import <Reachability.h>




//分享头文件
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"







@interface SelfCenterViewController ()<UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate>

@property (readonly, nullable) id sender;


@property(nonatomic, strong) Reachability *conn;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIButton *headImageBtn;

@property(nonatomic, strong) UILabel *nikeNameLabel;
@property(nonatomic, strong) NSMutableArray *cellArr;


@end

@implementation SelfCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title=@"个人中心";
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets=YES;
    
    [self tableHeadView];
    
    
    
    
    
    
    
    
    
}

- (NSMutableArray *)cellArr{
    
    if (_cellArr==nil) {
        _cellArr=[[NSMutableArray alloc]initWithObjects:@"缓存大小",@"意见反馈",@"分享好友",@"给我评分",@"检测网络", @"检测版本",@"帮助",nil];

    }
    return _cellArr;
}


- (void)tableHeadView{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 210)];
    
    view.backgroundColor=barColor;
    [view addSubview:self.headImageBtn];
    
    [view addSubview:self.nikeNameLabel];
    
    self.tableView.tableHeaderView=view;
    
    
    
    
}

#pragma mark ---- 懒加载


- (UILabel *)nikeNameLabel{
    
    
    if (_nikeNameLabel == nil) {
        self.nikeNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(35+KScreenWidth/3, KScreenWidth/6+11 , KScreenWidth*2/3, 44)];
        
        self.nikeNameLabel.text=@"欢迎来到动漫时代";
        self.nikeNameLabel.textColor=[UIColor whiteColor];
    }
    return _nikeNameLabel;
}



- (UIButton *)headImageBtn{
    
    
    if (_headImageBtn == nil) {
        self.headImageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.headImageBtn.frame=CGRectMake(20, 30, KScreenWidth/3, KScreenWidth/3);
        self.headImageBtn.layer.cornerRadius=KScreenWidth/6;
        self.headImageBtn.clipsToBounds=YES;
        [self.headImageBtn setTitle:@"登陆/注册" forState:UIControlStateNormal];
        [self.headImageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.headImageBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.headImageBtn.backgroundColor=[UIColor whiteColor];
        
    }
    return _headImageBtn;
}

/**
 *  登陆注册按钮
 */
- (void)login{
    
    UIStoryboard *loginSB=[UIStoryboard storyboardWithName:@"LoginView" bundle:nil];
    
    LoginViewController *login=[loginSB instantiateViewControllerWithIdentifier:@"zhang"];
    
    
    
    [self.navigationController presentViewController:login animated:YES completion:nil];
    
    
}


- (UITableView *)tableView{
    
    if (_tableView== nil) {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        
        
        
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        
        
        
        
        
    }
    
    return _tableView;
}






#pragma mark ----UITableViewDelegate,UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.cellArr.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *strID=@"zhang";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strID];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strID];
        
    }
    
    cell.imageView.image=[UIImage imageNamed:@"icon_like"];
    cell.textLabel.text=self.cellArr[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark-----刷新页面是需要查看缓存

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    SDImageCache *cache=[SDImageCache sharedImageCache];
    NSInteger cacheSize=[cache getSize];
    NSString *cacheStr=[NSString stringWithFormat:@"缓存大小(%.2fM)",(float)(cacheSize/1024/1024)];
    
    [self.cellArr replaceObjectAtIndex:0 withObject:cacheStr];
    
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:0 inSection:0];
    //刷新区域
    [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationLeft];
    
    
    
    
    
    
}

#pragma mark ----发送邮件

//邮件发送方法:
-(void)displayComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    //设置主题
    [picker setSubject:@"用户反馈"];
    
    //设置收件人
    NSArray *receive = [NSArray arrayWithObjects:@"850944623@qq.com",
                        nil];
    
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"1342236145@qq.com",nil];
    NSArray *bccRecipients = [NSArray arrayWithObjects:@"1342236145@qq.com",
                              nil];
    
    [picker setToRecipients:receive];
    [picker setCcRecipients:ccRecipients];
    [picker setBccRecipients:bccRecipients];
    
    
    // 设置邮件发送内容
    NSString *emailBody = @"请反馈你宝贵的意见，让我们继续改进";
    [picker setMessageBody:emailBody isHTML:NO];
    
    //邮件发送的模态窗口
    [self presentViewController:picker animated:YES completion:nil];
}

//邮件发送完成调用的方法:


-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: //取消
            NSLog(@"MFMailComposeResultCancelled-取消");
            break;
        case MFMailComposeResultSaved: // 保存
            NSLog(@"MFMailComposeResultSaved-保存邮件");
            break;
        case MFMailComposeResultSent: // 发送
            NSLog(@"MFMailComposeResultSent-发送邮件");
            break;
        case MFMailComposeResultFailed: // 尝试保存或发送邮件失败
            NSLog(@"MFMailComposeResultFailed: %@...",[error localizedDescription]);
            break;
    }
    
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark----“缓存大小",@"意见反馈",@"分享好友",@"给我评分",@"检测网络", @"检测版本",@"帮助"的点击方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            
        {
            
        UIAlertController *aler=[UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要清除缓存？" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionAletOK=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
                
                SDImageCache *cache=[SDImageCache sharedImageCache];
                [cache clearDisk];
                
                NSInteger cacheSize=[cache getSize];
                
                NSString *cacheStr=[NSString stringWithFormat:@"清除缓存（%.2fM）",(float)cacheSize/1024/1024];
                
                [self.cellArr replaceObjectAtIndex:0 withObject:cacheStr];
                
                NSIndexPath *indexpath=[NSIndexPath indexPathForRow:0 inSection:0];
                
                [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationLeft];
            }];
            UIAlertAction *actionAletCancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            
            [aler addAction:actionAletOK];
            [aler addAction:actionAletCancel];
            
            [self presentViewController:aler animated:YES completion:nil];

        }
            
            
            break;
        case 1:{
            //意见反馈
            
            //发送邮件
            [self displayComposerSheet];

            
        }
            
            break;
        case 2:
        {
            //分享
            
            [self shareThird];
            
            
        }
          
            
            
            break;
        case 3:
            
        {
            //评价
            
            
            ScoringViewController *scoring=[[ScoringViewController alloc]init];
            
            [self.navigationController pushViewController:scoring animated:YES];
            
            
            
            
            
            
        }
        break;
        case 4:
        {   //检测网络
            
            //网络检测
            
            
            
            Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
            
            
           
            [[NSNotificationCenter defaultCenter] addObserver:self
                selector:@selector(reachabilityChanged:)
            name:kReachabilityChangedNotification object:nil];
            
            [reach startNotifier];
            
           
            
        }
            break;
        case 5:
        {  //检测版本
             [self checkAppVersion];
            
            
        }
            break;
        case 6:
        {   //帮助
            [ProgressHUD showSuccess:@"请注册，登陆，获取更多内容"];
            
           
            
        }
            break;


            
        default:
            break;
    }
    
    
}

#pragma mark--- 网络判断
- (void) reachabilityChanged: (NSNotification*)note {
    Reachability * reach = [note object];
    
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            [ProgressHUD showError: @"网络不可用"];
            break;
        case ReachableViaWiFi:
            [ProgressHUD showSuccess:@"当前通过wifi连接"];
            break;
        case ReachableViaWWAN:
            [ProgressHUD showSuccess:@"当前通过2g或3g连接"];
            break;
            
        default:
            break;
    }
    
    
    
  
}




#pragma mark ---分享

-(void)shareThird{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ios" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"动漫时代"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    
    [container setIPadContainerWithView:_sender arrowDirect:UIPopoverArrowDirectionUp];
    
    
    
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
 
    
    
    
    
}







//版本请求成功
-(void)checkAppVersion{
    
    [ProgressHUD showSuccess:@"你已经是最新版本"];
    
    
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
