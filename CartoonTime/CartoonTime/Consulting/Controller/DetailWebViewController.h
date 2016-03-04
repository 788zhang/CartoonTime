//
//  DetailWebViewController.h
//  CartoonTime
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConSultingModel.h"


@interface DetailWebViewController : UIViewController

//轮播图的字典
@property(nonatomic, strong) NSDictionary *messageinfo;

//cell
@property(nonatomic, strong) ConSultingModel *model;


@property(nonatomic, assign) BOOL isCell;

@end
