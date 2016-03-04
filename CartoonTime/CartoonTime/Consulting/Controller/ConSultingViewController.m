//
//  ConSultingViewController.m
//  CartoonTime
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//
//资讯视图
#import "ConSultingViewController.h"
#import "ConSuleingTableViewCell.h"
#import "ConSultingModel.h"

//上拉加载，下拉刷新
//第一步：加入头文件

#import "PullingRefreshTableView.h"

//第二个详细页面
#import "DetailWebViewController.h"

//第二步：加入协议
@interface ConSultingViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,PullingRefreshTableViewDelegate>

//第三步:定义属性
{
    
    NSInteger _pageCount;//定义请求加载的页面
    
}
//定义refresh是为了判断刷新是移除数组中全部数据
@property(nonatomic, assign) BOOL refresh;

@property(nonatomic, strong) PullingRefreshTableView *refreshTableView;




//轮播图数组
@property(nonatomic, strong) NSMutableArray *advertisementArray;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIPageControl *pageControll;
@property(nonatomic, strong) NSTimer *timer;
//cell数据属性
@property(nonatomic, strong) NSMutableArray *cellArr;



@end

@implementation ConSultingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    self.navigationItem.title=@"动漫时代";
    
    _pageCount=1;

    [self startTimer];
    [self getQueueRequire];
    [self.view addSubview:self.refreshTableView];
    //启动加载
    [self.refreshTableView launchRefreshing];
    
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    
    //每次刷新页面都启动
    [self startTimer];
    
}


#pragma mark ----网络队列请求

-(void)getQueueRequire{
    
    
    
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    
    
    [manager GET:KCartoonApp parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // ZPFLog(@"%@",responseObject);
        
        NSDictionary *rootDic=responseObject;
        
        NSArray *resultArr=rootDic[@"results"];
        
        
        if (self.refresh==YES) {
            if (self.advertisementArray.count>0) {
                [self.advertisementArray removeAllObjects];
            }
            
        }
        
        
        
        
        for (NSDictionary *dic in resultArr) {
            ConSultingModel *model=[[ConSultingModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            
            
            [self.advertisementArray addObject:model];
            
            
        }
        
        [self configTableViewheadView];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZPFLog(@"%@",error);
    }];
    

    
    
    
    
    
    
    AFHTTPSessionManager *managerCell=[AFHTTPSessionManager manager];
    
    managerCell.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    
    
    [managerCell GET:[NSString stringWithFormat:@"%@page=%ld&",KCell,(long)_pageCount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      //  ZPFLog(@"%@",responseObject);
        
        
        NSDictionary *rootDic=responseObject;
        
        NSArray *resultArr=rootDic[@"results"];
        
        if (self.refresh==YES) {
            if (self.cellArr.count>0) {
                [self.cellArr removeAllObjects];
            }
            
        }
        

        
        
        for (NSDictionary *dic in resultArr) {
            
            ConSultingModel *model=[[ConSultingModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.cellArr addObject:model];
            
            
        }
        
        
        
        
        
        
     
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZPFLog(@"%@",error);
    }];
    
    
    

    
    
   

    
    
    
    
    //完成加载
    
    [self.refreshTableView tableViewDidFinishedLoading];
    
    self.refreshTableView.reachedTheEnd=NO;
    

    [self.refreshTableView reloadData];




    
    
    
}









//第四步：懒加载

- (PullingRefreshTableView *)refreshTableView{
    
    if (_refreshTableView == nil) {
        _refreshTableView=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 44, KScreenWidth, KScreenHeight) pullingDelegate:self];
        
        _refreshTableView.delegate=self;
        _refreshTableView.dataSource=self;
         _refreshTableView.rowHeight=KScreenWidth*2/5*2/3;
        
    }
    
    return _refreshTableView;
    
}


#pragma mark ---PullingRefreshTableViewDelegate,,,上拉下拉

//上拉加载
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    _pageCount+=1;
    
    
    self.refresh=NO;
    
    [self performSelector:@selector(getQueueRequire) withObject:nil afterDelay:1.f];
}



//table开始下拉开始调用
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    _pageCount=1;
    self.refresh=YES;
    
    [self performSelector:@selector(getQueueRequire) withObject:nil afterDelay:1.0];
    
    
    
    
}


//刷新完成时间
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    NSLog(@"%s - [%d]",__FUNCTION__,__LINE__);
    
    return [HWTools getSystemNowdate];
}



#pragma mark - ScrollView Method
//手指开始拖动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.refreshTableView tableViewDidScroll:scrollView];
}

//手指结束拖动方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.refreshTableView tableViewDidEndDragging:scrollView];
}




