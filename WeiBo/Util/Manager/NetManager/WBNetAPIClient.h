//
//  WBNetAPIClient.h
//  WeiBo
//
//  Created by 郭锐 on 15/12/3.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger,NetWorkMethod) {
    NetWorkMethodGet,
    NetWorkMethodPost,
    NetWorkMethodPut,
    NetWorkMethodDelete,
};

@interface WBNetAPIClient : AFHTTPRequestOperationManager
+(WBNetAPIClient *)shareClient;
- (void)requestDataWithPath:(NSString *)aPath
                     params:(NSDictionary *)params
                 methodType:(NetWorkMethod)methodType
                   andBlock:(void (^)(id data, NSError *error))block;
- (void)requestDataWithPath:(NSString *)aPath
                     params:(NSDictionary *)params
                 methodType:(NetWorkMethod)methodType
                  showError:(BOOL)showError
                   andBlock:(void (^)(id data, NSError *error))block;
-(void)requestDataWithPath:(NSString *)aPath
                    params:(NSDictionary *)params
                methodType:(NetWorkMethod)methodType
                 showError:(BOOL)showError
                  useCache:(BOOL)useCache
                  andBlock:(void (^)(id data, NSError *error))block;
@end
