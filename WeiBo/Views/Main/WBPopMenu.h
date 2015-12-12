//
//  WBPopMenu.h
//  WeiBo
//
//  Created by 郭锐 on 15/12/7.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBPopItem : NSObject
@property(nonatomic,copy)NSString *item;
@property(nonatomic,assign,getter=isSelected)BOOL selected;
+(instancetype)item:(NSString *)item;
@end

@interface WBPopMenuBg : UIView
@property(nonatomic,copy)void (^touchBegan)(void);
@end

@interface WBPopMenuSectionView : UIView
@property(nonatomic,copy)NSString *sectionStr;
@end

@interface WBPopMenuCell : UITableViewCell
@property(nonatomic,copy)WBPopItem *item;
@property(nonatomic,assign,getter=isSelected)BOOL select;
@end

typedef NS_ENUM(NSUInteger,WBPopMenuType) {
    WBPopMenuTypeLeft,
    WBPopMenuTypeCenter,
    WBPopMenuTypeRight,
};

typedef void(^IndexSelect)(NSUInteger);

@interface WBPopMenu : NSObject
-(instancetype)initWithItems:(NSArray *)items type:(WBPopMenuType)type selectIndex:(IndexSelect)selectIndex;
-(void)show;
@end
