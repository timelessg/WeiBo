//
//  WBActionSheet.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/25.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBActionSheet.h"
#import <FXBlurView.h>

@implementation WBActionSheetButton
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        [self setTitle:title forState:UIControlStateNormal];
        self.backgroundColor = [UIColor colorWithHex:0xf7f7f7];
        [self setTitleColor:[UIColor colorWithHex:0x323232] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:20];
        [self bk_addEventHandler:^(UIButton *sender) {
            sender.backgroundColor = [UIColor colorWithHex:0xf0f0f0];
        } forControlEvents:UIControlEventTouchDown];
    }
    return self;
}
@end

@interface WBActionSheet ()
@property(nonatomic,copy)SelectedItem block;
@property(nonatomic,strong)UIView *sheetView;
@end

@implementation WBActionSheet
+(void)showItemItems:(NSArray *)items select:(SelectedItem)selected{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *bgView = [[UIView alloc] initWithFrame:window.frame];
    bgView.tag = 999;
    
    CGFloat height = (items.count + 1) * 56;
    FXBlurView *sheetView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, kSCREENHEIGHT, kSCREENWIDTH, height)];
    sheetView.backgroundColor = [UIColor colorWithHex:0xf7f7f7 alpha:0.8];
    sheetView.tag = 998;
    for (int i = 0; i < items.count + 1; i ++ ) {
        NSString *itemStr = (items.count == i) ? @"取消" : items[i];
        WBActionSheetButton *itemBtn = [[WBActionSheetButton alloc] initWithFrame:CGRectMake(0, i * 56, kSCREENWIDTH, 56) title:itemStr];
        itemBtn.tag = (items.count == i) ? 200 : 100 + i;
        [sheetView addSubview:itemBtn];
        [itemBtn bk_addEventHandler:^(UIButton *sender) {
            sender.backgroundColor = [UIColor colorWithHex:0xffffff];
            if (sender.tag == 200) {
                [[self class] dismiss];
            }
            selected(sender.tag);
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        CALayer *lineLayer = [CALayer layer];
        lineLayer.backgroundColor = [UIColor colorWithHex:0xdddddd].CGColor;
        lineLayer.frame = (items.count == i) ? CGRectMake(0, 56 * i, kSCREENWIDTH, 5) : CGRectMake(0, 56 * i - 1, kSCREENWIDTH, 1);
        [sheetView.layer addSublayer:lineLayer];
        
    }
    [bgView addSubview:sheetView];
    bgView.backgroundColor = [UIColor colorWithHex:0x888888 alpha:0];
    
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    [UIView animateWithDuration:0.25 animations:^{
        bgView.backgroundColor = [UIColor colorWithHex:0x888888 alpha:0.4];
        sheetView.frame = CGRectMake(0, kSCREENHEIGHT - height, kSCREENWIDTH, height);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        [[self class] dismiss];
    }];
    [bgView addGestureRecognizer:tap];
}
+(void)dismiss{
    UIView *bgView = [[[UIApplication sharedApplication] keyWindow] viewWithTag:999];
    UIView *sheetView = [bgView viewWithTag:998];
    
    [UIView animateWithDuration:0.25 animations:^{
        bgView.backgroundColor = [UIColor colorWithHex:0x888888 alpha:0];
        sheetView.frame = CGRectMake(0, kSCREENHEIGHT, kSCREENWIDTH, sheetView.height);
    }completion:^(BOOL finished) {
        [bgView removeFromSuperview];
    }];
}
@end