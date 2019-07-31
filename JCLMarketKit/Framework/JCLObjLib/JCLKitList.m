//
//  BaseController.m
//  BaoGang_iOS
//
//  Created by 邢昭俊 on 8/29/16.
//  Copyright © 2016 邢昭俊. All rights reserved.
//

#import "JCLKitList.h"

@implementation JCLKitNavi
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

//        self.backgroundColor = [UIColor whiteColor];
//         _backgroundImageView = [[UIImageView alloc] init];
//        _backgroundImageView.frame = CGRectMake(0, 0, self.width, self.height);
//        _backgroundImageView.image = [UIImage imageNamed:@"bg_navbar"];
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL
                   ];
//        [self.bg addSubview:self.backgroundImageView];
        
        self.left = [JCLKitObj JCLButton:self.bg img:nil size:14 target:self action:nil];
        self.right = [JCLKitObj JCLButton:self.bg img:nil size:14 target:self action:nil];
        self.right.contentHorizontalAlignment = 2;
        self.middle = [JCLKitObj JCLButton:self.bg img:nil size:18 target:self action:nil];
        self.subMiddle = [JCLKitObj JCLButton:self.bg img:nil size:12 target:self action:nil];
        self.right1 = [JCLKitObj JCLButton:self.bg img:nil size:14 target:self action:nil];
        self.right1.contentHorizontalAlignment = 2;
        
        self.left.img=@"back";
        UIColor *col = [JCLColorObj JCLTextCol];
        self.middle.color = col; self.subMiddle.color = col; self.left.color = col; self.right.color = col;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.bg.frame = CGRectMake(0, 0, self.width, self.height );
    CGFloat y = New_Device?25:20, w = 55, h = self.bg.height - y;
    self.left.frame = CGRectMake(0, y, w, h);
    self.right.frame = CGRectMake(self.width - w-10-30, y, w+30, h);
    self.right1.frame = CGRectMake(self.right.left - 90, y, w+20, h);
    if (self.subMiddle.titleLabel.text.length) {
        CGSize middleSize = [JCLKitObj JCLTextSize:self.middle.titleLabel.text font:self.middle.titleLabel.font];
        CGSize subSize = [JCLKitObj JCLTextSize:self.subMiddle.titleLabel.text font:self.subMiddle.titleLabel.font];
        CGFloat middleY = 0.5*(h - middleSize.height - subSize.height);
        self.middle.frame = CGRectMake(self.left.maxX, y + middleY, self.width - 2*w, middleSize.height);
        self.subMiddle.frame = CGRectMake(self.left.maxX, self.middle.maxY, self.width - 2*w, subSize.height);
    } else {
        self.middle.frame = CGRectMake(self.left.maxX, y, self.width - 2*w, h);
    }
}
@end

@implementation JCLKitList
-(void)viewDidLoad{
    [super viewDidLoad];
//    self.view.backgroundColor = JCLRGB(25, 25, 33);
  
    
    //状态栏
//    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
//    //标题颜色
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
//    //导航栏子控件颜色
//    [self.navigationController.navigationBar setTintColor:JCL_Cell_COL];
    [self.navigationController.navigationBar setBarTintColor: JCL_Cell_COL];
    self.navigationController.navigationBar.hidden = YES;
   
  
    JCLKitNavi *navi = [[JCLKitNavi alloc]initWithFrame:CGRectMake(0, 0, JCLWIDTH, JCLNAVI)]; [self.view addSubview:navi];
    [navi.left addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [navi.right addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [navi.right1 addTarget:self action:@selector(right1Action) forControlEvents:UIControlEventTouchUpInside];
    [navi.middle addTarget:self action:@selector(middleAction) forControlEvents:UIControlEventTouchUpInside];
    self.navi = navi;
}

-(void)leftAction{ !self.leftActionBlock ? : self.leftActionBlock();
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil]; }
-(void)rightAction{ !self.rightActionBlock ? : self.rightActionBlock(); }
-(void)right1Action{ !self.right1ActionBlock ? : self.right1ActionBlock(); }
-(void)middleAction{ !self.middleActionBlock ? : self.middleActionBlock(); }

// 页面将要进入前台
-(void)viewWillAppear:(BOOL)animated{ [super viewWillAppear:animated]; [self.navigationController setNavigationBarHidden:YES]; }
-(void)viewWillDisappear:(BOOL)animated{ [super viewWillDisappear:animated]; [self.navigationController setNavigationBarHidden:NO]; }

-(BOOL)shouldAutorotate{ return YES; }
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{ return UIInterfaceOrientationMaskPortrait; }
-(UIStatusBarStyle)preferredStatusBarStyle{ return UIStatusBarStyleLightContent; }
@end
