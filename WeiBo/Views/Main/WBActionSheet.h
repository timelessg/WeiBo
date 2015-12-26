//
//  WBActionSheet.h
//  WeiBo
//
//  Created by 郭锐 on 15/12/25.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedItem)(NSUInteger);

@interface WBActionSheetButton : UIButton
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
@end

@interface WBActionSheet : NSObject
+(void)showItemItems:(NSArray *)items select:(SelectedItem)selected;
+(void)dismiss;
@end