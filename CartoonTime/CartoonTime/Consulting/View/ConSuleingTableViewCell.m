//
//  ConSuleingTableViewCell.m
//  CartoonTime
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "ConSuleingTableViewCell.h"


//定义为私有属性
@interface ConSuleingTableViewCell ()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *imageViewCell;
@property(nonatomic, strong) UILabel *authorLabel;
@property(nonatomic, strong) UILabel *timeLabel;

@end


@implementation ConSuleingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customViewCell];
    }
    
    return self;
}

-(void)customViewCell{
    
    
    self.imageViewCell=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, KScreenWidth*2/5-10  ,KScreenWidth*2/5*2/3-10)];
    
    
    
    [self.contentView addSubview:self.imageViewCell];
    
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*2/5, 0, KScreenWidth*3/5,KScreenWidth*2/5*2/3/2)];
    self.titleLabel.font=[UIFont systemFontOfSize:15];
    self.titleLabel.text=@"哈哈。。。。。。..........";
    self.titleLabel.numberOfLines=0;
    
    [self.contentView addSubview:self.titleLabel];
    
    self.authorLabel=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*2/5+5, KScreenWidth*2/5*2/3-33, KScreenWidth*3/5/2, 44)];
    
    self.authorLabel.text=@"张鹏飞";
    self.authorLabel.textColor=[UIColor redColor];
    self.authorLabel.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.authorLabel];
    
    
    self.timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth-60, KScreenWidth*2/5*2/3-33, KScreenWidth*3/5/2, 44)];
    
    self.timeLabel.text=@"一小时之前";
    self.timeLabel.textColor=[UIColor redColor];
    self.timeLabel.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.timeLabel];
    
    
}


//setterfangfa
- (void)setModel:(ConSultingModel *)model{
    
   
    [self.imageViewCell sd_setImageWithURL:[NSURL URLWithString:model.images]  placeholderImage:nil];
    
    
    self.titleLabel.text=model.title;
    self.authorLabel.text=model.author;
    self.timeLabel.text=model.createTimeValue;
    
    
    
}









- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
