//
//  WBNavicationBar.h
//  WeiBo
//
//  Created by 郭锐 on 15/12/3.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FXBlurView.h>

typedef NS_ENUM(NSUInteger,WBNavBarItemType) {
    WBNavBarItemTypeLabel,
    WBNavBarItemTypeButton,
    WBNavBarItemTypeBack,
};

typedef void(^ActionBlock)(void);

@interface WBNavBarItem : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)UIFont   *font;
@property(nonatomic,strong)UIColor  *textColorNormal;
@property(nonatomic,strong)UIColor  *textColorHighlighted;

@property(nonatomic,copy)NSString *normalImage;
@property(nonatomic,copy)NSString *highlightedImage;

@property(nonatomic,assign)WBNavBarItemType type;
@property(nonatomic,copy)ActionBlock action;
@end


@interface WBNavBarButton : UIButton
-(instancetype)initWithBarItem:(WBNavBarItem *)barItem;
@end


@interface WBNavicationBar : FXBlurView
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)WBNavBarItem *titleBarItem;
@property(nonatomic,strong)WBNavBarItem *leftBarItem;
@property(nonatomic,strong)WBNavBarItem *rightBarItem;
@end
