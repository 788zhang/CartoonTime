//
//  ConSultingModel.h
//  CartoonTime
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConSultingModel : NSObject
//轮播图和cell共有的属性
@property(nonatomic, strong) NSString *images;
@property(nonatomic, strong) NSString *title;


//cell的属性

@property(nonatomic, strong) NSString *author;
@property(nonatomic, strong) NSString *createTimeValue;
@property(nonatomic, strong) NSString *shareUrl;


//第二个界面的字典

@property(nonatomic, strong) NSDictionary *messageinfo;




          



- (instancetype)initWithDic:(NSDictionary *)dic;

@end
