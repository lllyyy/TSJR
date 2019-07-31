//
//  JCLBaseVC.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCLKitList.h"

@interface JCLBaseVC :JCLKitList 
@property (nonatomic,strong)  UIImageView *img;
@property (nonatomic,strong)  UILabel *textLab;
@property (nonatomic,copy  )  void (^block)() ;
@property (nonatomic,assign)  SEL sel;
//占位
- (void)nodataImg:(NSString *)str;
////隐藏占位
- (void)hiddenNodataView;
////定时器 sel传方法
//- (void)startTimer:(SEL)sel;
//block回调的定时器
//- (void)scheduledTimeblock:(void (^)())inBlock;
//@property(nonatomic, strong) NSTimer *timer;
@end

