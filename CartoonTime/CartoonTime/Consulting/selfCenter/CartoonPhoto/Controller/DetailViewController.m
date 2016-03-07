//
//  DetailViewController.m
//  CartoonTime
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailModel.h"
#import "DetailHeadCollectionReusableView.h"

@interface DetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *headViewArr;
@property(nonatomic, strong) NSMutableArray *cellViewArr;



@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    [self getNetData];
    
}








#pragma mark ---lazy Loading



- (NSMutableArray *)headViewArr{
    if (_headViewArr==nil) {
        _headViewArr=[[NSMutableArray alloc]init];
        
    }
    return _headViewArr;
    
}

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
       
        
        //设置section的边距
        
        layout.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
        
        
        
        //设置headView的大小
        layout.headerReferenceSize=CGSizeMake(KScreenWidth, 328);
        
        
        
        self.collectionView=[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
        
        //设置代理
        self.collectionView.dataSource=self;
        self.collectionView.delegate=self;

        //注册cell
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        
        
        //注册headView
        [self.collectionView registerNib:[UINib nibWithNibName:@"DetailHeadCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"zhang"];
        
    }
    
    return _collectionView;
}

#pragma mark ---UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return 3;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
    
    
}

//定义并返回每个headerView或footerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        DetailHeadCollectionReusableView *headView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"zhang" forIndexPath:indexPath];
        
        DetailModel *model=self.cellViewArr[0];
        
        [headView.imageView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:nil];
        headView.authorLabel.text=model.author;
        headView.contentLabel.text=model.introduction;
        headView.titleLable.text=model.name;
        headView.upTimeLabel.text=model.updateValueLabel;
        headView.recentLabel.text=model.recentUpdateTime;
        
      
        return headView;
    }
    
    return nil;
}




-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}




#pragma mark --- 网络请求
-(void)getNetData{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager GET:KNewClipe parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZPFLog(@"%@",responseObject);
        NSDictionary *rootDic=responseObject;
        NSDictionary *result=rootDic[@"results"];
        
        DetailModel *model=[[DetailModel alloc]init];
        
        [model setValuesForKeysWithDictionary:result];
        
        [self.headViewArr addObject:model];
        
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
