//
//  BaseViewController.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/2.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@end

@implementation BaseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
-(WBNavicationBar *)navicationBar{
    if (!_navicationBar) {
        _navicationBar = [[WBNavicationBar alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 44 + 20)];
        WBNavBarItem *leftItem = [WBNavBarItem new];
        leftItem.type = WBNavBarItemTypeButton;
        leftItem.normalImage = @"navigationbar_friendattention";
        leftItem.highlightedImage = @"navigationbar_friendattention_highlighted";
        _navicationBar.leftBarItem = leftItem;
        
        WBNavBarItem *rightItem = [WBNavBarItem new];
        rightItem.type = WBNavBarItemTypeButton;
        rightItem.normalImage = @"navigationbar_icon_radar";
        rightItem.highlightedImage = @"navigationbar_icon_radar_highlighted";
        _navicationBar.rightBarItem = rightItem;
        
        WBNavBarItem *titltItem = [WBNavBarItem new];
        titltItem.type = WBNavBarItemTypeLabel;
        titltItem.title = @"啊啊啊啊啊啊";
        titltItem.textColorNormal = [UIColor colorWithHex:0x525252];
        titltItem.font = [UIFont systemFontOfSize:17];
        _navicationBar.titleBarItem = titltItem;
    }
    return _navicationBar;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
