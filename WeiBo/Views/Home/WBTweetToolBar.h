//
//  WBTweetToolBar.h
//  WeiBo
//
//  Created by 郭锐 on 15/12/23.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBTweetToolBar : UIView
@property(nonatomic,copy)void (^didSlectedItem)(NSUInteger index);
@end
