//
//  FBFileBrowerViewController.h
//  FileBrowser
//
//  Created by 昭荣伊 on 2020/10/4.
//

#import <UIKit/UIKit.h>

@interface FBFileBrowerViewController : UIViewController

/// 文件路径， nil表示根路径
/// @param path 路径
- (instancetype)initWithPath:(NSString *)path;

@end

