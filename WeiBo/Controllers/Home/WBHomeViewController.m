//
//  WBHomeViewController.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/4.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBHomeViewController.h"
#import "WBPopMenu.h"

@interface WBHomeViewController ()
@property(nonatomic,strong)WBPopMenu *titlePopMenu;
@end

@implementation WBHomeViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupNavBar];
}
-(void)setupNavBar{
    [super setupNavBar];
    WBNavBarItem *rightItem = [WBNavBarItem new];
    rightItem.type = WBNavBarItemTypeButton;
    rightItem.normalImage = @"navigationbar_icon_radar";
    rightItem.highlightedImage = @"navigationbar_icon_radar_highlighted";
    rightItem.action = ^(){
        
    };
    self.rightBarItem = rightItem;
    
    WBNavBarItem *titltItem = [WBNavBarItem new];
    titltItem.type = WBNavBarItemTypeLabel;
    titltItem.title = @"啊啊啊啊啊啊啊啊啊";
    titltItem.textColorNormal = [UIColor colorWithHex:0x525252];
    titltItem.font = [UIFont boldSystemFontOfSize:17];
    self.titleBarItem = titltItem;
    titltItem.action = ^(){
        [self.titlePopMenu show];
    };

    WBNavBarItem *leftItem = [WBNavBarItem new];
    leftItem.type = WBNavBarItemTypeButton;
    leftItem.normalImage = @"navigationbar_friendattention";
    leftItem.highlightedImage = @"navigationbar_friendattention_highlighted";
    self.leftBarItem = leftItem;
    leftItem.action = ^(){
        
    };
}
-(WBPopMenu *)titlePopMenu{
    if (!_titlePopMenu) {
        _titlePopMenu = [[WBPopMenu alloc] initWithItems:@[@"啊啊啊",@"啊啊啊",@"啊啊啊"] type:WBPopMenuTypeCenter selectIndex:^(NSUInteger index) {
            
        }];
    }
    return _titlePopMenu;
}
@end
