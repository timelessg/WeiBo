//
//  WBComposeMenu.h
//  WeiBo
//
//  Created by 郭锐 on 15/12/13.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FXBlurView.h>

@interface WBComposeMenuItem : UIControl
@property (nonatomic, assign) CGFloat animationDuration;
-(instancetype)initWithTitle:(NSString *)title icoImage:(NSString *)icoImage;
@end

@interface WBComposeMenuBgView : FXBlurView
@property(nonatomic,strong)NSArray *items;
@end

@interface WBComposeMenu : NSObject
-(void)show;
@end

@interface UIView (Additions)
- (CABasicAnimation *)fadeIn;
- (CABasicAnimation *)fadeOut;
@end