//
//  MainViewController.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/2.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "MainViewController.h"
#import "WBTabBar.h"
#import "WBWebAuthViewController.h"
#import "WBUser.h"
#import "NetAPIManager.h"
#import "WBHomeViewController.h"
#import "WBMessageViewController.h"
#import "WBDiscoverViewController.h"
#import "WBProfileViewController.h"
#import "WBNavicationBar.h"
#import "WBComposeMenu.h"

@interface MainViewController ()
@property(nonatomic,strong)WBTabBar *tabBar;
@property(nonatomic,strong)WBComposeMenu *composeMenu;
@property(nonatomic,strong)UIScrollView *pageScrollView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showAuth];
    [self setupChildVC];
    
    [self.view addSubview:self.tabBar];
}
-(void)showAuth{
    if (![WBUser isLogin]) {
        WBWebAuthViewController *authVC = [[WBWebAuthViewController alloc] init];
        authVC.returnAuthInfo = ^(WBUser *user){
            if ([user archive]) {
                
            }
        };
        [self presentViewController:authVC animated:YES completion:nil];
    }
}
-(void)setupChildVC{
    [self.view addSubview:self.pageScrollView];
    
    NSArray *vcClassNameArray = @[@"WBHomeViewController",@"WBMessageViewController",@"WBDiscoverViewController",@"WBProfileViewController"];
    [vcClassNameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class class = objc_getClass([obj UTF8String]);
        [self addChildViewController:[class new]];
    }];
    [self.pageScrollView addSubview:[[self.childViewControllers firstObject] view]];
}
-(WBComposeMenu *)composeMenu{
    if (!_composeMenu) {
        _composeMenu = [[WBComposeMenu alloc] init];
    }
    return _composeMenu;
}
-(WBTabBar *)tabBar{
    if (!_tabBar) {
        WS(weakSelf);
        WBTabBarItem *itemHome = [WBTabBarItem initWithTitle:@"首页" imageNormal:@"tabbar_home" imageSelected:@"tabbar_home_selected" type:TarBarItemTypeTitle];
        WBTabBarItem *itemMessage = [WBTabBarItem initWithTitle:@"消息" imageNormal:@"tabbar_message_center" imageSelected:@"tabbar_message_center_selected" type:TarBarItemTypeTitle];
        WBTabBarItem *itemCenter = [WBTabBarItem initWithTitle:nil imageNormal:@"tabbar_compose_icon_add" imageSelected:@"tabbar_compose_icon_add_highlighted" type:TarBarItemTypeIco];
        itemCenter.disSelected = YES;
        WBTabBarItem *itemDiscover = [WBTabBarItem initWithTitle:@"发现" imageNormal:@"tabbar_discover" imageSelected:@"tabbar_discover_selected" type:TarBarItemTypeTitle];
        WBTabBarItem *itemProfile = [WBTabBarItem initWithTitle:@"我" imageNormal:@"tabbar_profile" imageSelected:@"tabbar_profile_selected" type:TarBarItemTypeTitle];
        
        _tabBar = [[WBTabBar alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT - 49, kSCREENWIDTH, 49) items:@[itemHome,itemMessage,itemCenter,itemDiscover,itemProfile] selected:^(NSUInteger itemIndex) {
            if (itemIndex == 2) {
                [weakSelf.composeMenu showWithSelected:^(NSUInteger index) {
                    
                }];
                return ;
            }
            NSUInteger index = (itemIndex >= 2) ? itemIndex - 1 : itemIndex;
            BaseViewController *vc = weakSelf.childViewControllers[index];
            if (!vc.isViewLoaded) {
                vc.view.frame = CGRectMake(index * kSCREENWIDTH, 0, weakSelf.view.width, weakSelf.view.height);
                [weakSelf.pageScrollView addSubview:vc.view];
            }
            [vc reloadView];
            weakSelf.pageScrollView.contentOffset = CGPointMake(index * kSCREENWIDTH, 0);
        }];
    }
    return _tabBar;
}
-(UIScrollView *)pageScrollView{
    if (!_pageScrollView) {
        _pageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT - 49, kSCREENWIDTH, 49)];
        _pageScrollView.contentSize = CGSizeMake(kSCREENWIDTH * 4,  0);
        _pageScrollView.scrollEnabled = NO;
    }
    return _pageScrollView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
