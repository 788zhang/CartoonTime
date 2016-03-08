//
//  ListAndCommentViewController.m
//  CartoonTime
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "ListAndCommentViewController.h"
#import "CommentTableViewCell.h"
#import "DetailModel.h"
#import "DetailViewController.h"
@interface ListAndCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *listArr;
@property(nonatomic, strong) UIView *btnView;
@property(nonatomic, assign) NSInteger countBtn;
@property(nonatomic, strong) NSMutableArray *myIdArr;
@end

@implementation ListAndCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    [self getNetData];
    
    
    
    
    
}


#pragma mark --- 网络请求
-(void)getNetData{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager GET:[NSString stringWithFormat:@"%@&id=%@",Kclipe,self.myid]  parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZPFLog(@"%@",responseObject);
        NSDictionary *rootDic=responseObject;
        NSDictionary *result=rootDic[@"results"];
        //目录
        NSArray *cartoonChapterListArr=result[@"cartoonChapterList"];
        for (NSDictionary *listdic in cartoonChapterListArr) {
            [self.myIdArr addObject:listdic[@"id"]];
        }
        
        
        
        self.authorLabel.text=result[@"author"];
        self.titleLabel.text=result[@"name"];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:result[@"images"]] placeholderImage:nil];
        self.upDatatimeLabel.text=result[@"updateValueLabel"];
        self.recentLabel.text=[NSString stringWithFormat:@"最近更新时间%@",result[@"recentUpdateTime"]];
        self.contentLabel.text=result[@"introduction"];
        
        //取得有多少个按钮
        self.countBtn=[result[@"cartoonChapterCount"] integerValue];
        
        NSArray *listArr=result[@"commentList"];
        for (NSDictionary *dic in listArr) {
            
            DetailModel *model=[[DetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.listArr addObject:model];
            
        }
        
      [self listView];
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZPFLog(@"%@",error);
        
    }];
    
    
    
}



//收藏
- (IBAction)collectionBtn:(id)sender {
}

- (IBAction)starRead:(id)sender {
}
//目录
- (IBAction)listBtn:(id)sender {
    
    [self.tableView removeFromSuperview];
    [self listView];
    
}
//评论
- (IBAction)commentBtn:(id)sender {
    
    [self.btnView removeFromSuperview];
    [self commentView];
    
    
}


-(void)listView{
    
    self.btnView=[[UIView alloc]initWithFrame:CGRectMake(0, 338, KScreenWidth, KScreenHeight-338)];
    
   self.btnView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.btnView];

    
    for (int i=0; i<self.countBtn; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*KScreenWidth/3, 328+10, KScreenWidth/3-20, 44);
        [btn setTitle:[NSString stringWithFormat:@"%d话",i+1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.showsTouchWhenHighlighted=YES;
        btn.tag=i+1;
        [btn addTarget:self action:@selector(detailBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
       btn.backgroundColor=[UIColor redColor];
      [self.view addSubview:btn];
        
    }
    
    
}

-(void)detailBtn:(UIButton *)btn{
    
    
   
    DetailViewController *detail=[[DetailViewController alloc]init];
    
    
    
    detail.myid=self.myIdArr[btn.tag-1];
    
    [self.navigationController pushViewController:detail animated:YES];
    
    
    
}




-(void)commentView{
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    
}


#pragma mark --- lazy Loading


- (NSMutableArray *)myIdArr{
    
    if (_myIdArr == nil) {
        _myIdArr=[[NSMutableArray alloc]init];
    }
    return _myIdArr;
}



- (NSMutableArray *)listArr{
    
    
    if (_listArr ==nil) {
        _listArr=[[NSMutableArray alloc]init];
    }
    return _listArr;
}


- (UITableView *)tableView{
    
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 338, KScreenWidth,KScreenHeight-338) style:UITableViewStylePlain];
        
        _tableView.rowHeight=100;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
    }
    return _tableView;
}


#pragma mark ---UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArr.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  cell.model=self.listArr[indexPath.row];
    
    return cell;
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    
    return [NSString stringWithFormat:@"最新评论（%ld）",self.listArr.count];
    
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
