//
//  JCLStockSubmit.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/30.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>
//自选按钮 删除添加
@interface JCLStockSubmit : UIView
@property(nonatomic, weak) UIButton *deal;
 
@property(nonatomic, weak) UIButton *option;
@property(nonatomic, weak) UIButton *tradingBtn;
@property(nonatomic, copy) NSString *code;
@end
