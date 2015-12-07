//
//  WBHomeViewController.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/4.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBHomeViewController.h"

@interface WBHomeViewController ()

@end

@implementation WBHomeViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupNavBar];
}
-(void)setupNavBar{
    [self.view addSubview:self.navicationBar];
    WBNavBarItem *rightItem = [WBNavBarItem new];
    rightItem.type = WBNavBarItemTypeButton;
    rightItem.normalImage = @"navigationbar_icon_radar";
    rightItem.highlightedImage = @"navigationbar_icon_radar_highlighted";
    self.rightBarItem = rightItem;
    
    WBNavBarItem *titltItem = [WBNavBarItem new];
    titltItem.type = WBNavBarItemTypeLabel;
    titltItem.title = @"啊啊啊啊啊啊啊啊啊";
    titltItem.textColorNormal = [UIColor colorWithHex:0x525252];
    titltItem.font = [UIFont boldSystemFontOfSize:17];
    self.titleBarItem = titltItem;

    WBNavBarItem *leftItem = [WBNavBarItem new];
    leftItem.type = WBNavBarItemTypeButton;
    leftItem.normalImage = @"navigationbar_friendattention";
    leftItem.highlightedImage = @"navigationbar_friendattention_highlighted";
    self.leftBarItem = leftItem;
}
@end
