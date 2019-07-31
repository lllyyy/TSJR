//
//  JCLTadingMoneCell.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/27.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCLAccountModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JCLTadingMoneCell : UITableViewCell
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *titleA;
@property (nonatomic, strong) UILabel *titleB;
@property (nonatomic, strong) UILabel *titleC;
@property (nonatomic, strong) UILabel *titleD;
@property (nonatomic, strong) UILabel *titleE;
@property (nonatomic, strong) UILabel *titleF;

-(void)setDate:(JCLAccountModel *)mode;
@end

NS_ASSUME_NONNULL_END
