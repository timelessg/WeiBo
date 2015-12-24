//
//  WBHomeViewController.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/4.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBHomeViewController.h"

@interface WBHomeViewController ()
@property(nonatomic,strong)WBPopover *titlePopMenu;
@property(nonatomic,strong)WBPopover *radarPopMenu;

@property(nonatomic,strong)WBNavBarItem *leftItem;
@property(nonatomic,strong)WBNavBarItem *titltItem;
@property(nonatomic,strong)WBNavBarItem *rightItem;
@end

@implementation WBHomeViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupNavBar];
}
-(void)reloadView{
    [super reloadView];
    [self setupNavBar];
}
-(WBNavBarItem *)leftItem{
    if (!_leftItem) {
        _leftItem = [WBNavBarItem new];
        _leftItem.type = WBNavBarItemTypeButton;
        _leftItem.normalImage = @"navigationbar_friendattention";
        _leftItem.highlightedImage = @"navigationbar_friendattention_highlighted";
        _leftItem.action = ^(){
            
        };
    }
    return _leftItem;
}
-(WBNavBarItem *)titltItem{
    if (!_titltItem) {
        WS(weakSelf);
        _titltItem = [WBNavBarItem new];
        _titltItem.type = WBNavBarItemTypeLabel;
        _titltItem.title = @"郭郭郭Coding";
        _titltItem.textColorNormal = [UIColor colorWithHex:0x525252];
        _titltItem.font = [UIFont boldSystemFontOfSize:16];
        _titltItem.action = ^(){
            [weakSelf.titlePopMenu show];
        };
    }
    return _titltItem;
}
-(WBNavBarItem *)rightItem{
    if (!_rightItem) {
        WS(weakSelf);
        _rightItem = [WBNavBarItem new];
        _rightItem.type = WBNavBarItemTypeButton;
        _rightItem.normalImage = @"navigationbar_icon_radar";
        _rightItem.highlightedImage = @"navigationbar_icon_radar_highlighted";
        _rightItem.action = ^(){
            [weakSelf.radarPopMenu show];
        };
    }
    return _rightItem;
}
-(void)setupNavBar{
    [super reloadView];
    self.navicationController.navBar.rightBarItem = self.rightItem;
    self.navicationController.navBar.titleBarItem = self.titltItem;
    self.navicationController.navBar.leftBarItem  = self.leftItem;
}
-(WBPopover *)titlePopMenu{
    if (!_titlePopMenu) {
        WBPopItem *home = [WBPopItem item:@"首页" selected:NO like:NO];
        WBPopItem *friend = [WBPopItem item:@"好友圈" selected:YES like:YES];
        WBPopItem *group = [WBPopItem item:@"群微博" selected:NO like:NO];
        WBPopItem *my = [WBPopItem item:@"我的微博" selected:NO like:NO];
        WBPopItem *like = [WBPopItem item:@"特别关注" selected:NO like:NO];
        WBPopItem *private = [WBPopItem item:@"悄悄关注" selected:NO like:NO];
        WBPopItem *other = [WBPopItem item:@"周边微博" selected:NO like:NO];
        
        NSArray *items = @[@{@"section":@"",@"items":@[home,friend,group,my]},@{@"section":@"我的分组",@"items":@[like,private]},@{@"section":@"其他",@"items":@[other]}];
        _titlePopMenu = [[WBPopover alloc] initWithItems:items height:350 type:WBPopMenuTypeCenter selectIndex:^(NSString *item) {
            
        }];
    }
    return _titlePopMenu;
}
-(WBPopover *)radarPopMenu{
    if (!_radarPopMenu) {
        WBPopItem *radra = [WBPopItem item:@"雷达" image:@"popover_icon_radar"];
        WBPopItem *qrcode = [WBPopItem item:@"扫一扫" image:@"popover_icon_qrcode"];
        
        _radarPopMenu = [[WBPopover alloc] initWithItems:@[@{@"section":@"",@"items":@[radra,qrcode]}] height:98 type:WBPopMenuTypeRight selectIndex:^(NSString *item) {
            
        }];
    }
    return _radarPopMenu;
}
@end
