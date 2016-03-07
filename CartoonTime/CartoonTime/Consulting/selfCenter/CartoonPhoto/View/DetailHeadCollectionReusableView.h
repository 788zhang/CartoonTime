//
//  DetailHeadCollectionReusableView.h
//  CartoonTime
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailHeadCollectionReusableView : UICollectionReusableView


@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *upTimeLabel;


@property (weak, nonatomic) IBOutlet UILabel *recentLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIButton *listBtn;


@property (weak, nonatomic) IBOutlet UIButton *commenBtn;




@end
