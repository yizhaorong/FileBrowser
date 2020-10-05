//
//  FBFileBrowerViewController.h
//  FileBrowser
//
//  Created by 昭荣伊 on 2020/10/4.
//

#import <UIKit/UIKit.h>
#import "FBFile.h"

@class FBFileBrowerViewController;

@protocol FBFileBrowerViewControllerDelegate <NSObject>

@optional
- (void)fileBrowser:(FBFileBrowerViewController *)fileBrowser didSelectedFile:(FBFile *)file;

@end

@interface FBFileBrowerViewController : UIViewController

/// 文件路径， nil表示根路径
/// @param path 路径
- (instancetype)initWithPath:(NSString *)path;

/// 代理
@property (nonatomic, weak) id<FBFileBrowerViewControllerDelegate> delegate;

@end

