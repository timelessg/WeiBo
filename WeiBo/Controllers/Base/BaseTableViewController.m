//
//  BaseTableViewController.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/4.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation BaseTableViewController
-(void)viewDidLoad{
    [super viewDidLoad];
}
-(UITableView *)listTableView{
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44 + 20, kSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStylePlain];
        _listTableView.dataSource = self;
        _listTableView.delegate = self;
        [self.view addSubview:_listTableView];
    }
    return _listTableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
@end
