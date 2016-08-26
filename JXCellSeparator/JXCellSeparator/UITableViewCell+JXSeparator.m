//
//  UITableViewCell+JXSeparator.m
//  JXCellSeparator
//
//  Created by JiongXing on 16/8/26.
//  Copyright © 2016年 JiongXing. All rights reserved.
//

#import "UITableViewCell+JXSeparator.h"
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
