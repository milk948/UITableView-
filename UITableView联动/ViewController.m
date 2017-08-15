//
//  ViewController.m
//  UITableView联动
//
//  Created by panyf on 2017/8/15.
//  Copyright © 2017年 panyuanfeng. All rights reserved.
//

#import "ViewController.h"
#import "MerchantFilterView.h"

#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UIGestureRecognizerDelegate,MerchantFilterViewDelegate>

@property (strong, nonatomic) UIView *maskView;

@property (nonatomic, strong) MerchantFilterView *filterView;

@property (nonatomic, assign) BOOL isHidden;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    _isHidden = NO;

    [self initMaskView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initMaskView{

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, kDeviceWidth, 40)];

    btn.backgroundColor = [UIColor redColor];

    [btn setTitle:@"点击" forState:UIControlStateNormal];

    [btn addTarget:self action:@selector(btnClicken:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btn];

    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 140, kDeviceWidth, kDeviceHeight - 140)];

    _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];

    _maskView.hidden = YES;

    [self.view addSubview:_maskView];

    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapMaskView:)];

    tap.delegate = self;

    [_maskView addGestureRecognizer:tap];

    _filterView = [[MerchantFilterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, _maskView.frame.size.height - 150)];

    _filterView.delegate = self;

    [_maskView addSubview:_filterView];
}

- (void)btnClicken:(UIButton *)sender{

    _isHidden = !_isHidden;

    if (_isHidden) {
        _maskView.hidden = NO;
    }else{
        _maskView.hidden = YES;
    }
}

-(void)OnTapMaskView:(UITapGestureRecognizer *)sender{
    _maskView.hidden = YES;

    _isHidden = NO;
}

#pragma mark-手势代理，解决和tableview点击发生的冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{

    //判断如果点击的是tableView的cell，就把手势给关闭了
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        //关闭手势
        return NO;
    }else{
        //否则手势存在
        return YES;
    }
}

#pragma mark -- MerchantFilterDelegate
- (void)tableView:(UITableView *)tableView withCatalogtitle:(NSString *)title{

    NSLog(@"%@",title);

}

- (void)tableView:(UITableView *)tableView withAnalysisByCatalogId:(NSString *)ID withAnalysisByCatalogName:(NSString *)name {

    _maskView.hidden = YES;

    _isHidden = NO;

    NSLog(@"%@",name);

}


@end
