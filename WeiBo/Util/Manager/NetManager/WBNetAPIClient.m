//
//  WBNetAPIClient.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/3.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBNetAPIClient.h"
#import "WBUser.h"

@interface WBNetAPIClient ()
@property(nonatomic,strong)WBUser *user;
@end

@implementation WBNetAPIClient
+(WBNetAPIClient *)shareClient{
    static dispatch_once_t onceToken;
    static WBNetAPIClient *client;
    dispatch_once(&onceToken, ^{
        client = [[WBNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
    });
    return client;
}
-(instancetype)initWithBaseURL:(NSURL *)url{
    if (self = [super initWithBaseURL:url]) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer  = [AFJSONRequestSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"application/txt",@"application/octet-stream", nil];
    }
    return self;
}
-(void)removeTokenData{
    [self.requestSerializer setValue:@"" forHTTPHeaderField:@"X-Token"];
}
-(void)requestDataWithPath:(NSString *)aPath params:(NSDictionary *)params methodType:(NetWorkMethod)methodType andBlock:(void (^)(id, NSError *))block
{
    [self requestDataWithPath:aPath params:params methodType:methodType showError:NO andBlock:block];
}
-(void)requestDataWithPath:(NSString *)aPath params:(NSDictionary *)params methodType:(NetWorkMethod)methodType showError:(BOOL)showError useCache:(BOOL)useCache andBlock:(void (^)(id, NSError *))block{
    if (!aPath || aPath.length <= 0) {
        return;
    }
    NSMutableDictionary *mutableDic = [params mutableCopy];
    [mutableDic addEntriesFromDictionary:@{@"source":@"",@"access_token":self.user.access_token,@"base_app":@NO}];
    
    switch (methodType) {
        case NetWorkMethodGet:{
            [self GET:aPath parameters:mutableDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//                NSLog(@"%@",[[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding]);
                if ([responseObject[@"status"] integerValue] >= 0) {
                    if (useCache) {
                        NSCachedURLResponse *cachedURLResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:operation.request];
                        cachedURLResponse = [[NSCachedURLResponse alloc] initWithResponse:operation.response data:operation.responseData userInfo:nil storagePolicy:NSURLCacheStorageAllowed];
                        [[NSURLCache sharedURLCache] storeCachedResponse:cachedURLResponse forRequest:operation.request];
                    }
                    block(responseObject,nil);
                }else{
                    block(nil, showError ? [self errorWithInfo:responseObject] :responseObject);
                }
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                if ((error.code == kCFURLErrorNotConnectedToInternet || error.code == kCFURLErrorCannotConnectToHost) && useCache) {
                    NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:operation.request];
                    if (cachedResponse && cachedResponse.data.length > 0) {
                        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:cachedResponse.data options:NSJSONReadingMutableLeaves error:nil];
                        block(dict, nil);
                    } else {
                        block(nil,showError ? [self errorWithInfo:error] : error);
                    }
                }else{
                    block(nil,showError ? [self errorWithInfo:error] : error);
                }
            }];
            break;
        }
        case NetWorkMethodPost:{
            [self POST:aPath parameters:mutableDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                if ([responseObject[@"status"] integerValue] >= 0) {
                    block(responseObject,nil);
                }else{
                    block(nil, showError ? [self errorWithInfo:responseObject] :responseObject);
                }
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                block(nil,showError ? [self errorWithInfo:error] : error);
            }];
            break;
        }
        default:
            break;
    }
}
-(void)requestDataWithPath:(NSString *)aPath params:(NSDictionary *)params methodType:(NetWorkMethod)methodType showError:(BOOL)showError andBlock:(void (^)(id, NSError *))block{
    [self requestDataWithPath:aPath params:params methodType:methodType showError:showError useCache:NO andBlock:block];
}
-(WBUser *)user{
    if (!_user) {
        _user = [WBUser user];
    }
    return _user;
}
-(id)errorWithInfo:(id)info{
    return nil;
}
-(void)cancelTask{
    [self.operationQueue cancelAllOperations];
}
-(void)removeAllCache{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
