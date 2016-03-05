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


@interface CartoonViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) VOSegmentedControl *segement;
@property(nonatomic, strong) UICollectionView *collection;


@property(nonatomic, strong) NSMutableArray *classArr;
@property(nonatomic, strong) NSMutableArray *photoArr;


@end

@implementation CartoonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"动漫时代";
   
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
        
        self.collection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, KScreenWidth, KScreenHeight) collectionViewLayout:layout];
        
        self.collection.backgroundColor=[UIColor whiteColor];
        self.collection.delegate=self;
        self.collection.dataSource=self;
        
        [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"zhang"];
        
        
    }
    return _collection;
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
        //类别
        
        [self getClassNetData];
        
    }else if (segmentCtrl.selectedSegmentIndex==1){
        
        //美图
        
        [self getPhotoNetData];
        
    }
    
    
    
}




#pragma mark ----美图


#pragma mark ----UICollectionViewDataSource代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    
    return self.classArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"zhang" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    
    
    UIImageView *imageCell=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, KScreenWidth/3-10-20, KScreenWidth/3-10-20)];
    
    ClassModel *model=self.classArr[indexPath.row];
    

    [imageCell sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:nil];
    
    imageCell.backgroundColor=[UIColor whiteColor];
    imageCell.layer.cornerRadius=(KScreenWidth/3-30)/2;
    imageCell.clipsToBounds=YES;

    [cell.contentView addSubview:imageCell];
    
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, KScreenWidth/3-30, KScreenWidth/3-30, 20)];
    
    titleLabel.font=[UIFont systemFontOfSize:16];
    titleLabel.text=model.name;
    titleLabel.textAlignment=NSTextAlignmentCenter;
    
    
    [cell.contentView addSubview:titleLabel];
    
    
    
    
    
    
    
    
    
    
    
    
    
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
    
    [manager GET:Kclass parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZPFLog(@"%@",responseObject);
        NSDictionary *rootDic=responseObject;
        
        NSArray *resultArr=rootDic[@"results"];
        
        for (NSDictionary *dic in resultArr) {
            
            ClassModel *model=[[ClassModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.classArr addObject:model];
            
        }
        
        
        
        
        
        
        
        [self.view addSubview:self.collection];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZPFLog(@"%@",error);
    }];
    
    
    
    
}

#pragma mark ---美图

-(void)getPhotoNetData{
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager GET:KPhoto parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZPFLog(@"%@",responseObject);
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
