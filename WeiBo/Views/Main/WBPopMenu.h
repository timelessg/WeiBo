//
//  WBPopMenu.h
//  WeiBo
//
//  Created by 郭锐 on 15/12/7.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBPopMenuBg : UIView
@property(nonatomic,copy)void (^touchBegan)(void);
@end

@interface WBPopMenuCell : UITableViewCell

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
