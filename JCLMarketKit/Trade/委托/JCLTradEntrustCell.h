//
//  JCLTradEntrustCell.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/10.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLTradEntrustCell : UITableViewCell
@property (nonatomic, weak) UILabel *bs;
@property (nonatomic, weak) UILabel *code;
@property (nonatomic, weak) UILabel *time;

@property (nonatomic, weak) UILabel *priceW;
@property (nonatomic, weak) UILabel *numW;
@property (nonatomic, weak) UILabel *priceC;
@property (nonatomic, weak) UILabel *numC;
@property (nonatomic, weak) UILabel *order;
@end
