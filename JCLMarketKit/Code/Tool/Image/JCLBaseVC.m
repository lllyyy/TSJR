//
//  JCLBaseVC.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLBaseVC.h"

@interface JCLBaseVC ()
@end

@implementation JCLBaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=YES;
    self.navi.backgroundColor=[UIColor whiteColor];
    self.navi.middle.color=JCLRGB(5, 5, 5);
    UIView *line=[LHCObject LHCView:self.navi backgroundColor:JCLRGB(207, 207, 207)];
    line.frame=CGRectMake(0, 63.2, JCLWIDTH, 0.8);
self.navi.left.img = @"nav_back";    //分别是占位图和占位文字
    self.img=[LHCObject LHCImage:self.view Image:@"addimg"];
    self.img.frame=CGRectMake(0.27*JCLWIDTH, 0.22*JCLHEIGHT, 0.5*JCLWIDTH, 0.2*JCLHEIGHT);
    self.img.hidden=YES;
    
    self.textLab=[LHCObject LHCLable:self.view size:15 Textcolor: JCLRGB(105, 106, 111) alignment:NSTextAlignmentCenter text:@""];
    self.textLab.frame=CGRectMake(0, self.img.maxY-8, JCLWIDTH, 20);
    self.textLab.hidden=YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [JCLSVProgressHUD dimissHUD];
}

-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//如果子控制器没有数据 那么就可以调用这个方法
- (void)nodataImg:(NSString *)str
{
    self.img.hidden=NO;
    self.textLab.hidden=NO;
    self.textLab.text=str;
    self.textLab.text=@"暂无数据";
}

- (void)hiddenNodataView{
    self.img.hidden=YES;
    self.textLab.hidden=YES;
}

#pragma mark --开启定时器
//- (void)startTimer:(SEL)sel
//{
//    self.sel=sel;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(calibrationFortimer) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//}
//
//- (void)calibrationFortimer{
//    NSInteger i=[LHCObject second];
//    if(i%5==0){
//        if(self.timer){
//            [self.timer invalidate];
//        }
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:self.sel userInfo:nil repeats:YES];
//        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//    }
//}
//
//-(void)scheduledTimeblock:(void (^)())inBlock{
//    self.block = [inBlock copy];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAction:) userInfo:self.block repeats:YES];
//}
//
//-(void)timerAction:(NSTimer *)inTimer {
//    if([LHCObject second]%5==0) {
//        if(self.timer){
//            [self.timer invalidate];
//        }
//    self.timer=[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(executeSimpleBlock:) userInfo:self.block repeats:YES];
//    }
//}
//
//-(void)executeSimpleBlock:(NSTimer *)inTimer {
//    if([inTimer userInfo]) {
//        void (^block)() = (void (^)())[inTimer userInfo];
//        block();
//    }
//}

@end
