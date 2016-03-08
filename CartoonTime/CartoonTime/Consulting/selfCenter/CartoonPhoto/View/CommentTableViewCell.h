//
//  CommentTableViewCell.h
//  CartoonTime
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"
@interface CommentTableViewCell : UITableViewCell

@property(nonatomic, strong) DetailModel *model;
@property (weak, nonatomic) IBOutlet UIButton *responseBtn;


@end
