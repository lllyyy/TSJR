//
//  TSJRAccountOverHeaderView.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/4/24.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCLAccountModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSJRAccountOverHeaderView : UITableViewCell

@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UILabel *titleLBA;
@property(nonatomic,strong)UILabel *titleLBB;
@property(nonatomic,strong)UILabel *bgLine;

-(void)setDataModel:(JCLAccountModel *)model;
@end

NS_ASSUME_NONNULL_END
