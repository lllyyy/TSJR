//
//  YGMenuCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/6/6.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGPopCell : UITableViewCell
@property (nonatomic, assign) BOOL isCheck;
@property (nonatomic, weak) UILabel *text;
@property (nonatomic, weak) UIButton *select;
@end
