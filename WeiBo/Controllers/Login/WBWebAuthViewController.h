//
//  WBWebAuthViewController.h
//  Toshow
//
//  Created by 郭锐 on 15/7/4.
//  Copyright (c) 2015年 FAN LING. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WBUser.h"
@interface WBWebAuthViewController : BaseViewController
@property (nonatomic, copy) void (^returnAuthInfo)(WBUser *);
@end
