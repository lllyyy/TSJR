//
//  JCLBillboardVC.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/6.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCLBaseVC.h"

typedef NS_ENUM(NSInteger,BillboardType)
{
    BillboardTypeDay=0, //每日上榜
    BillboardTypeStock, //个股排名
    BillboardTypeRank   //营业部排名
};

@interface JCLBillboardVC : JCLBaseVC

@property(nonatomic,assign)BillboardType type;
@end
