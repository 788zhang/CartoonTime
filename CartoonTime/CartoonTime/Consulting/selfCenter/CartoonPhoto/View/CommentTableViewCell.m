//
//  CommentTableViewCell.m
//  CartoonTime
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "CommentTableViewCell.h"


@interface CommentTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commendLabel;





@end





@implementation CommentTableViewCell




- (void)setModel:(DetailModel *)model{
    
    self.userImage.layer.cornerRadius=20;
    self.userImage.clipsToBounds=YES;
    NSDictionary *user=model.userIDInfo;
    
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:user[@"images"]] placeholderImage:nil];
    
    self.userName.text=user[@"name"];
    self.timeLabel.text=model.createTime;
    self.commendLabel.text=model.content;
    
    
    
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
