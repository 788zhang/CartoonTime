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

//最新界面的末页chapterId=8995&   
#define KNewClipe @"http://api.playsm.com/index.php?isSize=1&page=1&orderType=1&r=cartoonChapter%2FalbumList&size=10&"

//最新框架点击进入的界面  &id=325
#define Kclipe @"http://api.playsm.com/index.php?&r=cartoonSet%2Fdetail"


//搜索列单
#define Klist @"http://api.playsm.com/index.php?r=prettyImages%2FgetLabelList&"

//搜索http://api.playsm.com/index.php?lastCount=10102&page=1&r=prettyImages%2Flist&searchLabel=%E7%BE%8E%E5%B0%91%E5%A5%B3&

#define kSearch @"http://api.playsm.com/index.php?lastCount=10102&page=1&r=prettyImages%2Flist&searchLabel="



#endif /* interFace_h */
