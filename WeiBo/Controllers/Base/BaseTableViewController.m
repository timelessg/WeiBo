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
-(instancetype)initWithShowHeader:(BOOL)showHeader showFooter:(BOOL)showFooter{
    if (self = [super init]) {
        [self.view addSubview:self.listTableView];
    }
    return self;
}
-(UITableView *)listTableView{
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStylePlain];
        _listTableView.dataSource = self;
        _listTableView.delegate = self;
        [self.view addSubview:_listTableView];
    }
    return _listTableView;
}

#pragma mark - TableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
@end
