//
//  CartoonCollectionViewCell.m
//  CartoonTime
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "CartoonCollectionViewCell.h"

@implementation CartoonCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customView];
    }
    return self;
}


-(void)customView{
    
    self.imageCell=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, KScreenWidth/3-10-20, KScreenWidth/3-10-20)];
    self.imageCell.backgroundColor=[UIColor whiteColor];
    self.imageCell.layer.cornerRadius=(KScreenWidth/3-30)/2;
    self.imageCell.clipsToBounds=YES;
    [self addSubview:self.imageCell];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, KScreenWidth/3-30, KScreenWidth/3-30, 20)];
    
    self.titleLabel.font=[UIFont systemFontOfSize:16];
    
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    [self addSubview:self.titleLabel];
    
    
    
    
}


@end
