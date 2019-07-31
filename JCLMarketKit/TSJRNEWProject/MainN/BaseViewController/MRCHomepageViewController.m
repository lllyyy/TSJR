//
//  MRCHomepageViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/9.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCHomepageViewController.h"
#import "MRCHomepageViewModel.h"
#import "MRCNewsViewController.h"
#import "MRCProfileViewController.h"
#import "MRCNewsViewModel.h"
#import "MRCReposViewModel.h"
#import "MRCProfileViewModel.h"
#import "MRCReposViewController.h"
#import "MRCNavigationController.h"
#import "MRCExploreViewController.h"
//#import "MRCUserListViewModel.h"
//#import "MRCSearchViewController.h"
#import "JCLUserListVC.h"
@interface MRCHomepageViewController ()

@property (nonatomic, strong) MRCHomepageViewModel *viewModel;

@end

@implementation MRCHomepageViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tabBarController.delegate = self;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    

    UINavigationController *newsNavigationController = ({
        MRCNewsViewController *newsViewController = [[MRCNewsViewController alloc] initWithViewModel:self.viewModel.newsViewModel];
 

        newsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"News" image:[UIImage imageNamed:@"行情_n"] selectedImage:[UIImage imageNamed:@"行情_s"]];

        [[MRCNavigationController alloc] initWithRootViewController:newsViewController];
    });

    UINavigationController *reposNavigationController = ({
        MRCReposViewController *reposViewController = [[MRCReposViewController alloc] initWithViewModel:self.viewModel.reposViewModel];
 

        reposViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Repositories" image:[UIImage imageNamed:@"自选_n"] selectedImage:[UIImage imageNamed:@"自选_s"]];

        [[MRCNavigationController alloc] initWithRootViewController:reposViewController];
    });

    UINavigationController *exploreNavigationController = ({
        MRCExploreViewController *exploreViewController = [[MRCExploreViewController alloc] initWithViewModel:self.viewModel.exploreViewModel];

 
        exploreViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Explore" image:[UIImage imageNamed:@"交易_n"] selectedImage:[UIImage imageNamed:@"交易_s"]];

        [[MRCNavigationController alloc] initWithRootViewController:exploreViewController];
    });

    UINavigationController *profileNavigationController = ({
        JCLUserListVC *userList = [[JCLUserListVC alloc] initWithViewModel:self.viewModel.userViewModel];

 
        userList.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[UIImage imageNamed:@"我的_n"] selectedImage:[UIImage imageNamed:@"我的_s"]];

        [[MRCNavigationController alloc] initWithRootViewController:userList];
    });

    self.tabBarController.viewControllers = @[ newsNavigationController, reposNavigationController, exploreNavigationController, profileNavigationController ];

    [[AppDelegate shareAppDelegate].navigationControllerStack pushNavigationController:newsNavigationController];

    [[self
        rac_signalForSelector:@selector(tabBarController:didSelectViewController:)
        fromProtocol:@protocol(UITabBarControllerDelegate)]
        subscribeNext:^(RACTuple *tuple) {
            [[AppDelegate shareAppDelegate].navigationControllerStack popNavigationController];
             [[AppDelegate shareAppDelegate].navigationControllerStack pushNavigationController:tuple.second];
        }];
    self.tabBarController.delegate = self;
    [self.tabBarController.tabBar setTranslucent:YES];
    [self.tabBarController.tabBar setTintColor:[UIColor yellowColor]];
//    [self.tabBarController.tabBar setBackgroundColor:JCLRGB(248, 248, 248)];
    //设置标签栏背景颜色
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    bg.backgroundColor = JCL_Cell_COL;
    [self.tabBarController.tabBar insertSubview:bg atIndex:0];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (self.tabBarController.selectedViewController == viewController) {
        UINavigationController *navigationController = (UINavigationController *)self.tabBarController.selectedViewController;
        UIViewController *viewController = navigationController.topViewController;
        if ([viewController isKindOfClass:[MRCNewsViewController class]]) {
            MRCNewsViewController *newsViewController = (MRCNewsViewController *)viewController;
//            [newsViewController refresh];
        }
    }
    return YES;
}




@end
