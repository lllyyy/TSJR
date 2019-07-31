//
//  ShareView.m
//  ScreenshotsShareView
//
//  Created by 苟应航 on 2018/3/31.
//  Copyright © 2018年 GouHang. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView
-(instancetype)initWithFrame:(CGRect)frame image:(UIImage *)images{
    if (self=[super initWithFrame:frame]) {
        [self loadviewUI:images];
        self.imageV = images;
    }
    return self;
}
-(void)loadviewUI:(UIImage *)images{
//    [self animationWithView:self duration:0.6];
    UIView *view=[UIView new];
    view.backgroundColor=[UIColor blackColor];
    UITapGestureRecognizer *taps = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenview)];
    [view addGestureRecognizer:taps];
    view.alpha= 0;
    [UIView animateWithDuration:0.25 animations:^{
    view.alpha = 0.5;
    }];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];

    NSArray *imageicon=@[@"friiendsharemage",@"qqshareimage",@"wetshareimage",];
    NSArray *imagetitle=@[@"朋友圈",@"QQ",@"微信",];
    
    UIView *endview=[UIView new];
    endview.backgroundColor=[UIColor whiteColor];
    [self addSubview:endview];
    [endview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    for (int i=0; i<imageicon.count; i++) {
        UIView *imageview=[UIView new];
        [endview addSubview:imageview];
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_WIDTH/3);
            make.left.mas_equalTo((SCREEN_WIDTH/3)*i);
            make.bottom.mas_equalTo(endview.mas_bottom);
            make.height.mas_equalTo(100);
        }];
       
        UIButton *image=[UIButton buttonWithType:UIButtonTypeCustom];
        [image setImage:[UIImage imageNamed:imageicon[i]] forState:UIControlStateNormal];
        [image addTarget:self action:@selector(shareBtn:)];
        image.tag = i;
        
        [imageview addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(25);
        make.centerX.mas_equalTo(imageview.mas_centerX);
        make.centerY.mas_equalTo(imageview.mas_centerY).mas_offset(-5);
        }];
        
        
        
        UIButton *titilelabe=[UIButton buttonWithType:UIButtonTypeCustom];
        [titilelabe setTitle:imagetitle[i] forState:UIControlStateNormal];
        [titilelabe setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        titilelabe.titleLabel.font=[UIFont systemFontOfSize:14];
        [imageview addSubview:titilelabe];
        [titilelabe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(image.mas_bottom).mas_offset(6);
            make.centerX.mas_equalTo(image.mas_centerX);
        }];
        
    }
    UIImageView *shareimage=[UIImageView new];
    shareimage.image=images;
    shareimage.contentMode=UIViewContentModeScaleAspectFill;
    shareimage.alpha=1;
    [self addSubview:shareimage];
    [shareimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(100);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.bottom.mas_equalTo(endview.mas_top).mas_offset(-100);
    }];
}
-(void)hiddenview{
    [self removeFromSuperview];
 }

-(void)shareBtn:(UIButton *)tap{
    
    int i = 0;
 
    if (tap.tag == 0) {
        i = 2;
    }else if (tap.tag == 1){
        i = 4;
    }else{
        i=1;
    }
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = self.imageV;
    [shareObject setShareImage:self.imageV];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:i  messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
            [self hiddenview];
        }
    }];
  
}

- (void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [view.layer addAnimation:animation forKey:nil];
}
@end
