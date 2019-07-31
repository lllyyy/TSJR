//
//  JCLAccountInstructionsVC.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/20.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "JCLAccountInstructionsVC.h"
#import "JCLInstructionsCell.h"
#import "JCLInstrionsHeaderView.h"


@interface JCLAccountInstructionsVC ()
@property (nonatomic, strong) JCLInstrionsHeaderView *header;
@property (nonatomic, strong) NSMutableArray *idxArrM;
@end

@implementation JCLAccountInstructionsVC
-(void)viewDidLoad {
    [super viewDidLoad];
    _idxArrM = [[NSMutableArray alloc]init];
    self.navi.middle.title = @"说明";
     [self.table registerClass: [JCLInstructionsCell class] forCellReuseIdentifier:@"JCLInstructionsCell"];
    
    for (int i = 0; i < self.dataArray.count; i++)
    {
        //所有的分区都是闭合
        [_idxArrM addObject:@"0"];
    }
 }

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 }


//-(NSMutableArray *)idxArrM{
//    if (_idxArrM)
//        return _idxArrM;
//    return _idxArrM = [[NSMutableArray alloc]init];
// }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [button setTag:section+1];
    button.backgroundColor = JCL_Cell_COL;
    [button setTitleColor:JCL_Text_COL forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60)];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
  if (section > 1) {
   UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, (45-10)/2, 15, 10)];
    
    if ([self.idxArrM[section] isEqualToString:@"0"]) {
        _imgView.image = [UIImage imageNamed:@"ic_drop_down"];
    }else if ([self.idxArrM[section] isEqualToString:@"1"]) {
        _imgView.image = [UIImage imageNamed:@"ic_up"];
    }
    [button addSubview:_imgView];
  }
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, (45-20)/2, 200, 20)];
//    [tlabel setBackgroundColor:[UIColor clearColor]];
    [tlabel setFont:[UIFont systemFontOfSize:14]];
    tlabel.textColor = [UIColor whiteColor];
    [tlabel setText:self.dataArray[section]];
    [button addSubview:tlabel];
    return button;
 
 
}
- (void)buttonPress:(UIButton *)sender//headButton点击
{
    //判断状态值
    if ([self.idxArrM[sender.tag - 1] isEqualToString:@"1"]){
        //修改
        [self.idxArrM replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];
    }else{
        [self.idxArrM replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
    }
    [self.table reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [JCLKitObj JCLHeight:36];
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [JCLKitObj JCLView:self.view color:JCL_Bg_COL];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = [JCLKitObj JCLTextSize:@"保证金账户,亦作：透支账户；信用账户。投资者在证券公司开设的一种账户形式。通过该账户，投资者可以用股票作抵押，按账户资产总市值的一定比例借用证券公司资金进行投资" font:[UIFont systemFontOfSize:14]];
    
    return size.height + 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  1;
}
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    __block NSInteger idx = 44;
    if (section == 1) {
         return 0;
    }
    if (section == 0) {
        return 1;
    }
    
    if ([self.idxArrM[section] isEqualToString:@"1"]){
        //如果是展开状态
//        NSArray *array = [self.dataArray objectAtIndex:section];
        return 1;
    }else{
        //如果是闭合，返回0
        return 0;
    }
    
    
    
////    NSLog(@"idxArrMidxArrM  %@",self.idxArrM);
//
//    [self.idxArrM enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger index, BOOL * _Nonnull stop) {
//
//        if ([obj integerValue] == section) {
//            idx = section;
//        }
//    }];
//    if (section == 1) {
//        return 0;
//    }
//    if (section != idx) {
//
//
//        return 1;
//    }
//
//    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   JCLInstructionsCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"JCLInstructionsCell" forIndexPath:indexPath];
    
     cell.title.text = @"保证金账户,亦作：透支账户；信用账户。投资者在证券公司开设的一种账户形式。通过该账户，投资者可以用股票作抵押，按账户资产总市值的一定比例借用证券公司资金进行投资";
    return cell;
}



@end
