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
-(instancetype)initWithItem:(WBNavBarItem *)item{
    if (self = [super init]) {
        self.barItem = item;
        self.action = self.barItem.action;
        
        [self bk_addEventHandler:^(UIButton *sender) {
            if (self.action) self.action(sender);
        } forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat textWidth = [self.barItem.title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.barItem.font.xHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.barItem.font} context:nil].size.width;
        
        if (self.barItem.type == WBNavBarItemTypeLabel) {
            [self setTitle:self.barItem.title forState:UIControlStateNormal];
            [self setTitleColor:self.barItem.textColorNormal forState:UIControlStateNormal];
            [self setTitleColor:self.barItem.textColorHighlighted forState:UIControlStateHighlighted];
            [self setTitle:self.barItem.title forState:UIControlStateNormal];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.font = self.barItem.font;
            
            self.frame = CGRectMake(0, 0, textWidth , 30);
        }
        
        if (self.barItem.type == WBNavBarItemTypeTitle) {
            [self setTitle:self.barItem.title forState:UIControlStateNormal];
            [self setTitleColor:self.barItem.textColorNormal forState:UIControlStateNormal];
            [self setTitleColor:self.barItem.textColorHighlighted forState:UIControlStateHighlighted];
            [self setTitle:self.barItem.title forState:UIControlStateNormal];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.font = self.barItem.font;
            [self setBackgroundImage:[[UIImage imageNamed:@"navigationbar_filter_background_highlighted"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forState:UIControlStateHighlighted];
            UIImage *arrowDownIco = [UIImage imageNamed:@"navigationbar_arrow_down"];
            UIImage *arrowUpIco = [UIImage imageNamed:@"navigationbar_arrow_up"];
            
            [self setImage:arrowDownIco forState:UIControlStateSelected];
            [self setImage:arrowUpIco forState:UIControlStateNormal];
            self.imageEdgeInsets = UIEdgeInsetsMake(0, textWidth + 15, 0, 0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -arrowDownIco.size.width - 10, 0, 0);
            self.frame = CGRectMake(0, 0, textWidth + arrowDownIco.size.width + 20, 35);
        }
        
        if (self.barItem.type == WBNavBarItemTypeButton) {
            UIImage *normalIco = [UIImage imageNamed:self.barItem.normalImage];
            UIImage *lightedIco = [UIImage imageNamed:self.barItem.highlightedImage];
            
            [self setImage:normalIco forState:UIControlStateNormal];
            [self setImage:lightedIco forState:UIControlStateHighlighted];
            self.frame = CGRectMake(0, 0, normalIco.size.width , normalIco.size.height);
        }
        
        if (self.barItem.type == WBNavBarItemTypeBack) {
            UIImage *backIco = [UIImage imageNamed:@"navigationbar_back"];
            UIImage *backlightedIco = [UIImage imageNamed:@"navigationbar_back"];
            
            [self setImage:backIco forState:UIControlStateNormal];
            [self setImage:backlightedIco forState:UIControlStateHighlighted];
            self.frame = CGRectMake(0, 0, backIco.size.width , backIco.size.height);
        }

    }
    return self;
}
@end