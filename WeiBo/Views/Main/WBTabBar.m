//
//  WBTabBar.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/2.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBTabBar.h"

@implementation WBTabBarItem
+(instancetype)initWithTitle:(NSString *)title imageNormal:(NSString *)imageNormal imageSelected:(NSString *)imageSelected type:(TarBarItemType)type{
    WBTabBarItem *barItem = [[WBTabBarItem alloc] init];
    barItem.title = title;
    barItem.imageNormal = imageNormal;
    barItem.imageSelected = imageSelected;
    barItem.type = type;
    return barItem;
}
@end

@implementation WBTabBarButton
-(instancetype)initWithBarItem:(WBTabBarItem *)barItem{
    if (self = [super init]) {
        self.barItem = barItem;
        if (barItem.type == TarBarItemTypeTitle) {
            self.backgroundColor = [UIColor clearColor];
            
            [self setImage:[UIImage imageNamed:barItem.imageNormal] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:barItem.imageSelected] forState:UIControlStateSelected];
            [self setImage:[UIImage imageNamed:barItem.imageSelected] forState:UIControlStateHighlighted];
            
            self.imageEdgeInsets = UIEdgeInsetsMake(-5,13,8,self.titleLabel.bounds.size.width);
            
            [self setTitle:barItem.title forState:UIControlStateNormal];//设置button的title
            self.titleLabel.font = [UIFont systemFontOfSize:10];//title字体大小
            self.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
            [self setTitleColor:[UIColor colorWithHex:0x6b6b6b]forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithHex:0xff8200] forState:UIControlStateSelected];
            [self setTitleColor:[UIColor colorWithHex:0xff8200] forState:UIControlStateHighlighted];
            
            self.titleEdgeInsets = UIEdgeInsetsMake(25,- self.bounds.size.width - 23, 0, 0);
        }
        if (barItem.type == TarBarItemTypeIco) {
            self.layer.masksToBounds = YES;
            self.layer.cornerRadius  = 5.0f;
            [self setBackgroundColor:[UIColor colorWithHex:0xff8200]];
            [self setImage:[UIImage imageNamed:barItem.imageNormal] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:barItem.imageSelected] forState:UIControlStateHighlighted];
        }
    }
    return self;
}
@end


@interface WBTabBar ()
@property(nonatomic,strong)NSArray *items;
@property(nonatomic,copy)SelectItemBlock selected;
@end

@implementation WBTabBar
-(instancetype)initWithFrame:(CGRect)frame items:(NSArray <WBTabBarItem *> *)items selected:(SelectItemBlock)selected{
    if (self = [super initWithFrame:frame]) {
        self.items = items;
        self.selected = selected;
        [self setupView];
    }
    return self;
}
-(void)setupView{
    CGFloat itemWidth = kSCREENWIDTH / self.items.count;
    CGFloat itemHeight = self.bounds.size.height;
    self.backgroundColor = [UIColor whiteColor];
    
    self.blurRadius = 40;
    self.tintColor  = [UIColor clearColor];
    self.dynamic    = YES;

    self.layer.shadowColor   = [UIColor grayColor].CGColor;
    self.layer.shadowOffset  = CGSizeMake(0,1);
    self.layer.shadowOpacity = 0.6;
    self.layer.shadowRadius  = 2;
    self.clipsToBounds       = NO;
    
    for (int i = 0; i < self.items.count ; i ++) {
        WBTabBarItem *item = self.items[i];
        
        UIView *barItemView = [UIView new];
        [self addSubview:barItemView];
        [barItemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(itemWidth * i);
            make.size.mas_equalTo(CGSizeMake(itemWidth, itemHeight));
        }];
        
        WBTabBarButton *barButton = [[WBTabBarButton alloc] initWithBarItem:item];
        barButton.tag = 100 + i;
        [barItemView addSubview:barButton];
        [barButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(barItemView.mas_centerX).offset(0);
            make.centerY.equalTo(barItemView.mas_centerY).offset(0);
            make.size.mas_equalTo(CGSizeMake(itemHeight, itemHeight - 8));
        }];
        if (i == 0) barButton.selected = YES;
        [barButton bk_addEventHandler:^(WBTabBarButton *sender) {
            sender.selected = YES;
            if (!sender.barItem.disSelected) {
                for (int i = 0; i < self.items.count; i ++) {
                    if (sender.tag != i + 100) {
                        UIButton *btn = [self viewWithTag:100 + i];
                        btn.selected = NO;
                    }
                }
            }
            if (self.selected) self.selected(sender.tag - 100);
        } forControlEvents:UIControlEventTouchUpInside];
    }
}
@end
