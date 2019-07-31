//
//  TSJRMarketOptionListCell.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/20.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSJRMarketOptionListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSJRMarketOptionListCell : UITableViewCell
@property (nonatomic,strong) UIImageView  *codeTypeLB;

@property (nonatomic,strong) UILabel  *codeNameLB;
@property (nonatomic,strong) UILabel  *priceLB;
@property (nonatomic,strong) UILabel  *appliesLB;
@property (nonatomic,strong) UILabel  *afterLB;
@property (nonatomic,strong) UILabel  *codeLB;
@property (nonatomic,strong) UILabel  *afterPriceLB;
@property (nonatomic,strong) UILabel  *afterAppliesLB;
@property (nonatomic,strong) UILabel  *linA;
-(void)setDataModel:(TSJRMarketOptionListModel *)model;
@end

NS_ASSUME_NONNULL_END
