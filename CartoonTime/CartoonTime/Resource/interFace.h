//
//  interFace.h
//  CartoonTime
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 张鹏飞. All rights reserved.
//

#ifndef interFace_h
#define interFace_h
#import "HWTools.h"

//轮播图
#define  KCartoonApp  @"http://api.playsm.com/index.php?page=1&r=adImage%2Flist&customPosition=1&size=999&"


//首页Cell  拼接  page=1&
#define KCell @"http://api.playsm.com/index.php?r=message%2Flist&size=10&"

//美图page=1&
#define KPhoto @"http://api.playsm.com/index.php?r=prettyImages%2Flist&searchLabel=&"

//类别page=1&
#define Kclass @"http://api.playsm.com/index.php?r=cartoonCategory%2Flist&size=999&"

//最新上架  拼接  id=21&page=2&
#define KnewOut @"http://api.playsm.com/index.php?r=cartoonCategory%2FgetCartoonSetListByCategory&size=12&"
#define KNewClipe @"http://api.playsm.com/index.php?isSize=1&page=1&orderType=1&r=cartoonChapter%2FalbumList&size=10&chapterId=8995&"

#define Kclipe @"http://api.playsm.com/index.php?&r=cartoonSet%2Fdetail&id=325"



#endif /* interFace_h */
