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
@end

@implementation WBHomeViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupNavBar];
}
-(void)setupNavBar{
    [super setupNavBar];
    WS(weakSelf);
    WBNavBarItem *rightItem = [WBNavBarItem new];
    rightItem.type = WBNavBarItemTypeButton;
    rightItem.normalImage = @"navigationbar_icon_radar";
    rightItem.highlightedImage = @"navigationbar_icon_radar_highlighted";
    rightItem.action = ^(){
        [weakSelf.radarPopMenu show];
    };
    self.rightBarItem = rightItem;
    
    WBNavBarItem *titltItem = [WBNavBarItem new];
    titltItem.type = WBNavBarItemTypeLabel;
    titltItem.title = @"郭郭郭Coding";
    titltItem.textColorNormal = [UIColor colorWithHex:0x525252];
    titltItem.font = [UIFont boldSystemFontOfSize:17];
    self.titleBarItem = titltItem;
    titltItem.action = ^(){
        [weakSelf.titlePopMenu show];
    };
    
    WBNavBarItem *leftItem = [WBNavBarItem new];
    leftItem.type = WBNavBarItemTypeButton;
    leftItem.normalImage = @"navigationbar_friendattention";
    leftItem.highlightedImage = @"navigationbar_friendattention_highlighted";
    self.leftBarItem = leftItem;
    leftItem.action = ^(){
        
    };
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
