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
-(instancetype)initWithTitle:(NSString *)title icoImage:(NSString *)icoImage;
@end

@interface WBComposeMenuBgView : FXBlurView

@end

@interface WBComposeMenu : NSObject
-(void)show;
@end
