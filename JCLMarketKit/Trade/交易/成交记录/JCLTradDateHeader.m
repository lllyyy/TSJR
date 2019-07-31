
//
//  JCLTradDateHeader.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/10.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradDateHeader.h"
#import "JCLDatePop.h"
#import "JCLDateObj.h"

@interface JCLTradDateHeader()
@property (nonatomic, weak) UIView *bg;
@property (nonatomic, weak) UIView *popBg;
@property (nonatomic, weak) JCLDatePop *date;
@property (nonatomic, assign) BOOL isEnd;
@end

@implementation JCLTradDateHeader
-(instancetype)init{
    if ([super init]) {        
        NSInteger dis = 7; //前后的天数
        NSDate*nowDate = [NSDate date];
        NSDate* theDate;
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        //之后的天数
        theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*dis ];
        //之前的天数
        theDate = [nowDate initWithTimeIntervalSinceNow: -oneDay*dis ];
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.begin = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
        self.begin.backgroundColor = JCL_Bg_COL;
        self.begin.title = [dateFormatter stringFromDate:theDate];

        self.begin.layer.borderWidth = 1, self.begin.layer.borderColor = JCL_Line_COL.CGColor;
        [self.begin tapActionBlock:^{
            self.isEnd = NO;
            [self InitDatePop];
        }];
        self.end = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
        self.end.backgroundColor = JCL_Bg_COL;
        self.end.title = [JCLDateObj JCLDate:@"yyyy-MM-dd" date:[NSDate date]];
        self.end.layer.borderWidth = 1, self.end.layer.borderColor = JCL_Line_COL.CGColor;
        [self.end tapActionBlock:^{
            self.isEnd = YES;
            [self InitDatePop];
        }];
        self.submit = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
        self.submit.layer.cornerRadius = 4;
        self.submit.backgroundColor = JCL_Rise_COL;
        self.submit.title = @"确定";
        
        [dateFormatter setDateFormat:@"yyyyMMdd"];
        self.beginVal = [dateFormatter stringFromDate:theDate];
        self.endVal = [JCLDateObj JCLDate:@"yyyyMMdd" date:[NSDate date]];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 14, y = 10, w = self.width-4*x, h = self.height - 2*y;
    self.bg.frame = CGRectMake(0, 0, self.width, self.height-1);
    self.begin.frame = CGRectMake(x, y, 0.4*w, h);
    self.end.frame = CGRectMake(self.begin.maxX+x, y, 0.4*w, h);
    self.submit.frame = CGRectMake(self.end.maxX+x, y, 0.2*w, h);
}

-(void)InitDatePop{
    self.popBg = [JCLKitObj JCLView:[AppDelegate shareAppDelegate].window color:JCLRGBA(0, 0, 0, 0.1)];
    self.popBg.frame = CGRectMake(0, 0, JCLWIDTH, JCLHEIGHT);
    [JCLKitObj RXTap:self.popBg target:self action:@selector(dissAction) number:1];
    
    JCLDatePop *date = [[JCLDatePop alloc]init]; [[AppDelegate shareAppDelegate].window addSubview:date];
    CGFloat h = 0.34*JCLHEIGHT;
    date.frame = CGRectMake(0, JCLHEIGHT-h, JCLWIDTH, h);
    //date.minDate = [NSDate date];
    date.cancelActionBlock = ^(){
        [self dissAction];
    };
    __weak JCLDatePop *weakDate = date;
    date.submitActionBlock = ^(){
         [self dissAction];
        if (self.isEnd) {
            self.endVal = [JCLDateObj JCLDate:@"YYYYMMdd" date:weakDate.datePicker.date];
            self.end.title = [JCLDateObj JCLDate:@"YYYY-MM-dd" date:weakDate.datePicker.date];
        } else {
            self.beginVal = [JCLDateObj JCLDate:@"YYYYMMdd" date:weakDate.datePicker.date];
            self.begin.title = [JCLDateObj JCLDate:@"YYYY-MM-dd" date:weakDate.datePicker.date];
        }
        NSLog(@"%@",self.beginVal);
    };
    self.date = date;
}
-(void)dissAction{ [self.popBg removeFromSuperview]; [self.date removeFromSuperview]; }
@end
