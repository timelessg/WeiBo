//
//  WBUser.h
//  WeiBo
//
//  Created by 郭锐 on 15/12/3.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUserInfo : NSObject
@property(nonatomic,strong)NSNumber *id;
@property(nonatomic,copy)NSString *screen_name;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *province;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *location;
@property(nonatomic,copy)NSString *description;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *profile_image_url;
@property(nonatomic,copy)NSString *domain;
@property(nonatomic,copy)NSString *gender;
@property(nonatomic,assign)NSUInteger followers_count;
@property(nonatomic,assign)NSUInteger friends_count;
@property(nonatomic,assign)NSUInteger statuses_count;
@property(nonatomic,assign)NSUInteger favourites_count;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,assign)BOOL following;
@property(nonatomic,assign)BOOL allow_all_act_msg;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,assign)BOOL geo_enabled;
@property(nonatomic,assign)BOOL verified;
@property(nonatomic,assign)BOOL allow_all_comment;
@property(nonatomic,copy)NSString *avatar_large;
@property(nonatomic,copy)NSString *verified_reason;
@property(nonatomic,assign)BOOL follow_me;
@property(nonatomic,assign)NSUInteger online_status;
@property(nonatomic,assign)NSUInteger bi_followers_count;
@end

@interface WBUser : NSObject
@property(nonatomic,copy)  NSString *uid;
@property(nonatomic,strong)NSNumber *expires_in;
@property(nonatomic,copy)  NSString *access_token;
@property(nonatomic,copy)  NSString *remind_in;
+(BOOL)isLogin;
+(WBUser *)user;
-(BOOL)archive;
@end
