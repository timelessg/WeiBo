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
@property(nonatomic,strong)UIImageView *icoImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@end

@implementation WBComposeMenuItem
{
    NSString *_title;
    NSString *_icoImage;
}
-(instancetype)initWithTitle:(NSString *)title icoImage:(NSString *)icoImage{
    if (self = [super init]) {
        _title = title;
        _icoImage = icoImage;
        [self setupView];
    }
    return self;
}
-(void)setupView{
    [self addSubview:self.icoImageView];
    [self.icoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(self.icoImageView.mas_bottom).offset(11);
    }];
}
-(UIImageView *)icoImageView{
    if (!_icoImageView) {
        _icoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_icoImage]];
    }
    return _icoImageView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor colorWithHex:0X525252];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
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
    self.blurRadius = 80;
    self.tintColor  = [UIColor blackColor];
    self.dynamic    = YES;
    
    [self addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(self.mas_top).offset(120);
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
@property(nonatomic,strong)UIView *toolsBar;
@property(nonatomic,strong)UIButton *backBtn;
@end

@implementation WBComposeMenu
-(void)show{
    [[self window] addSubview:self.bgView];
}
-(void)hide{
    
}
-(WBComposeMenuBgView *)bgView{
    if (!_bgView) {
        _bgView = [[WBComposeMenuBgView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_bgView addSubview:self.toolsBar];
    }
    return _bgView;
}
-(UIView *)toolsBar{
    if (!_toolsBar) {
        _toolsBar = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT - 49, kSCREENWIDTH, 49)];
        _toolsBar.backgroundColor = [UIColor colorWithHex:0XFFFFFF alpha:0.8];
        [_toolsBar addSubview:self.backBtn];
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_toolsBar.mas_centerX).offset(0);
            make.centerY.equalTo(_toolsBar.mas_centerY).offset(0);
        }];
        [self.backBtn bk_addEventHandler:^(UIButton *sender) {
            [UIView animateWithDuration:0.25 animations:^{
                sender.selected = !sender.selected;
                CGFloat cornerRadiu = sender.selected ? 90 * M_PI / 180.0 : 180 * M_PI / 180.0;
                sender.transform = CGAffineTransformMakeRotation(cornerRadiu);
            }];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _toolsBar;
}
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateNormal];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:UIControlStateSelected];
    }
    return _backBtn;
}
-(UIWindow *)window{
   return [[UIApplication sharedApplication] keyWindow];
}
@end
