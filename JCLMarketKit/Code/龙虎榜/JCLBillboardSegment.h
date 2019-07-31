//
//  JCLBillboardSegment.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/6.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^SegmentChangeBlock)();
@interface JCLBillboardSegment : UIView
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,copy)SegmentChangeBlock block;
@property(nonatomic,assign) NSInteger selectIdx;
@end
