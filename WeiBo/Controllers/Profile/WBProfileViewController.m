//
//  WBProfileViewController.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/4.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBProfileViewController.h"

@interface WBProfileViewController ()
@property(nonatomic,strong)WBNavBarItem *titltItem;
@property(nonatomic,strong)WBNavBarItem *rightItem;
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
-(WBNavBarItem *)titltItem{
    if (!_titltItem) {
        _titltItem = [WBNavBarItem new];
        _titltItem.type = WBNavBarItemTypeLabel;
        _titltItem.title = @"我";
        _titltItem.textColorNormal = [UIColor colorWithHex:0x525252];
        _titltItem.font = [UIFont boldSystemFontOfSize:17];
    }
    return _titltItem;
}
-(WBNavBarItem *)rightItem{
    if (!_rightItem) {
        _rightItem = [WBNavBarItem new];
        _rightItem.type = WBNavBarItemTypeLabel;
        _rightItem.title = @"设置";
        _rightItem.textColorNormal = [UIColor colorWithHex:0x525252];
        _rightItem.font = [UIFont systemFontOfSize:16];
    }
    return _rightItem;
}
-(void)setupNavBar{
    self.navicationController.navBar.titleBarItem = self.titltItem;
    self.navicationController.navBar.rightBarItem = self.rightItem;
}
@end
