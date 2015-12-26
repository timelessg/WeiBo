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
@end

@implementation WBMessageViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupNavBar];
}
-(void)setupNavBar{
    WS(weakSelf);
    WBNavBarItem *titltItem = [WBNavBarItem new];
    titltItem.type = WBNavBarItemTypeLabel;
    titltItem.title = @"发现";
    titltItem.textColorNormal = [UIColor colorWithHex:0x525252];
    titltItem.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = [[WBNavBarButton alloc] initWithItem:titltItem];
    
    WBNavBarItem *leftItem = [WBNavBarItem new];
    leftItem.type = WBNavBarItemTypeLabel;
    leftItem.title = @"发现群";
    leftItem.textColorNormal = [UIColor colorWithHex:0x525252];
    leftItem.font = [UIFont systemFontOfSize:16];
    leftItem.action = ^(id sender){
        [weakSelf.chatPopMenu show];
    };
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[WBNavBarButton alloc] initWithItem:leftItem]];
    
    WBNavBarItem *rightItem = [WBNavBarItem new];
    rightItem.type = WBNavBarItemTypeButton;
    rightItem.normalImage = @"navigationbar_icon_newchat";
    rightItem.highlightedImage = @"navigationbar_icon_newchat_highlight";
    rightItem.action = ^(id sender){
        [weakSelf.chatPopMenu show];
    };
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[WBNavBarButton alloc] initWithItem:rightItem]];
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
