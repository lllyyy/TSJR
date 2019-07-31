//
//  JCLHotspotVC.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/24.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCLBaseVC.h"
//枚举分别对应全部 行业 地区 概念
typedef NS_ENUM(NSInteger,HotspotType) {
    WholeType = 0,
    IndustryType,
    RegionType,
    ConceptType
};


@interface JCLHotspotVC : JCLBaseVC
@property (nonatomic,assign) HotspotType type;
@end
