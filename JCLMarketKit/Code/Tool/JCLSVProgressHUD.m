//
//  JCLSVProgressHUD.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/17.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import "JCLSVProgressHUD.h"
#import "SVProgressHUD.h"
static JCLSVProgressHUD *sharedInstance = nil;
@implementation JCLSVProgressHUD

+ (JCLSVProgressHUD *)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
        [sharedInstance initialize];
    });
    return sharedInstance;
}

- (void)initialize {
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
    self.backgroundView =[LHCObject LHCView:sharedInstance backgroundColor:[UIColor clearColor]];
    self.backgroundView.center = [UIApplication sharedApplication].keyWindow.center;
    self.backgroundView.frame=[UIApplication sharedApplication].keyWindow.bounds;
//    self.backgroundView.alpha = 0.6;
    [self addSubview:sharedInstance.backgroundView];
}

+ (void)showHUD
{
    [JCLSVProgressHUD sharedInstance];
    
    UIView *bgView=[LHCObject LHCView:sharedInstance backgroundColor:[UIColor darkGrayColor]];
    bgView.layer.cornerRadius=4;
    bgView.layer.masksToBounds=YES;
    bgView.frame=CGRectMake(0, 0, [LHCObject height:70], [LHCObject height:65]+25);
    bgView.center=[UIApplication sharedApplication].keyWindow.center;
    
    UIImageView *animationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bgView.width, [LHCObject height:65])];
    animationView.animationImages = [NSArray arrayWithObjects:
                                     [UIImage imageNamed:@"j01.png"],
                                     [UIImage imageNamed:@"j02.png"],
                                     [UIImage imageNamed:@"j03.png"],
                                     [UIImage imageNamed:@"j4.png"],
                                     [UIImage imageNamed:@"j5.png"],
                                     [UIImage imageNamed:@"j6.png"],
                                     [UIImage imageNamed:@"j7.png"],
                                     [UIImage imageNamed:@"j8.png"],
                                     [UIImage imageNamed:@"j9.png"],
                                     [UIImage imageNamed:@"j10.png"],
                                     [UIImage imageNamed:@"j11.png"],nil];
    animationView.animationDuration = 1.5f;
    animationView.animationRepeatCount = 0;
    [animationView startAnimating];
    [bgView addSubview:animationView];
    
    UILabel *textLab=[LHCObject LHCLable:bgView size:13 Textcolor:[UIColor whiteColor] alignment:NSTextAlignmentCenter text:@"正在加载"];
    textLab.frame=CGRectMake(0, animationView.maxY, bgView.width, 25);
    
    [[UIApplication sharedApplication].keyWindow addSubview:sharedInstance];
}

+ (void)showHUD:(NSString *)str
{
    [JCLSVProgressHUD showHUD];
}

+(void)showSuccessHUD:(NSString *)str
{
    [sharedInstance removeFromSuperview];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showSuccessWithStatus:str];
}

+(void)showErrorHud:(NSString *)str
{
    [sharedInstance removeFromSuperview];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showErrorWithStatus:str];
}

+ (void)dimissHUD
{
    [sharedInstance removeFromSuperview];
    [SVProgressHUD dismiss];
}

+ (void)dimissHUDTime:(NSTimeInterval)time
{
        [SVProgressHUD dismiss];
        [sharedInstance removeFromSuperview];
}

+ (void)showshadowHUD
{
    [self showHUD];
}

+ (void)showshadowHUDString:(NSString *)str{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:str];
}

@end
