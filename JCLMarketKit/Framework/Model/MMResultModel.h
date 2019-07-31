//
//  ResultModel.h
//  Doctor
//
//  Created by jian on 15/11/11.
//  Copyright © 2015年 com.cti. All rights reserved.
//

#import "MMBaseModel.h"

@interface MMResultModel : MMBaseModel

@property(nonatomic, copy) NSString *code;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, copy) NSArray *data;
@property(nonatomic, copy) id extra;

- (NSDictionary *)oneObject;

@end
