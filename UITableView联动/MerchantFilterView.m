//
//  MerchantFilterView.m
//  UITableView联动
//
//  Created by panyf on 2017/8/15.
//  Copyright © 2017年 panyuanfeng. All rights reserved.
//

#import "MerchantFilterView.h"

@interface MerchantFilterView() <UITableViewDelegate,UITableViewDataSource>

// 左边tableView数据源
@property (nonatomic, strong) NSArray *leftArray;

// 右边tableview数据源
@property (nonatomic, strong) NSArray *rightArray;

@end

@implementation MerchantFilterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.leftArray = [NSArray arrayWithObjects:@"左一", @"左二", @"左三", @"左四", @"左五", @"左六", @"左七", @"左八", nil];

        self.rightArray = [NSArray arrayWithObjects:@"右一", @"右二", @"右三", @"右四", @"右五", @"右六", @"右七", @"右八", @"右九", @"右十", nil];

        [self createViews];

    }

    return self;
}

- (void)createViews{

    // 左边tableview
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2 - 30, self.frame.size.height) style:UITableViewStylePlain];

    self.leftTableView.delegate = self;

    self.leftTableView.dataSource = self;

    // 隐藏滑动滚动条
    self.leftTableView.showsVerticalScrollIndicator = NO;

    self.leftTableView.tableFooterView = [[UIView alloc] init];

    // 默认选中第一行
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];

    [self addSubview:self.leftTableView];

    // 右边tableView
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 30, 0, self.frame.size.width/2 + 30, self.frame.size.height) style:UITableViewStylePlain];

    self.rightTableView.delegate = self;

    self.rightTableView.dataSource = self;

    self.rightTableView.showsVerticalScrollIndicator = NO;

    self.rightTableView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];

    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.rightTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];

    [self addSubview:self.rightTableView];

    self.userInteractionEnabled = YES;

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.leftTableView == tableView) {
        return self.leftArray.count;
    }else{
        return self.rightArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.leftTableView == tableView) {
        static NSString *cellIdentifier = @"leftCell";

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }

        cell.textLabel.text = self.leftArray[indexPath.row];

        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];

        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];

        return cell;
    }else{
        static NSString *identifier = @"rightCell";

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];

            //下划线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 41.5, cell.frame.size.width, 0.5)];

            lineView.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0];

            [cell.contentView addSubview:lineView];
        }

        cell.textLabel.text = self.rightArray[indexPath.row];

        cell.textLabel.highlightedTextColor = [UIColor redColor];

        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];

        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];

        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];

        return cell;

    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.leftTableView == tableView) {
        [self.delegate tableView:self.leftTableView withCatalogtitle:self.leftArray[indexPath.row]];
        
        [self.rightTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
    }else{
        [self.delegate tableView:self.rightTableView withAnalysisByCatalogId:self.rightArray[indexPath.row] withAnalysisByCatalogName:self.rightArray[indexPath.row]];
    }
}

@end
