//
//  WBPopMenu.h
//  WeiBo
//
//  Created by 郭锐 on 15/12/7.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,WBPopMenuType) {
    WBPopMenuTypeLeft,
    WBPopMenuTypeCenter,
    WBPopMenuTypeRight,
};

@interface WBPopItem : NSObject
@property(nonatomic,copy)NSString *item;
@property(nonatomic,copy)NSString *icoImage;
@property(nonatomic,assign,getter=isSelected)BOOL selected;
@property(nonatomic,assign,getter=isLike)BOOL like;
+(instancetype)item:(NSString *)item selected:(BOOL)selected like:(BOOL)like;
+(instancetype)item:(NSString *)item image:(NSString *)image;
@end

@interface WBPopMenuBg : UIView
@property(nonatomic,copy)void (^touchBegan)(void);
@end

@interface WBPopoverSectionView : UIView
@property(nonatomic,copy)NSString *sectionStr;
@end


@interface WBPopoverCell : UITableViewCell
@property(nonatomic,copy)WBPopItem *item;
@property(nonatomic,copy)void (^didSelectItem)(NSString *);
-(instancetype)initWithType:(WBPopMenuType)type;
@end


typedef void(^IndexSelect)(NSString *);

@interface WBPopover : NSObject
@property(nonatomic,copy)void (^didClickEdit)(void);
-(instancetype)initWithItems:(NSArray *)items height:(CGFloat)height type:(WBPopMenuType)type selectIndex:(IndexSelect)selectIndex;
-(void)show;
@end
