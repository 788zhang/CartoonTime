//
//  DetailViewController.m
//  CartoonTime
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "DetailViewController.h"
#import "EndImageModel.h"
#import "DetailCollectionViewCell.h"


@interface DetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *headViewArr;
@property(nonatomic, strong) NSMutableArray *cellViewArr;
@property(nonatomic, strong) NSDictionary *headViewDic;




@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.automaticallyAdjustsScrollViewInsets=YES;
   
    [self getNetData];
    
}








#pragma mark ---lazy Loading

-(NSMutableArray *)cellViewArr{
    
    if (_cellViewArr==nil) {
        _cellViewArr=[[NSMutableArray alloc]init];
    }
    return _cellViewArr;
}

- (UICollectionView *)collectionView{
    
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        //设置布局方向(默认是垂直方向)
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
       
        
        //设置每一行的间距
        layout.minimumLineSpacing=1;
        
        //设置item的间距
        layout.minimumInteritemSpacing=10;
        
       
     
//        //设置每个item的大小
        layout.itemSize=CGSizeMake(KScreenWidth, KScreenHeight);
        
        self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:layout];
        
        //设置代理
        self.collectionView.dataSource=self;
        self.collectionView.delegate=self;

//        //注册cell
        [self.collectionView registerClass:[DetailCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        
        
        }
    
    return _collectionView;
}

#pragma mark ---UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.cellViewArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    DetailCollectionViewCell *cell=(DetailCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    EndImageModel *model=self.cellViewArr[indexPath.row];
    
   
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:nil];
       
    return cell;
    
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}




#pragma mark --- 网络请求
-(void)getNetData{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager GET:[NSString stringWithFormat:@"%@chapterId=%@&",KNewClipe,self.myid]  parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZPFLog(@"%@",responseObject);
        NSDictionary *rootDic=responseObject;
        NSArray *result=rootDic[@"results"];
        for (NSDictionary *dic in result) {
            EndImageModel *model=[[EndImageModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            
            [self.cellViewArr addObject:model];
            
            
            
        }
        
        
        
        
        
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
