//
//  MerchantFilterView.h
//  UITableView联动
//
//  Created by panyf on 2017/8/15.
//  Copyright © 2017年 panyuanfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MerchantFilterViewDelegate <NSObject>

/***  点击tableview，获取标题 */
- (void)tableView:(UITableView *)tableView withCatalogtitle:(NSString *)title;

/***  点击tableview，获取id */
- (void)tableView:(UITableView *)tableView withAnalysisByCatalogId:(NSString *)ID withAnalysisByCatalogName:(NSString *)name;

@end

@interface MerchantFilterView : UIView

@property (nonatomic, strong) UITableView *leftTableView;

@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, assign) id <MerchantFilterViewDelegate> delegate;

@property (nonatomic, strong) NSString *catalogTitle;

@property (nonatomic, strong) NSString *analysisTitle;

@end
