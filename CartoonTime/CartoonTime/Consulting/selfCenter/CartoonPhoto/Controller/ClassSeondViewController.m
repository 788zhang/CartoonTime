//
//  ClassSeondViewController.m
//  CartoonTime
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "ClassSeondViewController.h"
#import "ClassModel.h"
#import "MJRefresh.h"
#import "ClassCollectionViewCell.h"

#import "ListAndCommentViewController.h"
#import "DetailViewController.h"




@interface ClassSeondViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    
    NSInteger  _pageCount;
    
}
//刷新控件


@property(nonatomic, assign) BOOL isRefresh;
@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) NSMutableArray *cellArr;


//刷新

@end


@implementation ClassSeondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=self.model.name;
    self.automaticallyAdjustsScrollViewInsets=NO;

    [self showBarButtonWithImage:@"back"];
    
    
    _pageCount=1;
    
   
    [self getNetData];
    
    
    // 下拉刷新
    self.collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 增加数据
    [self.collectionView.mj_header beginRefreshing];
        
       _pageCount=1;
        
        self.isRefresh=YES;
        [self getNetData];
        
        
        ZPFLog(@"下拉刷新");
        [self.collectionView.mj_header endRefreshing];
        
    }];
    
    
    
    
    
    
    
    
    
    
    // 上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.collectionView.mj_footer beginRefreshing];
        
        
        ZPFLog(@"上拉加载");
        
        _pageCount+=1;
        self.isRefresh=NO;
        [self getNetData];
        
        
        
        
        
        // 结束刷新
        [self.collectionView.mj_footer endRefreshing];
        
        
        
    }];
   

    
    
    
    
}













#pragma mark --- lazy Loading



- (NSMutableArray *)cellArr{
    
    if (_cellArr==nil) {
        _cellArr=[[NSMutableArray alloc]init];
        
    }
    return _cellArr;
}



- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        
        
        
        //设置布局方向(默认是垂直方向)
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        //设置每个item的大小
        layout.itemSize=CGSizeMake(KScreenWidth/3-5, KScreenHeight/3-10);
        
        //设置每一行的间距
        layout.minimumLineSpacing=10;
        
        //设置item的间距
        layout.minimumInteritemSpacing=1;
        
        //设置section的边距
        
        layout.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
        
        self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 66, KScreenWidth, KScreenHeight) collectionViewLayout:layout];
        
        self.collectionView.backgroundColor=[UIColor whiteColor];
        self.collectionView.delegate=self;
        self.collectionView.dataSource=self;
        self.collectionView.translatesAutoresizingMaskIntoConstraints=NO;
        self.collectionView.alwaysBounceVertical=YES;

        [self.collectionView registerClass:[ClassCollectionViewCell class] forCellWithReuseIdentifier:@"zhang"];
        

    }
    return _collectionView;
}





#pragma mark--DJRefreshDelegate代理



#pragma mark ----UICollectionViewDataSource代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    
    return self.cellArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ClassCollectionViewCell *cell=(ClassCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"zhang" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    
    if (cell) {
    
        ClassModel *model=self.cellArr[indexPath.row];
        [cell.imageCell sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:nil];
        cell.updataLabel.text=model.updateInfo;
        cell.titleLabel.text=model.name;

    }
    
    
     return cell;
    
}
#pragma mark ---UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ListAndCommentViewController *list=[[ListAndCommentViewController alloc]init];
    
    ClassModel *model=self.cellArr[indexPath.row];
    list.myid=model.myid;
    
    [self.navigationController pushViewController:list animated:YES];
    
    
    
    
}

#pragma mark --- 网络请求


-(void)getNetData{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    [manager GET:[NSString stringWithFormat:@"%@id=%@&page=%@&",KnewOut,self.model.myid,@(_pageCount)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZPFLog(@"%@",responseObject);
        
        NSDictionary *rootDic=responseObject;
        
        if (self.isRefresh) {
            if (self.cellArr.count>0) {
                [self.cellArr removeAllObjects];
            }
        }
        
        
        NSArray *resultArr=rootDic[@"results"];
        for (NSDictionary *dic in resultArr) {
            ClassModel *model=[[ClassModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.cellArr addObject:model];
        }
        
        
        
        
        ZPFLog(@"%@",self.cellArr);
        
        [self.view addSubview:self.collectionView];
        [self.collectionView reloadData];
        
        
        
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
