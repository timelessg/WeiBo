//
//  WBNavicationBar.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/3.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBNavicationBar.h"

@implementation WBNavBarItem

@end


@interface WBNavBarButton ()
@property(nonatomic,copy)ActionBlock action;
@end

@implementation WBNavBarButton
-(instancetype)initWithBarItem:(WBNavBarItem *)barItem{
    if (self = [super init]) {
        if (barItem.type == WBNavBarItemTypeLabel) {
            [self setTitle:barItem.title forState:UIControlStateNormal];
            [self setTitleColor:barItem.textColorNormal forState:UIControlStateNormal];
            [self setTitleColor:barItem.textColorHighlighted forState:UIControlStateHighlighted];
            [self setTitle:barItem.title forState:UIControlStateNormal];
        }
        
        if (barItem.type == WBNavBarItemTypeButton) {
            [self setBackgroundImage:[UIImage imageNamed:barItem.normalImage] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:barItem.highlightedImage] forState:UIControlStateHighlighted];
        }
        
        if (barItem.type == WBNavBarItemTypeBack) {
            [self setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        }
        [self bk_addEventHandler:^(id sender) {
            if (self.action) self.action();
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
@end



@implementation WBNavicationBar
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.blurRadius = 40;
        self.tintColor  = [UIColor clearColor];
        self.dynamic    = YES;
        
        self.layer.shadowColor   = [UIColor grayColor].CGColor;
        self.layer.shadowOffset  = CGSizeMake(0,-1);
        self.layer.shadowOpacity = 0.6;
        self.layer.shadowRadius  = 2;
        self.clipsToBounds       = NO;
        
        [self.titleBarItem addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}
-(void)setLeftBarItem:(WBNavBarItem *)leftBarItem{
    if ((_leftBarItem != leftBarItem) && leftBarItem) {
        _leftBarItem = leftBarItem;
        WBNavBarButton *barButton = [[WBNavBarButton alloc] initWithBarItem:leftBarItem];
        [self addSubview:barButton];
        [barButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.left.equalTo(self.mas_left).offset(15);
        }];
    }
}
-(void)setRightBarItem:(WBNavBarItem *)rightBarItem{
    if ((_rightBarItem != rightBarItem) && rightBarItem) {
        _rightBarItem = rightBarItem;
        WBNavBarButton *barButton = [[WBNavBarButton alloc] initWithBarItem:_rightBarItem];
        [self addSubview:barButton];
        [barButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
    }
}
-(void)setTitleBarItem:(WBNavBarItem *)titleBarItem{
    if ((_titleBarItem != titleBarItem) && titleBarItem) {
        _titleBarItem = titleBarItem;
        WBNavBarButton *barButton = [[WBNavBarButton alloc] initWithBarItem:_titleBarItem];
        [self addSubview:barButton];
        [barButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.centerX.equalTo(self.mas_centerX).offset(0);
        }];
    }
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
}
@end
