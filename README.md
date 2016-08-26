# JXCellSeparator
### 嗯。。。封装了一下cell的系统分割线调用方法，简单易用。
![JXCellSeparator](https://github.com/JiongXing/JXCellSeparator/raw/master/screenshots/JXSeparator.gif)

- 使用示例
```objc
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
```

- UITableViewCell+JXSeparator.h
```objc
typedef NS_ENUM(NSUInteger, JXSeparatorStyle) {
    JXSeparatorStyleNone = 0,   // 无
    JXSeparatorStyleFull,       // 满行
    JXSeparatorStyleCenter,     // 两边留出间距
    JXSeparatorStyleLeftMargin, // 左边留出间距
    JXSeparatorStyleRightMargin,// 右边留出间距
};

@interface UITableViewCell (JXSeparator)

/// 分割线风格
@property (nonatomic, assign) JXSeparatorStyle jx_separatorStyle;

/// 两边等间距
@property (nonatomic, assign) CGFloat jx_separatorCenterMargin;

/// 左边间距
@property (nonatomic, assign) CGFloat jx_separatorLeftMargin;

/// 右边间距
@property (nonatomic, assign) CGFloat jx_separatorRightMargin;

@end
```

- UITableViewCell+JXSeparator.m
```objc
#import <objc/runtime.h>

static const char kJXSeparatorMarginKey = '\0';
static const char kJXSeparatorLeftMarginKey = '\0';
static const char kJXSeparatorRightMarginKey = '\0';
static const char kJXSeparatorStyleKey = '\0';

@implementation UITableViewCell (JXSeparator)

#pragma 左间距
- (CGFloat)jx_separatorLeftMargin {
    NSNumber *leftMargin = objc_getAssociatedObject(self, &kJXSeparatorLeftMarginKey);
    return leftMargin ? [leftMargin floatValue] : 0;
}

- (void)setJx_separatorLeftMargin:(CGFloat)jx_separatorLeftMargin {
    objc_setAssociatedObject(self, &kJXSeparatorLeftMarginKey, @(jx_separatorLeftMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma 右间距
- (CGFloat)jx_separatorRightMargin {
    NSNumber *rightMargin = objc_getAssociatedObject(self, &kJXSeparatorRightMarginKey);
    return rightMargin ? [rightMargin floatValue] : 0;
}

- (void)setJx_separatorRightMargin:(CGFloat)jx_separatorRightMargin {
    objc_setAssociatedObject(self, &kJXSeparatorRightMarginKey, @(jx_separatorRightMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma 两边间距
- (CGFloat)jx_separatorCenterMargin {
    NSNumber *margin = objc_getAssociatedObject(self, &kJXSeparatorMarginKey);
    return margin ? [margin floatValue] : 0;
}

- (void)setJx_separatorCenterMargin:(CGFloat)jx_separatorCenterMargin {
    objc_setAssociatedObject(self, &kJXSeparatorMarginKey, @(jx_separatorCenterMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 风格
- (JXSeparatorStyle)jx_separatorStyle {
    NSNumber *style = objc_getAssociatedObject(self, &kJXSeparatorStyleKey);
    return style ? [style integerValue] : 0;
}

- (void)setJx_separatorStyle:(JXSeparatorStyle)jx_separatorStyle {
    objc_setAssociatedObject(self, &kJXSeparatorStyleKey, @(jx_separatorStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if ([[UIDevice currentDevice].systemVersion compare:@"8.0"] != NSOrderedAscending) {
        self.layoutMargins = UIEdgeInsetsZero;
        self.preservesSuperviewLayoutMargins = NO;
    }
    
    switch (jx_separatorStyle) {
        case JXSeparatorStyleNone:
            self.separatorInset = UIEdgeInsetsMake(0, 0, 0, self.bounds.size.width);
            break;
        case JXSeparatorStyleFull:
            self.separatorInset = UIEdgeInsetsZero;
            break;
        case JXSeparatorStyleLeftMargin:
            self.separatorInset = UIEdgeInsetsMake(0, self.jx_separatorLeftMargin, 0, 0);
            break;
        case JXSeparatorStyleRightMargin:
            self.separatorInset = UIEdgeInsetsMake(0, 0, 0, self.jx_separatorRightMargin);
            break;
        case JXSeparatorStyleCenter:
            self.separatorInset = UIEdgeInsetsMake(0, self.jx_separatorCenterMargin, 0, self.jx_separatorCenterMargin);
            break;
        default:
            break;
    }
}

@end
```
