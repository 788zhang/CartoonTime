//
//  DetailCollectionViewCell.m
//  CartoonTime
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "DetailCollectionViewCell.h"

@implementation DetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customView];
    }
    return self;
}

-(void)customView{
    
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    
    
    [self addSubview:self.imageView];
    

    
    
}


@end
