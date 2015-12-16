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
    self.icoImageView.image = [UIImage imageNamed:_icoImage];
    [self.icoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
    }];
    
    [self addSubview:self.titleLabel];
    self.titleLabel.text = _title;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(self.icoImageView.mas_bottom).offset(11);
    }];
}
-(UIImageView *)icoImageView{
    if (!_icoImageView) {
        _icoImageView = [[UIImageView alloc] init];
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
@property(nonatomic,strong)NSMutableArray *itemArray;
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
    self.tintColor  = [UIColor clearColor];
    self.dynamic    = NO;
    
    [self addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(self.mas_top).offset(120);
    }];
    NSArray * titleArray = @[@"文字",@"照片/视频",@"长微博",@"签到",@"点评",@"更多"];
    NSArray *icoArray = @[@"tabbar_compose_idea",@"tabbar_compose_photo",@"tabbar_compose_weibo",@"tabbar_compose_lbs",@"tabbar_compose_review",@"tabbar_compose_more"];
    CGFloat icoWidth = 82;
    CGFloat icoHeight = 107;
    for (int i = 0; i < titleArray.count; i ++) {
        CGFloat offsetY = (i > 2) ? self.centerY + 70 + 78 : self.centerY + 70 - 78;
        int j = (i > 2) ? (i - 3) : i ;
        CGFloat offsetX = self.centerX + (j - 1) * kSCREENWIDTH * 0.5 * 0.63;
        WBComposeMenuItem *item = [[WBComposeMenuItem alloc] initWithTitle:titleArray[i] icoImage:icoArray[i]];
        item.animationDuration = 0.1 + 0.03 * i;
        item.frame = CGRectMake(0, 0, icoWidth, icoHeight);
        item.center = CGPointMake(offsetX, offsetY);
        [self.itemArray addObject:item];
        [self addSubview:item];
    }
}
- (void)appear{
    for (WBComposeMenuItem *item in self.itemArray) {
        CGFloat x = item.x;
        CGFloat y = item.y;
        CGFloat width = item.width;
        CGFloat height = item.height;
        item.frame = CGRectMake(x, KSCREENHEIGHT + y, width, height);
        item.alpha = 0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(item.animationDuration * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:25 options:UIViewAnimationOptionCurveEaseIn animations:^{
                item.frame = CGRectMake(x, y, width, height);
                item.alpha = 1.0f;
            } completion:^(BOOL finished) {
                
            }];
        });
    }
}
-(void)disAppear{
    int i = 0;
    for (WBComposeMenuItem *item in [[self.itemArray reverseObjectEnumerator] allObjects]) {
        CGFloat x = item.x;
        CGFloat y = item.y;
        CGFloat width = item.width;
        CGFloat height = item.height;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * 0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:5 options:0 animations:^{
                item.alpha = 0;
                item.frame = CGRectMake(x, KSCREENHEIGHT + y, width, height);
            } completion:^(BOOL finished) {
                
            }];
        });
        i ++ ;
    }
}
-(NSMutableArray *)itemArray{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
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
@property(nonatomic,strong)UIButton *closeBtn;
@end

@implementation WBComposeMenu
-(void)show{
    [[self window] addSubview:self.bgView];
    self.bgView.alpha = 0;
    [self.bgView appear];
    [UIView animateWithDuration:0.35 animations:^{
        self.bgView.alpha = 1.0f;
        self.closeBtn.transform = CGAffineTransformMakeRotation(M_PI * 0.75);
    }];
}
-(void)hide{
    [self.bgView disAppear];
    [UIView animateWithDuration:0.5 animations:^{
        self.closeBtn.transform = CGAffineTransformMakeRotation(0);
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        self.bgView = nil;
    }];
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
        _toolsBar.backgroundColor = [UIColor colorWithHex:0XFFFFFF alpha:1];
        [_toolsBar addSubview:self.closeBtn];
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_toolsBar.mas_centerX).offset(0);
            make.centerY.equalTo(_toolsBar.mas_centerY).offset(0);
        }];
        WS(weakSelf);
        [self.closeBtn bk_addEventHandler:^(UIButton *sender) {
            [weakSelf hide];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _toolsBar;
}
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateNormal];
    }
    return _closeBtn;
}
-(UIWindow *)window{
   return [[UIApplication sharedApplication] keyWindow];
}
@end
