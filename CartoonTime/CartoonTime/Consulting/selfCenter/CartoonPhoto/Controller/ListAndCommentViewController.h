//
//  ListAndCommentViewController.h
//  CartoonTime
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListAndCommentViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (weak, nonatomic) IBOutlet UILabel *upDatatimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *recentLabel;


@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property(nonatomic, strong) NSString *myid;


@end
