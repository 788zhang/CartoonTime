//
//  ClassCollectionViewCell.m
//  CartoonTime
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "ClassCollectionViewCell.h"






@implementation ClassCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customView];
    }
    return self;
}

-(void)customView{
    
    self.imageCell=[[UIImageView alloc]initWithFrame:CGRectMake(2, 0, KScreenWidth/3-5-4, KScreenHeight/3-10-20)];
   self.imageCell.backgroundColor=[UIColor whiteColor];
    
    self.updataLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.imageCell.frame.size.height-20, self.imageCell.frame.size.width, 20)];
    
    
    

   self.updataLabel.textColor=[UIColor whiteColor];
    self.updataLabel.backgroundColor=[UIColor blackColor];
    self.updataLabel.font=[UIFont systemFontOfSize:14];
    [self.imageCell addSubview:self.updataLabel];
    
    
   [self addSubview:self.imageCell];
    
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20)];
    
    self.titleLabel.font=[UIFont systemFontOfSize:14];
    
    [self addSubview:self.titleLabel];
    

    
    
    
    
    
    
}










@end
