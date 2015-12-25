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
    [self reloadView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)reloadView{
    self.navicationController.navBar.leftBarItem = nil;
    self.navicationController.navBar.titleBarItem = nil;
    self.navicationController.navBar.rightBarItem = nil;
}
-(BaseNavicationController *)navicationController{
    return (BaseNavicationController *)self.navigationController;
}
-(UIWindow *)window{
    return [[UIApplication sharedApplication] keyWindow];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
