//
//  WBMessageViewController.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/4.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBMessageViewController.h"

@interface WBMessageViewController ()
@property(nonatomic,strong)WBPopover *chatPopMenu;
@property(nonatomic,strong)WBNavBarItem *leftItem;
@property(nonatomic,strong)WBNavBarItem *titltItem;
@property(nonatomic,strong)WBNavBarItem *rightItem;
@end

@implementation WBMessageViewController
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
        _leftItem.type = WBNavBarItemTypeLabel;
        _leftItem.title = @"发现群";
        _leftItem.textColorNormal = [UIColor colorWithHex:0x525252];
        _leftItem.font = [UIFont systemFontOfSize:16];
    }
    return _leftItem;
}
-(WBNavBarItem *)titltItem{
    if (!_titltItem) {
        _titltItem = [WBNavBarItem new];
        _titltItem.type = WBNavBarItemTypeLabel;
        _titltItem.title = @"发现";
        _titltItem.textColorNormal = [UIColor colorWithHex:0x525252];
        _titltItem.font = [UIFont boldSystemFontOfSize:17];
    }
    return _titltItem;
}
-(WBNavBarItem *)rightItem{
    if (!_rightItem) {
        WS(weakSelf);
        _rightItem = [WBNavBarItem new];
        _rightItem.type = WBNavBarItemTypeButton;
        _rightItem.normalImage = @"navigationbar_icon_newchat";
        _rightItem.highlightedImage = @"navigationbar_icon_newchat_highlight";
        _rightItem.action = ^(){
            [weakSelf.chatPopMenu show];
        };
    }
    return _rightItem;
}
-(void)setupNavBar{
    [super reloadView];
    self.navicationController.navBar.leftBarItem = self.leftItem;
    self.navicationController.navBar.titleBarItem = self.titltItem;
    self.navicationController.navBar.rightBarItem = self.rightItem;
}
-(WBPopover *)chatPopMenu{
    if (!_chatPopMenu) {
        WBPopItem *newChat = [WBPopItem item:@"发起聊天" image:@"popover_icon_newchat"];
        WBPopItem *privateChat = [WBPopItem item:@"私密聊天" image:@"popover_icon_privatechat"];
        
        _chatPopMenu = [[WBPopover alloc] initWithItems:@[@{@"section":@"",@"items":@[newChat,privateChat]}] height:98 type:WBPopMenuTypeRight selectIndex:^(NSString *item) {
            
        }];
    }
    return _chatPopMenu;
}
@end
