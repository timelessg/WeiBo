//
//  MainViewController.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/2.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "MainViewController.h"
#import "WBTabBar.h"

@interface MainViewController ()
@property(nonatomic,strong)WBTabBar *tabBar;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-667h"]];
    bg.frame = CGRectMake(0, 50, kSCREENWIDTH, KSCREENHEIGHT);
    [self.view addSubview:bg];
    
    [self.view addSubview:self.tabBar];
}
-(WBTabBar *)tabBar{
    if (!_tabBar) {
        WBTabBarItem *itemHome = [WBTabBarItem initWithTitle:@"首页" imageNormal:@"tabbar_home" imageSelected:@"tabbar_home_selected" type:TarBarItemTypeTitle];
        WBTabBarItem *itemMessage = [WBTabBarItem initWithTitle:@"消息" imageNormal:@"tabbar_message_center" imageSelected:@"tabbar_message_center_selected" type:TarBarItemTypeTitle];
        
        WBTabBarItem *itemCenter = [WBTabBarItem initWithTitle:nil imageNormal:@"tabbar_compose_icon_add" imageSelected:@"tabbar_compose_icon_add_highlighted" type:TarBarItemTypeIco];
        
        WBTabBarItem *itemExplore = [WBTabBarItem initWithTitle:@"发现" imageNormal:@"tabbar_discover" imageSelected:@"tabbar_discover_selected" type:TarBarItemTypeTitle];
        WBTabBarItem *itemMy = [WBTabBarItem initWithTitle:@"我" imageNormal:@"tabbar_profile" imageSelected:@"tabbar_profile_selected" type:TarBarItemTypeTitle];
        
        _tabBar = [[WBTabBar alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT - 48 - 5, kSCREENWIDTH, 48 + 5) items:@[itemHome,itemMessage,itemCenter,itemExplore,itemMy] selected:^(NSUInteger itemIndex) {
            
        }];
    }
    return _tabBar;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
