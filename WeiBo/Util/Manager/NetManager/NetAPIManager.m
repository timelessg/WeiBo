//
//  NetAPIManager.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/3.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "NetAPIManager.h"
#import "WBNetAPIClient.h"
#import "WBStatuse.h"

@implementation NetAPIManager
+(void)getHomeTimeLineWithPage:(NSUInteger)page andBlock:(void (^)(id, NSError *))block{
    [[WBNetAPIClient shareClient] requestDataWithPath:TimelineHome params:@{@"count":@(20),@"page":@(page),@"feature":@0,@"trim_user":@0} methodType:NetWorkMethodGet andBlock:^(id data, NSError *error) {
        if (!error) {
            NSArray *dataArray = data[@"statuses"];
            __block NSMutableArray *tmpArray = [NSMutableArray array];
            [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                WBStatuse *statue = [WBStatuse mj_objectWithKeyValues:obj];
                [tmpArray addObject:statue];
            }];
            block(tmpArray,nil);
        }else{
            block(nil,error);
        }
    }];
}
+(void)getPublicTimeLineWithPage:(NSUInteger)page andBlock:(void (^)(id, NSError *))block{
    [[WBNetAPIClient shareClient] requestDataWithPath:TimelinePublic params:@{@"count":@(20),@"page":@(page)} methodType:NetWorkMethodGet andBlock:^(id data, NSError *error) {
        if (!error) {
            NSArray *dataArray = data[@"statuses"];
            __block NSMutableArray *tmpArray = [NSMutableArray array];
            [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                WBStatuse *statue = [WBStatuse mj_objectWithKeyValues:obj];
                [tmpArray addObject:statue];
            }];
            block(tmpArray,nil);
        }else{
            block(nil,error);
        }
    }];
}
@end