#pragma mark ----自定义TableView头部
-(void)configTableViewheadView{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 186)];
    
    
    
    [view addSubview:self.scrollView];
    
    [view addSubview:self.pageControll];
    
    self.pageControll.numberOfPages=self.advertisementArray.count;
    
    for (int i=0; i<self.advertisementArray.count; i++) {
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth*i, 0, KScreenWidth, 186)];
        
        
        ConSultingModel *model=self.advertisementArray[i];
        
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:nil];
        imageView.userInteractionEnabled=YES;
        
        [self.scrollView addSubview:imageView];
        
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*i+10, 153, KScreenWidth-100, 33)];
        label.font=[UIFont systemFontOfSize:16];
        label.textColor=[UIColor whiteColor];
        label.text=model.title;
        [self.scrollView addSubview:label];
        
        
        
        UIButton *touchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        touchBtn.frame=imageView.frame;
        touchBtn.tag=100+i;
        
        [touchBtn addTarget:self action:@selector(touchAdvertisement:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.scrollView addSubview:touchBtn];
        //启动定时器
        [self startTimer];
        
        
        
        
        
    }
       
    self.refreshTableView.tableHeaderView=view;
    
}

#pragma mark-----点击不同的轮播图进入不同的界面
-(void)touchAdvertisement:(UIButton *)btn{
    
    DetailWebViewController *detail=[[DetailWebViewController alloc]init];
    
    
    ConSultingModel *model=self.advertisementArray[btn.tag-100];
    
    
    
    
    detail.messageinfo=model.messageinfo;
    [self.navigationController pushViewController:detail animated:YES];
    
    
    
    
}



#pragma mark --- lazy Loading



- (NSMutableArray *)cellArr{
    
    if (_cellArr == nil) {
        _cellArr=[[NSMutableArray alloc]init];
    }
    return _cellArr;
}



- (NSMutableArray *)advertisementArray{
    
    
    if (_advertisementArray == nil) {
        _advertisementArray=[[NSMutableArray alloc]init];
    }
    return _advertisementArray;
    
}



- (UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        
        
        //添加轮播图
        self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 186)];
        
        self.scrollView.delegate=self;
        
        self.scrollView.contentSize=CGSizeMake(self.advertisementArray.count*KScreenWidth, 186);
        
        
        //整平滑动
        self.scrollView.pagingEnabled=YES;
        //不显示水平方向滚动条
        self.scrollView.showsHorizontalScrollIndicator=NO;
        
        
    }
    
    
    return _scrollView;
}



- (UIPageControl *)pageControll{
    
    if (_pageControll == nil) {
        
        //创建小原点
        
        self.pageControll=[[UIPageControl alloc]initWithFrame:CGRectMake(KScreenWidth-100, 186-33, 70, 33)];
        
        
        
        self.pageControll.currentPageIndicatorTintColor=[UIColor redColor];
        [self.pageControll addTarget:self action:@selector(pageSelecAction:) forControlEvents:UIControlEventValueChanged];
        
        
    }
    
    return _pageControll;
}









#pragma mark ----首页轮播图的方法

//轮播图定时器方法
-(void)startTimer{
    
    //防止定时器重复创建
    if (self.timer != nil) {
        return;
    }
    
    self.timer=[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(rollAnimation) userInfo:nil repeats:YES];
    
    // 添加到运行循环
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    
}

//每两秒执行一次
-(void)rollAnimation{
    
    
    NSInteger page=self.pageControll.currentPage+1 ;
    // count 》0  是防止数组为0，导致程序崩溃
    if (self.advertisementArray.count>0) {
        
        
        NSInteger curentPage = page % self.advertisementArray.count;
        
        self.pageControll.currentPage = curentPage;
        
        // 根据页数，调整滚动视图中的图片位置 contentOffset
        CGFloat x = self.pageControll.currentPage * KScreenWidth;
        [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
        
        
        
    }
    
    
    
}
//当手动去滑动Scroller的时候，定时器依然在计算时间，可能我们刚刚滑动到下一页，定时器时间又刚好触发，导致在当前页停留时间不到2秒
//解决方案在scroller开始移动的时候结束定时器
//在scroller结束的时候启动定时器
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    
    //停止计时器
    
    [self.timer invalidate];
    
    self.timer =nil;//
    
    
}










- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //第一步：获取scroller的页面宽度
    
    CGFloat pageWith=self.scrollView.frame.size.width;
    //第二步：获取scroller的偏移量
    
    CGPoint offset=self.scrollView.contentOffset;
    //第三步：通过偏移量和页面宽度计算出当前页
    
    NSInteger pageNumber=offset.x/pageWith;
    self.pageControll.currentPage=pageNumber;
    
    
    
}


-(void)pageSelecAction:(UIPageControl *)page{
    
    
    //第一步：获取pagecontrol点击的第几个页面
    NSInteger num =  page.currentPage;
    //第二步：获取页面的宽度：
    CGFloat pageWidth=self.scrollView.frame.size.width;
    //让scrollview滚动到第几页
    self.scrollView.contentOffset=CGPointMake(num * pageWidth, 0);
    
    
    
    
    
}







#pragma mark --UITableViewDataSource,

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.cellArr.count;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier=@"zhang";
    
    ConSuleingTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell=[[ConSuleingTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:identifier];
    }
    
    cell.model=self.cellArr[indexPath.row];
    
    return cell;
}


#pragma mark ----UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DetailWebViewController *detail=[[DetailWebViewController alloc]init];
    
   
    detail.isCell=YES;
   
    detail.model=self.cellArr[indexPath.row];
   
    
    [self.navigationController pushViewController:detail animated:YES];
    
    
    
    
    
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
