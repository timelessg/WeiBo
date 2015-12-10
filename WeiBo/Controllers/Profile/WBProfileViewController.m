//
//  WBProfileViewController.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/4.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBProfileViewController.h"

@implementation WBProfileViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupNavBar];
}
-(void)setupNavBar{
    [super setupNavBar];
    WBNavBarItem *leftItem = [WBNavBarItem new];
    leftItem.type = WBNavBarItemTypeLabel;
    leftItem.title = @"添加好友";
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
    rightItem.type = WBNavBarItemTypeLabel;
    rightItem.title = @"设置";
    rightItem.textColorNormal = [UIColor colorWithHex:0x525252];
    rightItem.font = [UIFont systemFontOfSize:16];
    self.rightBarItem = rightItem;
}
@end
