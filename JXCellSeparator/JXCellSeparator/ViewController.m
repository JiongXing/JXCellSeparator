//
//  ViewController.m
//  JXCellSeparator
//
//  Created by JiongXing on 16/8/26.
//  Copyright © 2016年 JiongXing. All rights reserved.
//

#import "ViewController.h"
#import "UITableViewCell+JXSeparator.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"JXSeparator";
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        // 配置各种风格下的间距
        cell.jx_separatorCenterMargin = 15;
        cell.jx_separatorLeftMargin = 50;
        cell.jx_separatorRightMargin = 30;
    }
    
    NSString *styleString = nil;
    if (indexPath.row % 5 == 0) {
        cell.jx_separatorStyle = JXSeparatorStyleCenter;
        styleString = @"Center";
    }
    else if (indexPath.row % 5 == 1) {
        cell.jx_separatorStyle = JXSeparatorStyleFull;
        styleString = @"Full";
    }
    else if (indexPath.row % 5 == 2) {
        cell.jx_separatorStyle = JXSeparatorStyleLeftMargin;
        styleString = @"LeftMargin";
    }
    else if (indexPath.row % 5 == 3) {
        cell.jx_separatorStyle = JXSeparatorStyleRightMargin;
        styleString = @"RightMargin";
    }
    else {
        cell.jx_separatorStyle = JXSeparatorStyleNone;
        styleString = @"None";
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ Row:%@", styleString, @(indexPath.row + 1)];
    return cell;
}

@end
