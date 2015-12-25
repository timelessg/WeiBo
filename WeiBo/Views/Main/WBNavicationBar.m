//
//  WBNavicationBar.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/3.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBNavicationBar.h"

#pragma - mark WBNavBarItem

@implementation WBNavBarItem

@end


#pragma - mark WBNavBarButton


@interface WBNavBarButton ()
@property(nonatomic,copy)ActionBlock action;
@end

@implementation WBNavBarButton
-(instancetype)initWithBarItem:(WBNavBarItem *)barItem{
    if (self = [super init]) {
        self.barItem = barItem;
        [self updateView];
        [self bk_addEventHandler:^(id sender) {
            if (self.action) self.action(sender);
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(instancetype)init{
    if (self = [super init]) {
        [self bk_addEventHandler:^(UIButton *sender) {
            if (self.action) self.action(sender);
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)updateView{
    [self setTitle:nil forState:UIControlStateNormal];
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    [self setBackgroundImage:nil forState:UIControlStateHighlighted];
    [self setImage:nil forState:UIControlStateNormal];
    [self setImage:nil forState:UIControlStateHighlighted];
    [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    if (self.barItem.type == WBNavBarItemTypeLabel) {
        [self setTitle:self.barItem.title forState:UIControlStateNormal];
        [self setTitleColor:self.barItem.textColorNormal forState:UIControlStateNormal];
        [self setTitleColor:self.barItem.textColorHighlighted forState:UIControlStateHighlighted];
        [self setTitle:self.barItem.title forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = self.barItem.font;
    }
    
    if (self.barItem.type == WBNavBarItemTypeTitle) {
        [self setTitle:self.barItem.title forState:UIControlStateNormal];
        [self setTitleColor:self.barItem.textColorNormal forState:UIControlStateNormal];
        [self setTitleColor:self.barItem.textColorHighlighted forState:UIControlStateHighlighted];
        [self setTitle:self.barItem.title forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = self.barItem.font;
        [self setBackgroundImage:[[UIImage imageNamed:@"navigationbar_filter_background_highlighted"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forState:UIControlStateHighlighted];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
        CGFloat imageWidth = self.imageView.intrinsicContentSize.width;
        self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + 17, 0, 0);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth - 10, 0, 0);
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(labelWidth + imageWidth + 20, 40));
        }];
    }
    
    if (self.barItem.type == WBNavBarItemTypeButton) {
        [self setBackgroundImage:[UIImage imageNamed:self.barItem.normalImage] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:self.barItem.highlightedImage] forState:UIControlStateHighlighted];
    }
    
    if (self.barItem.type == WBNavBarItemTypeBack) {
        [self setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
    }
    [self layoutIfNeeded];
}
-(void)setBarItem:(WBNavBarItem *)barItem{
    if (_barItem != barItem) {
        _barItem = barItem;
        [self updateView];
    }
}
@end


#pragma - mark WBNavicationBar

@interface WBNavicationBar ()
@property(nonatomic,strong)WBNavBarButton *rightBtn;
@property(nonatomic,strong)WBNavBarButton *titleBtn;
@property(nonatomic,strong)WBNavBarButton *leftBtn;
@end

@implementation WBNavicationBar
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.barTintColor = nil;
        
        self.layer.shadowColor   = [UIColor grayColor].CGColor;
        self.layer.shadowOffset  = CGSizeMake(0,-1);
        self.layer.shadowOpacity = 0.6;
        self.layer.shadowRadius  = 2;
        self.clipsToBounds       = NO;
        
        [self addSubview:self.titleBtn];
        [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-6);
            make.centerX.equalTo(self.mas_centerX).offset(0);
        }];
        [self addSubview:self.rightBtn];
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        [self addSubview:self.leftBtn];
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.left.equalTo(self.mas_left).offset(15);
        }];
    }
    return self;
}
-(void)setTitleSelected:(BOOL)titleSelected{
    _titleSelected = titleSelected;
    self.titleBtn.selected = _titleSelected;
}
-(void)setLeftBarItem:(WBNavBarItem *)leftBarItem{
    if (_leftBarItem != leftBarItem) {
        _leftBarItem = leftBarItem;
        self.leftBtn.hidden = leftBarItem ? NO : YES;
        self.leftBtn.barItem = _leftBarItem;
    }
}
-(void)setTitleBarItem:(WBNavBarItem *)titleBarItem{
    if (_titleBarItem != titleBarItem) {
        _titleBarItem = titleBarItem;
        self.titleBtn.hidden = _titleBarItem ? NO : YES;
        self.titleBtn.barItem = _titleBarItem;
    }
}
-(void)setRightBarItem:(WBNavBarItem *)rightBarItem{
    if (_rightBarItem != rightBarItem) {
        _rightBarItem = rightBarItem;
        self.rightBtn.hidden = _rightBarItem ? NO : YES;
        self.rightBtn.barItem = _rightBarItem;
    }
}
-(WBNavBarButton *)titleBtn{
    if (!_titleBtn) {
        _titleBtn = [[WBNavBarButton alloc] init];
        _titleBtn.tag = 1002;
        [_titleBtn bk_addEventHandler:^(id sender) {
            if (_titleBarItem.action) _titleBarItem.action(sender);
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleBtn;
}
-(WBNavBarButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[WBNavBarButton alloc] init];
        _leftBtn.tag = 1000;
        [_leftBtn bk_addEventHandler:^(id sender) {
            if (_leftBarItem.action) _leftBarItem.action(sender);
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
-(WBNavBarButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[WBNavBarButton alloc] init];
        _rightBtn.tag = 1001;
        [_rightBtn bk_addEventHandler:^(id sender) {
            if (_rightBarItem.action) _rightBarItem.action(sender);
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
-(void)setTitle:(NSString *)title{
    if (_title != title) {
        _title = title;
        _titleBarItem.title = title;
        [((WBNavBarButton *)[self viewWithTag:1002]) setTitle:_title forState:UIControlStateNormal];
    }
}
@end
