//
//  NetAPIManager.h
//  WeiBo
//
//  Created by 郭锐 on 15/12/3.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetAPIManager : NSObject
+(void)getHomeTimeLineWithPage:(NSUInteger)page andBlock:(void (^)(id data, NSError *error))block;
+(void)getPublicTimeLineWithPage:(NSUInteger)page andBlock:(void (^)(id data, NSError *error))block;
@end
