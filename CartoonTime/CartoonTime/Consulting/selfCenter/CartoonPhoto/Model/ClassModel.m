//
//  ClassModel.m
//  CartoonTime
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#import "ClassModel.h"

@implementation ClassModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.myid=value;
    }
        
}


@end
