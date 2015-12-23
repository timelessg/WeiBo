//
//  WBComposeMenu.h
//  WeiBo
//
//  Created by 郭锐 on 15/12/13.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FXBlurView.h>

typedef void(^DidSelectedItem)(NSUInteger );

@interface WBComposeMenuItem : UIControl
@property(nonatomic,assign)CGRect orignalFrame;
@property(nonatomic,assign)CGFloat animationDuration;
-(instancetype)initWithTitle:(NSString *)title icoImage:(NSString *)icoImage;
@end

@interface WBComposeMenuView : FXBlurView
@property(nonatomic,copy)DidSelectedItem block;
@property(nonatomic,strong)NSArray *items;
@end

@interface WBComposeMenu : NSObject
-(void)showWithSelected:(DidSelectedItem)block;
@end