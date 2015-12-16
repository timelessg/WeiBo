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
-(void)setupNavBar{
    [self.view addSubview:self.navicationBar];
}
-(WBNavicationBar *)navicationBar{
    if (!_navicationBar) {
        _navicationBar = [[WBNavicationBar alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kNavBarHeight)];
    }
    return _navicationBar;
}
-(void)setLeftBarItem:(WBNavBarItem *)leftBarItem{
    if (_leftBarItem != leftBarItem) {
        _leftBarItem = leftBarItem;
        _navicationBar.leftBarItem = _leftBarItem;
    }
}
-(void)setRightBarItem:(WBNavBarItem *)rightBarItem{
    if (_rightBarItem != rightBarItem) {
        _rightBarItem = rightBarItem;
        _navicationBar.rightBarItem = _rightBarItem;
    }
}
-(void)setTitleBarItem:(WBNavBarItem *)titleBarItem{
    if (_titleBarItem != titleBarItem) {
        _titleBarItem = titleBarItem;
        _navicationBar.titleBarItem = _titleBarItem;
    }
}
-(UIWindow *)window{
    return [[UIApplication sharedApplication] keyWindow];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
