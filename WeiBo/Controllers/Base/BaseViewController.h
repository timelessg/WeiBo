//
//  BaseViewController.h
//  WeiBo
//
//  Created by 郭锐 on 15/12/2.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavicationController.h"
#import "WBPopover.h"


@interface BaseViewController : UIViewController
@property(nonatomic,strong)BaseNavicationController *navicationController;
-(UIWindow *)window;
-(void)reloadView;
@end
