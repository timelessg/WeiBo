//
//  WBTabBar.h
//  WeiBo
//
//  Created by 郭锐 on 15/12/2.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FXBlurView.h>

typedef NS_ENUM(NSUInteger,TarBarItemType) {
    TarBarItemTypeTitle = 0 ,
    TarBarItemTypeIco = 1,
};
@interface WBTabBarItem : NSObject
+(instancetype)initWithTitle:(NSString *)title imageNormal:(NSString *)imageNormal imageSelected:(NSString *)imageSelected type:(TarBarItemType)type;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *imageNormal;
@property(nonatomic,copy)NSString *imageSelected;
@property(nonatomic,assign)TarBarItemType type;
@property(nonatomic,assign)BOOL disSelected;
@end

@interface WBTabBarButton : UIButton
@property(nonatomic,strong)WBTabBarItem *barItem;
-(instancetype)initWithBarItem:(WBTabBarItem *)barItem;
@end

typedef void(^SelectItemBlock)(NSUInteger itemIndex);

@interface WBTabBar : UIToolbar
-(instancetype)initWithFrame:(CGRect)frame items:(NSArray <WBTabBarItem *> *)items selected:(SelectItemBlock)selected;
@end
