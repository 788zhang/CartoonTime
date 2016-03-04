//
//  ClassSeondViewController.m
//  CartoonTime
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "ClassSeondViewController.h"
#import "ClassModel.h"




@interface ClassSeondViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) NSMutableArray *cellArr;


@end


@implementation ClassSeondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showBarButtonWithImage:@"back"];
    
   
    
    
    [self getNetData];
    
    
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
        
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"zhang"];
        

    }
    return _collectionView;
}

#pragma mark ----UICollectionViewDataSource代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    
    return self.cellArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"zhang" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    
    
    UIImageView *imageCell=[[UIImageView alloc]initWithFrame:CGRectMake(2, 0, KScreenWidth/3-5-4, KScreenHeight/3-10-20)];
    
    
    ClassModel *model=self.cellArr[indexPath.row];
    
    ZPFLog(@"%@",model);
    
    [imageCell sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:nil];
    
    imageCell.backgroundColor=[UIColor whiteColor];
    
    UILabel *updataLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, imageCell.frame.size.height-20, imageCell.frame.size.width, 20)];
   
    
    
    updataLabel.text=model.updateInfo;
    updataLabel.textColor=[UIColor whiteColor];
    updataLabel.backgroundColor=[UIColor blackColor];
    updataLabel.font=[UIFont systemFontOfSize:14];
    [imageCell addSubview:updataLabel];
    
    
    [cell.contentView addSubview:imageCell];
    
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-20, cell.frame.size.width, 20)];
    
    titleLabel.font=[UIFont systemFontOfSize:14];
    titleLabel.text=model.name;
   
    
    
    [cell.contentView addSubview:titleLabel];
    
    
    
    
    
    
    
    
    
    
    
    
    
    return cell;
    
}
#pragma mark ---UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
  
    
    
    
}

#pragma mark --- 网络请求


-(void)getNetData{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    [manager GET:[NSString stringWithFormat:@"%@id=%@&page=%@&",KnewOut,self.model.myid,@(1)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZPFLog(@"%@",responseObject);
        
        NSDictionary *rootDic=responseObject;
        
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
