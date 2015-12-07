//
//  BaseTableViewController.h
//  WeiBo
//
//  Created by 郭锐 on 15/12/4.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController
@property(nonatomic,strong)UITableView *listTableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign,getter = isShowRefreshHeader)BOOL showRefreshHeader;
@property(nonatomic,assign,getter = isShowRefreshFooter)BOOL showRefreshFooter;
-(instancetype)initWithShowHeader:(BOOL)showHeader showFooter:(BOOL)showFooter;
@end
