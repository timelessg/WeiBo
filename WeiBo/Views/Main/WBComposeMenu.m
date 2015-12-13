//
//  WBComposeMenu.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/13.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBComposeMenu.h"
#import "WBPopover.h"

#pragma - mark WBComposeMenuBgView


@interface WBComposeMenuItem ()

@end

@interface WBComposeMenuBgView ()
@property(nonatomic,strong)UIImageView *logoImageView;
@end

@implementation WBComposeMenuBgView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    self.blurRadius = 40;
    self.tintColor  = [UIColor whiteColor];
    self.dynamic    = YES;
    
    [self addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(self.mas_top).offset(100);
    }];
}
-(UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compose_slogan"]];
    }
    return _logoImageView;
}
@end

#pragma - mark WBComposeMenu

@interface WBComposeMenu ()
@property(nonatomic,strong)WBComposeMenuBgView *bgView;
@end

@implementation WBComposeMenu
-(void)show{
    [[self window] addSubview:self.bgView];
}
-(void)hide{
    
}
-(UIWindow *)window{
   return [[UIApplication sharedApplication] keyWindow];
}
@end
