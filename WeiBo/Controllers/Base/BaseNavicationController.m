//
//  BaseNavicationController.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/2.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "BaseNavicationController.h"

@interface BaseNavicationController ()
@end

@implementation BaseNavicationController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = YES;
    [self.view addSubview:self.navBar];
}
-(WBNavicationBar *)navBar{
    if (!_navBar) {
        _navBar = [[WBNavicationBar alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kNavBarHeight)];
    }
    return _navBar;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
