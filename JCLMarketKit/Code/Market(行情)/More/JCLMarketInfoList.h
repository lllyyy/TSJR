//
//  QuotationRangeMore.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/11/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "YSTableList.h"

typedef enum{
    QuotatOfIndustry = 1,
    QuotatOfConcept,
    QuotatOfRegion,
    QuotatOfRise,
    QuotatOfFall,
    QuotatOfTurnover,
    QuotatOfDeal,
    
    QuotatOfInflow,
    QuotatOfFlowOu,
} MoreQuotatType;

typedef enum{
    PlateOfIndustry = 1,
    PlateOfConcept,
    PlateOfRegion,
} QuotatPlateType;

typedef enum{
    CapitalOfIndustry = 1,
    CapitalOfConcept,
    CapitalOfRegion,
} MoreCapitalType;

@interface JCLMarketInfoList : YSTableList
@property (nonatomic , assign) NSInteger main;

@property (nonatomic, assign) MoreQuotatType QuotatType;
@property (nonatomic, assign) BOOL isPlate;
@property (nonatomic, strong) NSArray *array;

@property (nonatomic, assign) BOOL isCapital;

@property (nonatomic, assign) QuotatPlateType plateType;
@property (nonatomic, assign) MoreCapitalType capitalType;

@property (nonatomic, strong) NSString *textNav;
@property (nonatomic, strong) NSString *mainType;
@property (nonatomic, strong) NSString *sortType;
@end
