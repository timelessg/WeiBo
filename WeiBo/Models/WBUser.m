//
//  WBUser.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/3.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBUser.h"

#define USERPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"user.dat"]

@implementation WBUser
MJExtensionCodingImplementation
+(BOOL)isLogin{
    if ([WBUser user]){
        return YES;
    }
    return NO;
}
+(WBUser *)user{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:USERPATH];
}
-(BOOL)archive{
    return [NSKeyedArchiver archiveRootObject:self toFile:USERPATH];
}
@end
