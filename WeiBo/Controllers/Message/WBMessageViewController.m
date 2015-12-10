//
//  WBMessageViewController.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/4.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBMessageViewController.h"

@interface WBMessageViewController ()

@end

@implementation WBMessageViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupNavBar];
}
-(void)setupNavBar{
    [super setupNavBar];
    WBNavBarItem *leftItem = [WBNavBarItem new];
    leftItem.type = WBNavBarItemTypeLabel;
    leftItem.title = @"发现群";
    leftItem.textColorNormal = [UIColor colorWithHex:0x525252];
    leftItem.font = [UIFont systemFontOfSize:16];
    self.leftBarItem = leftItem;
    
    WBNavBarItem *titltItem = [WBNavBarItem new];
    titltItem.type = WBNavBarItemTypeLabel;
    titltItem.title = @"发现";
    titltItem.textColorNormal = [UIColor colorWithHex:0x525252];
    titltItem.font = [UIFont boldSystemFontOfSize:17];
    self.titleBarItem = titltItem;
    
    WBNavBarItem *rightItem = [WBNavBarItem new];
    rightItem.type = WBNavBarItemTypeButton;
    rightItem.normalImage = @"navigationbar_icon_newchat";
    rightItem.highlightedImage = @"navigationbar_icon_newchat_highlight";
    self.rightBarItem = rightItem;
}
@end
