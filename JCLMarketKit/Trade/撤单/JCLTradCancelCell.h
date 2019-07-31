//
//  JCLTradCancelCell.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/10.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLTradCancelCell : UITableViewCell
@property (nonatomic, weak) UILabel *time;
@property (nonatomic, weak) UILabel *code;
@property (nonatomic, weak) UILabel *price;
@property (nonatomic, weak) UILabel *vol;
@property (nonatomic, weak) UIButton *option;
@end
