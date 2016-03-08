//
//  SearchViewController.m
//  CartoonTime
//搜索
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchListCollectionViewCell.h"
#import "PhotoShowViewController.h"

@interface SearchViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)NSArray *listArr;
@property(nonatomic, strong)UITextField *textFiled;

@end

@implementation SearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    self.automaticallyAdjustsScrollViewInsets=YES;
    [self headSearchView];
    
   
}


-(void)headSearchView{
    
    self.textFiled=[[UITextField alloc]initWithFrame:CGRectMake(10, 66, KScreenWidth-60, 44)];
    
    self.textFiled.placeholder=@"请选择搜索内容";
    self.textFiled.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.textFiled];
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(KScreenWidth-60+10, 66, 50, 50);
    btn.backgroundColor=[UIColor blueColor];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(searchKey) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
    
    
    
    
    
}


-(void)searchKey{
    
    PhotoShowViewController *show=[[PhotoShowViewController alloc]init];
    show.contentTitle=self.textFiled.text;
    
    [self.navigationController pushViewController:show animated:YES];
    
    
    
    
}


-(void)getData{
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager GET:Klist parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZPFLog(@"%@",responseObject);
        NSDictionary *dic=responseObject;
        self.listArr=dic[@"results"];
        
        
        
        
        [self.view addSubview:self.collectionView];
        [self.collectionView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZPFLog(@"%@",error);
    }];
    
    
}




#pragma mark --- lazy Loading

- (UICollectionView *)collectionView{
    
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        
        layout.itemSize=CGSizeMake(100, 44);
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing=10;//行距
        layout.minimumInteritemSpacing=1;
        layout.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
        layout.headerReferenceSize=CGSizeMake(KScreenWidth, 50);
        
        
        self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 110, KScreenWidth, KScreenHeight)  collectionViewLayout:layout];
        self.collectionView.delegate=self;
        self.collectionView.dataSource=self;
        self.collectionView.backgroundColor=[UIColor whiteColor];
        //注册cell
        [self.collectionView registerClass:[SearchListCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        
        
        
        
        
        
        
    }
    return _collectionView;
}




#pragma mark ---UICollectionViewDataSource,UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SearchListCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.lable.text=self.listArr[indexPath.row];
    
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    self.textFiled.text=self.listArr[indexPath.row];
    
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
