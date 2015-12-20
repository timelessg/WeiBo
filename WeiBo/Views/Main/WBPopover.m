//
//  WBPopMenu.m
//  WeiBo
//
//  Created by 郭锐 on 15/12/7.
//  Copyright © 2015年 Garry. All rights reserved.
//

#import "WBPopover.h"

#pragma - mark WBPopItem

@implementation WBPopItem
+(instancetype)item:(NSString *)item selected:(BOOL)selected like:(BOOL)like{
    WBPopItem *popItem = [WBPopItem new];
    popItem.item = item;
    popItem.selected = selected;
    popItem.like = like;
    return popItem;
}
+(instancetype)item:(NSString *)item image:(NSString *)image{
    WBPopItem *popItem = [WBPopItem new];
    popItem.item = item;
    popItem.icoImage = image;
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

#pragma - mark WBPopoverSectionView;

@interface WBPopoverSectionView ()
@property(nonatomic,strong)UILabel *sectionLabel;
@property(nonatomic,strong)UIView *leftLine;
@property(nonatomic,strong)UIView *rightLine;
@end

@implementation WBPopoverSectionView
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
        _leftLine.backgroundColor = [UIColor colorWithHex:0X535353];
    }
    return _leftLine;
}
-(UIView *)rightLine{
    if (!_rightLine) {
        _rightLine = [UIView new];
        _rightLine.backgroundColor = [UIColor colorWithHex:0X535353];
    }
    return _rightLine;
}
@end

#pragma - mark WBPopoverCell

@interface WBPopoverCell ()
@property(nonatomic,strong)UIButton *itemBtn;
@property(nonatomic,strong)UIButton *likeIco;
@end

