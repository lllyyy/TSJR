//
//  JCLNewStockVC.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/30.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import "JCLBaseVC.h"

typedef NS_ENUM(NSInteger,NewStyle){
     NewFirstDay=0, //首日打开
     NewSucces,   //成功回封
     NewPlate,    //一字连板
     NewHigh,     //再创新高
     NewFall,     //阶段超跌
     NewPrice     //低价潜力
};
@interface JCLNewStockVC : JCLBaseVC
@property (nonatomic,copy )  void(^PushList)(NSArray *array);
@property (nonatomic,assign) NewStyle style;
- (void)loadData;
@end
