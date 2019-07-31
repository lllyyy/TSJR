//
//  ResultModel.h
//  Doctor
//
//  Created by jian on 15/11/11.
//  Copyright © 2015年 com.cti. All rights reserved.
//

#import "MMBaseModel.h"

@interface MMResultV2Model : MMBaseModel

@property(nonatomic, copy) NSString *code;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, copy) id data;
@property(nonatomic, copy) NSArray *extra;


@end