@implementation WBPopoverCell
{
    WBPopMenuType _type;
}
-(instancetype)initWithType:(WBPopMenuType)type{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        _type = type;
        [self setupView];
    }
    return self;
}
-(void)setupView{
    [self addSubview:self.itemBtn];
    [self.itemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
-(void)setItem:(WBPopItem *)item{
    if (_item != item) {
        _item = item;
        [self.itemBtn setTitle:item.item forState:UIControlStateNormal];
        [self.itemBtn setImage:[UIImage imageNamed:self.item.icoImage] forState:UIControlStateNormal];
        self.itemBtn.selected = item.selected;
        self.likeIco.hidden = !item.like;
    }
}
-(UIButton *)itemBtn{
    if (!_itemBtn) {
        _itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *highlightedImage = [[UIImage imageNamed:@"popover_background_highlighted"]stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        [_itemBtn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
        _itemBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [_itemBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _itemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        if (_type == WBPopMenuTypeCenter) {
            UIImage *selectedImage = [[UIImage imageNamed:@"popover_background_selected"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
            [_itemBtn setBackgroundImage:selectedImage forState:UIControlStateSelected];
            [_itemBtn setTitleColor:[UIColor colorWithHex:0Xffa015] forState:UIControlStateSelected];
            _itemBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            [_itemBtn addSubview:self.likeIco];
            [self.likeIco mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_itemBtn.titleLabel.mas_right).offset(12);
                make.centerY.equalTo(_itemBtn.mas_centerY).offset(0);
            }];
            [_itemBtn bk_addEventHandler:^(UIButton *sender) {
                self.didSelectItem(self.item.item);
                [self.superview.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[WBPopoverCell class]]) {
                        WBPopoverCell *cell = obj;
                        cell.itemBtn.selected = NO;
                        cell.item.selected = NO;
                        cell.likeIco.selected = YES;
                    }
                }];
                self.item.selected = YES;
                sender.selected = !sender.selected;
                self.likeIco.selected = !self.item.like;
            } forControlEvents:UIControlEventTouchUpInside];
        }
        
        if (_type == WBPopMenuTypeRight) {
            CALayer *lineLayer = [CALayer layer];
            lineLayer.frame = CGRectMake(2, _itemBtn.height - 1, self.width - 4, 1);
            lineLayer.backgroundColor = [UIColor colorWithHex:0X565656].CGColor;
            [_itemBtn.layer addSublayer:lineLayer];
            
            _itemBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
            _itemBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
            [_itemBtn bk_addEventHandler:^(UIButton *sender) {
                self.didSelectItem(self.item.item);
            } forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _itemBtn;
}
-(UIButton *)likeIco{
    if (!_likeIco) {
        _likeIco = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeIco setBackgroundImage:[UIImage imageNamed:@"friendcircle_popover_cell_friendcircle_highlighted"] forState:UIControlStateNormal];
        [_likeIco setBackgroundImage:[UIImage imageNamed:@"friendcircle_popover_cell_friendcircle"] forState:UIControlStateSelected];
    }
    return _likeIco;
}
@end

#pragma - mark WBPopover

@interface WBPopover () <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)WBPopMenuType type;
@property(nonatomic,strong)NSArray *items;
@property(nonatomic,strong)IndexSelect block;
@property(nonatomic,strong)WBPopMenuBg *bgView;
@property(nonatomic,strong)UIImageView *menuView;
@property(nonatomic,strong)UITableView *menuTableView;
@property(nonatomic,strong)UIButton *footerView;
@end

@implementation WBPopover
{
    CGFloat _height;
    WBPopMenuType _type;
}
-(instancetype)initWithItems:(NSArray *)items height:(CGFloat)height type:(WBPopMenuType)type selectIndex:(IndexSelect)selectIndex{
    if (self = [super init]) {
        self.type = type;
        self.items = items;
        self.block = selectIndex;
        _height = height;
        _type = type;
        [self setupView];
    }
    return self;
}
-(void)setupView{
    [[self window] addSubview:self.bgView];
    [self.bgView addSubview:self.menuView];
    
    if (_type == WBPopMenuTypeCenter) {
        [self.bgView addSubview:self.footerView];
        [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(26);
            make.top.equalTo(self.menuTableView.mas_bottom).offset(2);
            make.left.equalTo(self.menuTableView.mas_left).offset(0);
            make.right.equalTo(self.menuTableView.mas_right).offset(0);
        }];
    }
    
    if (_type == WBPopMenuTypeRight) {
        
    }
}
-(UITableView *)menuTableView{
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        if (_type == WBPopMenuTypeCenter) {
            _menuTableView.frame = CGRectMake(10, 22, self.menuView.width - 20, self.menuView.height - 32 - 28);
            _menuTableView.rowHeight = 34;
        }
        if (_type == WBPopMenuTypeRight) {
            _menuTableView.frame = CGRectMake(8, 12, self.menuView.width - 16, self.menuView.height - 20);
            _menuTableView.rowHeight = 40;
            _menuTableView.scrollEnabled = NO;
        }
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.backgroundColor = [UIColor clearColor];
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _menuTableView;
}
-(UIImageView *)menuView{
    if (!_menuView) {
        _menuView = [[UIImageView alloc] init];
        _menuView.alpha = 0.9;
        if (_type == WBPopMenuTypeCenter) {
            _menuView.frame  = CGRectMake((kSCREENWIDTH - 193) / 2, 44 + 10, 193, _height);
            UIImage *popCover = [[UIImage imageNamed:@"popover_background"] stretchableImageWithLeftCapWidth:6 topCapHeight:12];
            _menuView.image = popCover;
        }
        
        if (_type == WBPopMenuTypeRight) {
            _menuView.frame  = CGRectMake(kSCREENWIDTH - 150 - 6, 44 + 10, 150, _height);
            UIImage *popCover = [[UIImage imageNamed:@"popover_background_right"] stretchableImageWithLeftCapWidth:6 topCapHeight:12];
            _menuView.image = popCover;
        }
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
    WS(weakSelf);
    static NSString *CellIdentifier = @"cell";
    WBPopoverCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[WBPopoverCell alloc] initWithType:_type];
    }
    cell.item = self.items[indexPath.section][@"items"][indexPath.row];
    cell.didSelectItem = ^(NSString *item){
        weakSelf.block(item);
        [weakSelf hide];
    };
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *sectionStr = self.items[section][@"section"];
    WBPopoverSectionView *sectionView = ([sectionStr isEqualToString:@""]) ? nil : [[WBPopoverSectionView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 36)];
    sectionView.sectionStr = sectionStr;
    return sectionView;
}
-(UIButton *)footerView{
    if (!_footerView) {
        UIImage *highlightedImage = [[UIImage imageNamed:@"popover_button_highlighted"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        UIImage *normalImage = [[UIImage imageNamed:@"popover_button"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        _footerView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_footerView setTitle:@"编辑我的分组" forState:UIControlStateNormal];
        _footerView.titleLabel.font = [UIFont systemFontOfSize:13];
        [_footerView setBackgroundImage:normalImage forState:UIControlStateNormal];
        [_footerView setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
        [_footerView bk_addEventHandler:^(id sender) {
            if (self.didClickEdit) self.didClickEdit();
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
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
