//
//  WBStatuse.h
//  WeiBo
//
//  Created by 郭锐 on 15/12/3.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUser.h"

@interface WBPic : NSObject
@property(nonatomic,copy)NSString *thumbnail_pic;
@end

@interface WBGeo : NSObject

@end

@interface WBStatuse : NSObject
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,assign,getter=isFavorited)BOOL favorited;
@property(nonatomic,assign,getter=isTruncated)BOOL truncated;
@property(nonatomic,copy)NSString *in_reply_to_status_id;
@property(nonatomic,copy)NSString *in_reply_to_user_id;
@property(nonatomic,copy)NSString *in_reply_to_screen_name;
@property(nonatomic,strong)NSArray *pic_urls;
@property(nonatomic,copy)NSString *thumbnail_pic;
@property(nonatomic,copy)NSString *bmiddle_pic;
@property(nonatomic,copy)NSString *original_pic;
@property(nonatomic,strong)WBGeo *geo;
@property(nonatomic,strong)WBUserInfo *user;
@property(nonatomic,strong)WBStatuse *retweeted_status;
@property(nonatomic,assign)NSUInteger reposts_count;
@property(nonatomic,assign)NSUInteger comments_count;
@property(nonatomic,assign)NSUInteger attitudes_count;
@property(nonatomic,assign)NSUInteger mlevel;
@property(nonatomic,assign)NSUInteger biz_feature;
@property(nonatomic,assign)NSUInteger userType;
@property(nonatomic,strong)NSArray *darwin_tags;
@end
