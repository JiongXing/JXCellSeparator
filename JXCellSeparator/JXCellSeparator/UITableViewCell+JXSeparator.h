//
//  UITableViewCell+JXSeparator.h
//  JXCellSeparator
//
//  Created by JiongXing on 16/8/26.
//  Copyright © 2016年 JiongXing. All rights reserved.
//

#import <UIKit/UIKit.h>

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
