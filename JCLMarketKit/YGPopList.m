//
//  YGPopList.m
//  NongGe_iOS
//
//  Created by 邢昭俊 on 2017/9/5.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "YGPopList.h"
#import "YGPopCell.h"

@interface YGPopList()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, weak) UITableView *table;
@property (nonatomic, strong) NSArray *vals;

@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) UIButton *cancel;
@property (nonatomic, weak) UIButton *submit;
@end

@implementation YGPopList
-(instancetype)init{
    if(self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        
//        self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, JCLWIDTH, JCLHEIGHT)];
//        self.window.backgroundColor = [UIColor yellowColor];
//        self.window.windowLevel = UIWindowLevelAlert;
//        [self.window makeKeyAndVisible];
        
        self.line = [JCLKitObj JCLView:self color:JCLBGRGB];
        self.cancel = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:@selector(cancelAction)];
        self.cancel.title = @"取消";
        self.cancel.color = [UIColor blackColor];
        self.submit = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:@selector(submitAction)];
        self.submit.title = @"确认";
        self.submit.color = [UIColor blackColor];
        
        UITableView *table = [[UITableView alloc]init]; [self addSubview:table];
        table.dataSource = self; table.delegate = self;
        self.table = table;
        
        self.vals = @[@"1", @"1", @"1", @"1",];
    }
    return self;
}


-(void)cancelAction{
    [self removeFromSuperview];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat h = [JCLKitObj JCLHeight:44], s = 1.4;
    self.line.frame = CGRectMake(0, self.height- h-s, self.width, s);
    self.cancel.frame = CGRectMake(0, self.line.maxY, 0.5*self.width, h);
    self.submit.frame = CGRectMake(0.5*self.width, self.line.maxY, 0.5*self.width, h);
    
   // self.table = [JCLKitObj JCLTable:self target:self frame:CGRectMake(0, 0, self.width, self.line.y) style:UITableViewStylePlain];

    self.table.frame = CGRectMake(0, 0, self.width, self.line.y);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return self.vals.count; }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return self.table.height/self.vals.count; }
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    YGPopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YGPopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.text.text = self.vals[indexPath.row];
    return cell;
}

@end
