//
//  CartoonViewController.m
//  CartoonTime
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "CartoonViewController.h"
#import "VOSegmentedControl.h"
#import "ClassModel.h"
#import "ClassSeondViewController.h"
#import "CartoonCollectionViewCell.h"
#import "MJRefresh.h"

@interface CartoonViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{
    
   NSInteger _pageCount;
    
}

//刷新控件
@property(nonatomic, assign) BOOL isRefresh;
@property(nonatomic, strong) VOSegmentedControl *segement;
@property(nonatomic, strong) UICollectionView *collection;




@property(nonatomic, strong) NSMutableArray *classArr;
@property(nonatomic, strong) NSMutableArray *photoArr;
@property(nonatomic, strong) NSString *urlString;


@end

@implementation CartoonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"动漫时代";
     self.urlString=Kclass;
    [self getClassNetData];
    [self.view addSubview:self.segement];
    
    
    

}


#pragma mark --- lazy Loading 




- (NSMutableArray *)classArr{
    
    
    if (_classArr == nil) {
        _classArr=[[NSMutableArray alloc]init];
    }
    return _classArr;
}

- (NSMutableArray *)photoArr{
    
    if (_photoArr == nil) {
        _photoArr =[[NSMutableArray alloc]init];
    }
    return _photoArr;
}



- (UICollectionView *)collection{
    
    if (_collection == nil) {
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        
        
        //设置布局方向(默认是垂直方向)
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        //设置每个item的大小
        layout.itemSize=CGSizeMake(KScreenWidth/3-10, KScreenWidth/3-10);
        
        //设置每一行的间距
        layout.minimumLineSpacing=10;
        
        //设置item的间距
        layout.minimumInteritemSpacing=1;
        
        //设置section的边距
        
        layout.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
        
        self.collection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 110, KScreenWidth, KScreenHeight) collectionViewLayout:layout];
        self.collection.scrollEnabled=YES;
        self.collection.backgroundColor=[UIColor whiteColor];
        self.collection.delegate=self;
        self.collection.dataSource=self;
        
        //添加轻扫手势
        
        UISwipeGestureRecognizer *swipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swichController:)];
        //默认是UISwipeGestureRecognizerDirectionRight
        swipe.direction=UISwipeGestureRecognizerDirectionLeft;
    
       
        [self.collection addGestureRecognizer:swipe];
        
        UISwipeGestureRecognizer *swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swichController:)];
        //默认是UISwipeGestureRecognizerDirectionRight
        swiperight.direction=UISwipeGestureRecognizerDirectionRight;
        
        [self.collection addGestureRecognizer:swiperight];
        
        
        
        
        [self.collection registerClass:[CartoonCollectionViewCell class] forCellWithReuseIdentifier:@"zhang"];
        
        
    }
    return _collection;
}


-(void)swichController:(UISwipeGestureRecognizer *)swipe{
    
    ZPFLog(@"%lu",(unsigned long)swipe.direction);
//    
//    if (swipe.direction==UISwipeGestureRecognizerDirectionLeft) {
//        ZPFLog(@"往左清扫");
//        self.segement.selectedSegmentIndex=0;
//    }if (swipe.direction==UISwipeGestureRecognizerDirectionRight) {
//        
//        ZPFLog(@"往右");
//        self.segement.selectedSegmentIndex=1;
//
//        
//    }
    
    
    
    switch (swipe.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            self.segement.selectedSegmentIndex=0;
            break;
            
         case UISwipeGestureRecognizerDirectionRight:
            self.segement.selectedSegmentIndex=1;
            break;
        default:
            break;
    }
    
    
    
}

- (VOSegmentedControl *)segement{
    
    
    if (_segement == nil) {
    self.segement=[[VOSegmentedControl alloc]initWithSegments:@[@{VOSegmentText: @"类别"}, @{VOSegmentText: @"美图"}]];
        self.segement.textColor=[UIColor grayColor];
        self.segement.selectedTextColor=barColor;
        self.segement.selectedIndicatorColor=barColor;
        self.segement.contentStyle = VOContentStyleTextAlone;
        self.segement.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
        self.segement.backgroundColor = [UIColor whiteColor];
        self.segement.indicatorColor=barColor;
        self.segement.allowNoSelection = NO;
        self.segement.frame = CGRectMake(0 , 66, KScreenWidth,44);
        
        
        
        self.segement.indicatorThickness = 2;
        
        
       
        
        
        [self.segement setIndexChangeBlock:^(NSInteger index) {
        
        }];
        
        [self.segement addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];
    
        
        
        
        
    }
    
    return _segement;
    
    
}








//从0开始
-(void)segmentCtrlValuechange:(VOSegmentedControl *)segmentCtrl{
    
    
    ZPFLog(@"%ld",(long)segmentCtrl.selectedSegmentIndex);

    if (segmentCtrl.selectedSegmentIndex==0) {
        
        //清空所有数据
        [self.classArr removeAllObjects];
       
        [self.collection reloadData];
        //类别
        self.urlString=Kclass;
        [self getClassNetData];
        
    }else if (segmentCtrl.selectedSegmentIndex==1){
        //添加下拉刷新
        //美图
        //清空所有数据
        [self.classArr removeAllObjects];
         self.urlString=KPhoto;
        [self getClassNetData];
       
        
        // 下拉刷新
        self.collection.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 增加数据
            [self.collection.mj_header beginRefreshing];
            
            _pageCount=1;
            
            self.isRefresh=YES;
            [self getClassNetData];
            
            
            ZPFLog(@"下拉刷新");
            [self.collection.mj_header endRefreshing];
            
        }];
        
        
        // 上拉刷新
        self.collection.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.collection.mj_footer beginRefreshing];
            
            
            ZPFLog(@"上拉加载");
            
            _pageCount+=1;
            self.isRefresh=NO;
            
            [self getClassNetData];
            // 结束刷新
            [self.collection.mj_footer endRefreshing];
            
            
            
        }];

        
        
        
        
       
       
        
        
    }
    
    
    
}
#pragma mark ----UICollectionViewDataSource代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    
    return self.classArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     CartoonCollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"zhang" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    
    ClassModel *model=self.classArr[indexPath.row];
    
    if ([self.urlString isEqualToString:Kclass]) {
        
        
    [cell.imageCell sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:nil];
        
     cell.titleLabel.text=model.name;
       
        
    }else if([self.urlString isEqualToString:KPhoto]){
    
    [cell.imageCell sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:nil];
        
    cell.titleLabel.text=nil;
        
    }
    
    

     return cell;
    
}






#pragma mark ---UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
    
    ClassSeondViewController *class=[[ClassSeondViewController alloc]init];
    
    class.model=self.classArr[indexPath.row];
    
    
    
    [self.navigationController pushViewController:class animated:YES];
    
    
    
}




#pragma mark----类别网络请求
-(void)getClassNetData{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    [manager GET:[NSString stringWithFormat:@"%@page=%@&",self.urlString,@(_pageCount)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZPFLog(@"%@",responseObject);
        NSDictionary *rootDic=responseObject;
        
        NSArray *resultArr=rootDic[@"results"];
        
        
        if (self.isRefresh) {
            if (self.classArr.count>0) {
                [self.classArr removeAllObjects];
            }
        }
        
        for (NSDictionary *dic in resultArr) {
            
            ClassModel *model=[[ClassModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.classArr addObject:model];
            
        }
        
        
        
        
        
        
        
        [self.view addSubview:self.collection];
        [self.collection reloadData];

        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZPFLog(@"%@",error);
    }];
    
    
    
    
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
