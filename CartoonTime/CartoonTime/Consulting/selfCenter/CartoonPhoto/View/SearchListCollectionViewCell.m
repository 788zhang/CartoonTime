//
//  SearchListCollectionViewCell.m
//  CartoonTime
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "SearchListCollectionViewCell.h"

@implementation SearchListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customView];
    }
    return self;
}

-(void)customView{
    
    self.lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.lable.textColor=[UIColor grayColor];
    self.lable.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.lable];
    
    
    
    
}



@end
