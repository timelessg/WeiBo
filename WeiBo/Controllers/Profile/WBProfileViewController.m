//
//  WBProfileViewController.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/4.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBProfileViewController.h"

@interface WBProfileViewController ()
@end

@implementation WBProfileViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupNavBar];
}
-(void)reloadView{
    [super reloadView];
    [self setupNavBar];
}
-(void)setupNavBar{
    WBNavBarItem *titltItem = [WBNavBarItem new];
    titltItem.type = WBNavBarItemTypeLabel;
    titltItem.title = @"我";
    titltItem.textColorNormal = [UIColor colorWithHex:0x525252];
    titltItem.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = [[WBNavBarButton alloc] initWithItem:titltItem];
    
    WBNavBarItem *rightItem = [WBNavBarItem new];
    rightItem.type = WBNavBarItemTypeLabel;
    rightItem.title = @"设置";
    rightItem.textColorNormal = [UIColor colorWithHex:0x525252];
    rightItem.font = [UIFont systemFontOfSize:16];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[WBNavBarButton alloc] initWithItem:rightItem]];
}
@end
