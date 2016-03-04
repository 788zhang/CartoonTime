//
//  ConSultingModel.m
//  CartoonTime
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "ConSultingModel.h"

@implementation ConSultingModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

   
       
    
}


- (instancetype)initWithDic:(NSDictionary *)dic{
    
    self=[super init];
    if (self) {
        self.images=dic[@"images"];
        self.title=dic[@"title"];
    }
    
    return self;
}




@end
