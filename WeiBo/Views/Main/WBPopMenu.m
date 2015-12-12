//
//  WBPopMenu.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/7.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBPopMenu.h"

#pragma - mark WBPopItem

@implementation WBPopItem
+(instancetype)item:(NSString *)item{
    WBPopItem *popItem = [WBPopItem new];
    popItem.item = item;
    popItem.selected = NO;
    return popItem;
}
@end

#pragma - mark WBPopMenuBg

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

#pragma - mark WBPopMenuSectionView;

@interface WBPopMenuSectionView ()
@property(nonatomic,strong)UILabel *sectionLabel;
@property(nonatomic,strong)UIView *leftLine;
@property(nonatomic,strong)UIView *rightLine;
@end

@implementation WBPopMenuSectionView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    [self addSubview:self.leftLine];
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(18, 1));
    }];
    [self addSubview:self.sectionLabel];
    [self.sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLine.mas_right).offset(2);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
    [self addSubview:self.rightLine];
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sectionLabel.mas_right).offset(2);
        make.right.equalTo(self.mas_right).offset(-7);
        make.height.mas_equalTo(1);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
}
-(void)setSectionStr:(NSString *)sectionStr{
    if (_sectionStr != sectionStr) {
        _sectionStr = sectionStr;
        self.sectionLabel.text = _sectionStr;
    }
}
-(UILabel *)sectionLabel{
    if (!_sectionLabel) {
        _sectionLabel = [[UILabel alloc] init];
        _sectionLabel.font = [UIFont systemFontOfSize:12];
        _sectionLabel.textColor = [UIColor colorWithHex:0X333333];
    }
    return _sectionLabel;
}
-(UIView *)leftLine{
    if (!_leftLine) {
        _leftLine = [UIView new];
        _leftLine.backgroundColor = [UIColor colorWithHex:0X4D4D4D];
    }
    return _leftLine;
}
-(UIView *)rightLine{
    if (!_rightLine) {
        _rightLine = [UIView new];
        _rightLine.backgroundColor = [UIColor colorWithHex:0X4D4D4D];
    }
    return _rightLine;
}
@end

#pragma - mark WBPopMenuCell

@interface WBPopMenuCell ()
@property(nonatomic,strong)UILabel *itemLabel;
@property(nonatomic,strong)UIImageView *selectedView;
@end

@implementation WBPopMenuCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundView = self.selectedView;
        [self setupView];
    }
    return self;
}
-(void)setupView{
    [self addSubview:self.itemLabel];
    [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
}
-(void)setItem:(WBPopItem *)item{
    if (_item != item) {
        _item = item;
        self.itemLabel.text = item.item;
        self.itemLabel.textColor = item.selected ? [UIColor colorWithHex:0Xf4a40f] : [UIColor whiteColor];
    }
}
-(UILabel *)itemLabel{
    if (!_itemLabel) {
        _itemLabel = [[UILabel alloc] init];
        _itemLabel.font = [UIFont boldSystemFontOfSize:18];
        _itemLabel.textColor = [UIColor whiteColor];
    }
    return _itemLabel;
}
-(UIImageView *)selectedView{
    if (!_selectedView) {
        UIImage *selectedImage = [[UIImage imageNamed:@"popover_background_selected"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        _selectedView = [[UIImageView alloc] initWithImage:selectedImage];
        _selectedView.frame = CGRectMake(0, 6, self.width, self.height - 12);
    }
    return _selectedView;
}
-(void)setSelect:(BOOL)select{
    self.itemLabel.textColor = select ? [UIColor colorWithHex:0Xf4a40f] : [UIColor whiteColor];
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
}
-(UITableView *)menuTableView{
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 22, self.menuView.width - 20, self.menuView.height - 32) style:UITableViewStyleGrouped];
        [_menuTableView registerClass:[WBPopMenuCell class] forCellReuseIdentifier:@"cell"];
        _menuTableView.rowHeight = 34;
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.backgroundColor = [UIColor clearColor];
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _menuTableView;
}
-(UIImageView *)menuView{
    if (!_menuView) {
        UIImage *popCover = [[UIImage imageNamed:@"popover_background"] stretchableImageWithLeftCapWidth:6 topCapHeight:12];
        _menuView = [[UIImageView alloc] initWithImage:popCover];
        _menuView.alpha = 0.9;
        _menuView.frame  = CGRectMake(0, 0, 193, 366);
        _menuView.center = CGPointMake([self window].center.x, 44 + 20 + 175);
        _menuView.userInteractionEnabled = YES;
        [_menuView addSubview:self.menuTableView];
    }
    return _menuView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.items count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.items[section][@"items"] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.items[section][@"section"] isEqualToString:@""] ? CGFLOAT_MIN : 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WBPopMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.item = self.items[indexPath.section][@"items"][indexPath.row];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *sectionStr = self.items[section][@"section"];
    WBPopMenuSectionView *sectionView = ([sectionStr isEqualToString:@""]) ? nil : [[WBPopMenuSectionView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 36)];
    sectionView.sectionStr = sectionStr;
    return sectionView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ((WBPopItem *)self.items[indexPath.section][@"items"][indexPath.row]).selected = YES;
    ((WBPopMenuCell *)[tableView cellForRowAtIndexPath:indexPath]).select = YES;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    ((WBPopItem *)self.items[indexPath.section][@"items"][indexPath.row]).selected = NO;
    ((WBPopMenuCell *)[tableView cellForRowAtIndexPath:indexPath]).select = NO;
}
-(WBPopMenuBg *)bgView{
    if (!_bgView) {
        WS(weakSelf);
        _bgView = [[WBPopMenuBg alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.touchBegan = ^(){
            [weakSelf hide];
        };
    }
    return _bgView;
}
-(UIWindow *)window{
    return [[UIApplication sharedApplication] keyWindow];
}
-(void)show{
    _bgView.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        _menuView.alpha = 1.0f;
        _menuView.hidden = NO;
    }];
}
-(void)hide{
    [UIView animateWithDuration:0.25 animations:^{
        _menuView.alpha = 0.0f;
    }completion:^(BOOL finished) {
        _menuView.hidden = YES;
        _bgView.hidden = YES;
    }];
}
@end
