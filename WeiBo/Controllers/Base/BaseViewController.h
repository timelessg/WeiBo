//
//  BaseViewController.h
//  WeiBo
//
//  Created by 郭锐 on 15/12/2.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBNavicationBar.h"

@interface BaseViewController : UIViewController
@property(nonatomic,strong)WBNavicationBar *navicationBar;
@property(nonatomic,strong)WBNavBarItem *leftBarItem;
@property(nonatomic,strong)WBNavBarItem *rightBarItem;
@property(nonatomic,strong)WBNavBarItem *titleBarItem;
-(void)setupNavBar;
@end
