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

@interface WBComposeMenuView () <UIScrollViewDelegate>
@property(nonatomic,strong)UIView *toolsBar;
@property(nonatomic,strong)UIButton *closeBtn;
@property(nonatomic,strong)UIButton *backBtn;

@property(nonatomic,strong)UIImageView *logoImageView;
@property(nonatomic,strong)NSMutableArray *itemArray;

@property(nonatomic,strong)UIScrollView *contentSrollView;
@end

@implementation WBComposeMenuView
{
    CALayer *_separateLayer;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    WS(weakSelf);

    self.blurRadius = 40;
    self.tintColor  = [UIColor clearColor];
    self.dynamic    = NO;
    
    [self addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(self.mas_top).offset(120);
    }];
    [self addSubview:self.contentSrollView];
    
    [self addSubview:self.toolsBar];
    
    self.closeBtn.center = CGPointMake(self.toolsBar.centerX, self.toolsBar.height / 2);
    [self.toolsBar addSubview:self.closeBtn];
    [self.closeBtn bk_addEventHandler:^(UIButton *sender) {
        [weakSelf disAppear];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.toolsBar addSubview:self.backBtn];
    self.backBtn.hidden = YES;
    self.backBtn.center = CGPointMake(self.toolsBar.width / 4 , self.toolsBar.height / 2);
    [self.backBtn bk_addEventHandler:^(id sender) {
        [weakSelf switchPageOn:NO animation:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    NSArray * titleArray = @[@[@"文字",@"照片/视频",@"长微博",@"签到",@"点评",@"更多"],@[@"好友圈",@"微博相机",@"音乐",@"红包",@"商场"]];
    NSArray *icoArray = @[@[@"tabbar_compose_idea",@"tabbar_compose_photo",@"tabbar_compose_weibo",@"tabbar_compose_lbs",@"tabbar_compose_review",@"tabbar_compose_more"],@[@"tabbar_compose_friend",@"tabbar_compose_wbcamera",@"tabbar_compose_music",@"tabbar_compose_weibo",@"tabbar_compose_transfer",@"tabbar_compose_voice"]];
    CGFloat icoWidth = 82;
    CGFloat icoHeight = 107;
    for (int i = 0; i < titleArray.count; i ++) {
        for (int j = 0; j < [titleArray[i] count]; j ++ ) {
            CGFloat offsetY = (j > 2) ? self.centerY + 70 + 78 : self.centerY + 70 - 78;
            int k = (j > 2) ? (j - 3) : j ;
            CGFloat offsetX = self.centerX + (k - 1) * kSCREENWIDTH * 0.5 * 0.63 + i * kSCREENWIDTH;
            WBComposeMenuItem *item = [[WBComposeMenuItem alloc] initWithTitle:titleArray[i][j] icoImage:icoArray[i][j]];
            item.tag = i * 10 + j;
            item.animationDuration = 0.1 + 0.03 * j;
            item.frame = CGRectMake(0, 0, icoWidth, icoHeight);
            item.center = CGPointMake(offsetX, offsetY);
            item.orignalFrame = item.frame;
            [self.itemArray addObject:item];
            [self.contentSrollView addSubview:item];
            [item bk_addEventHandler:^(UIButton *sender) {
                if (sender.tag == 5) {
                    [weakSelf switchPageOn:YES animation:YES];
                }
            } forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
-(void)switchPageOn:(BOOL)on animation:(BOOL)animation{
    if (on) {
        [UIView animateWithDuration:0.25 animations:^{
            self.contentSrollView.contentOffset = CGPointMake(kSCREENWIDTH, 0);
            self.contentSrollView.scrollEnabled = YES;
        }];
        [UIView animateWithDuration:0.25 animations:^{
            self.closeBtn.alpha = 0;
            _separateLayer.hidden = NO;
        } completion:^(BOOL finished) {
            self.closeBtn.center = CGPointMake(self.toolsBar.width / 4 * 3, self.toolsBar.height / 2);
            self.backBtn.hidden = NO;
            self.backBtn.alpha = 0;
            [UIView animateWithDuration:0.25 animations:^{
                self.closeBtn.alpha = 1;
                self.backBtn.alpha = 1;
            }];
        }];
    }else{
        CGFloat duration = animation ? 0.25 : 0;
        [UIView animateWithDuration:duration animations:^{
            self.contentSrollView.contentOffset = CGPointMake(0, 0);
            self.contentSrollView.scrollEnabled = NO;
        }];
        
        [UIView animateWithDuration:duration animations:^{
            self.closeBtn.alpha = 0;
            self.backBtn.alpha = 0;
            _separateLayer.hidden = YES;
        } completion:^(BOOL finished) {
            self.backBtn.hidden = YES;
            self.closeBtn.center = CGPointMake(self.toolsBar.width / 2, self.toolsBar.height / 2);
            [UIView animateWithDuration:duration animations:^{
                self.closeBtn.alpha = 1;
            }];
        }];
    }
}
- (void)appear{
    [self switchPageOn:NO animation:NO];
    
    self.alpha = 0;
    self.closeBtn.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0f;
        self.closeBtn.transform = CGAffineTransformMakeRotation(M_PI * 0.75);
        self.closeBtn.alpha = 1.0f;
    } completion:nil];
    
    for (WBComposeMenuItem *item in self.itemArray) {
        item.frame = item.orignalFrame;
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
    [UIView animateWithDuration:0.5 + i * 0.03 animations:^{
        self.closeBtn.transform = CGAffineTransformMakeRotation(0);
        self.alpha = 0;
        self.closeBtn.alpha = 0;
    }];
}
-(NSMutableArray *)itemArray{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}
-(UIView *)toolsBar{
    if (!_toolsBar) {
        _toolsBar = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT - 49, kSCREENWIDTH, 49)];
        _toolsBar.backgroundColor = [UIColor colorWithHex:0XFFFFFF alpha:1];
        
        _separateLayer = [CALayer layer];
        _separateLayer.frame = CGRectMake(self.width / 2 - 0.5, 0, 1, _toolsBar.height);
        _separateLayer.backgroundColor = [UIColor colorWithHex:0xefeae5].CGColor;
        [_toolsBar.layer addSublayer:_separateLayer];
        _separateLayer.hidden = YES;
    }
    return _toolsBar;
}
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        UIImage *icoImage = [UIImage imageNamed:@"tabbar_compose_background_icon_add"];
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.size = CGSizeMake(icoImage.size.width, icoImage.size.height);
        [_closeBtn setBackgroundImage:icoImage forState:UIControlStateNormal];
    }
    return _closeBtn;
}
-(UIButton *)backBtn{
    if (!_backBtn) {
        UIImage *icoImage = [UIImage imageNamed:@"tabbar_compose_background_icon_return"];
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.size = CGSizeMake(icoImage.size.width, icoImage.size.height);
        [_backBtn setBackgroundImage:icoImage forState:UIControlStateNormal];
    }
    return _backBtn;
}
-(UIScrollView *)contentSrollView{
    if (!_contentSrollView) {
        _contentSrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _contentSrollView.backgroundColor = [UIColor clearColor];
        _contentSrollView.contentSize = CGSizeMake(self.width * 2, self.height);
        _contentSrollView.pagingEnabled = YES;
        _contentSrollView.scrollEnabled = NO;
        _contentSrollView.bounces = NO;
        _contentSrollView.delegate = self;
    }
    return _contentSrollView;
}
-(UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compose_slogan"]];
    }
    return _logoImageView;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self switchPageOn:NO animation:YES];
}
@end

#pragma - mark WBComposeMenu

@interface WBComposeMenu ()
@property(nonatomic,strong)WBComposeMenuView *composeView;
@end

@implementation WBComposeMenu
-(void)show{
    [[self window] addSubview:self.composeView];
    [self.composeView appear];
}
-(void)hide{
    [self.composeView disAppear];
}
-(WBComposeMenuView *)composeView{
    if (!_composeView) {
        _composeView = [[WBComposeMenuView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _composeView;
}
-(UIWindow *)window{
    return [[UIApplication sharedApplication] keyWindow];
}
@end
