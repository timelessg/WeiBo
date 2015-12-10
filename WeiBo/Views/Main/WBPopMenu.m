//
//  WBPopMenu.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/7.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBPopMenu.h"



@implementation WBPopMenuBg
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    UIView *view = [touch view];
    if ([view isKindOfClass:[WBPopMenuBg class]]) {
        if (self.touchBegan) {
            self.touchBegan();
        }
    }
}
@end

#pragma - mark WBPopMenuCell

@interface WBPopMenuCell ()

@end

@implementation WBPopMenuCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
@end

#pragma - mark WBPopMenu

@interface WBPopMenu () <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)WBPopMenuType type;
@property(nonatomic,strong)NSArray *items;
@property(nonatomic,strong)IndexSelect block;
@property(nonatomic,strong)WBPopMenuBg *bgView;
@property(nonatomic,strong)UIImageView *menuView;
@property(nonatomic,strong)UITableView *menuTableView;
@end

@implementation WBPopMenu

-(instancetype)initWithItems:(NSArray *)items type:(WBPopMenuType)type selectIndex:(IndexSelect)selectIndex{
    if (self = [super init]) {
        self.type = type;
        self.items = items;
        self.block = selectIndex;
        [self setupView];
    }
    return self;
}
-(void)setupView{
    [[self window] addSubview:self.bgView];
    [self.bgView addSubview:self.menuView];
    [self.menuView addSubview:self.menuTableView];
}
-(UITableView *)menuTableView{
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, 150, 200)];
        [_menuTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _menuTableView.rowHeight = 36;
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.alpha = 0;
        _menuTableView.hidden = YES;
        _menuTableView.backgroundColor = [UIColor clearColor];
    }
    return _menuTableView;
}
-(UIImageView *)menuView{
    if (!_menuView) {
        UIImage *popCover = [[UIImage imageNamed:@"popover_background"] stretchableImageWithLeftCapWidth:6 topCapHeight:12
                             ];
        _menuView = [[UIImageView alloc] initWithImage:popCover];
        _menuView.alpha = 0.6;
        _menuView.frame  = CGRectMake(0, 0, 150, 200);
        _menuView.center = CGPointMake([self window].center.x, 44 + 20 + 75 + 15);
    }
    return _menuView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.items count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.items[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(WBPopMenuBg *)bgView{
    if (!_bgView) {
        _bgView = [[WBPopMenuBg alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.touchBegan = ^(){
            
        };
    }
    return _bgView;
}
-(UIWindow *)window{
    return [[UIApplication sharedApplication] keyWindow];
}
-(void)show{
    _menuTableView.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        _menuTableView.alpha = 1.0f;
    }];
}
@end
