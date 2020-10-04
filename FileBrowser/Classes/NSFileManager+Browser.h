//
//  NSFileManager+Browser.h
//  FileBrowser
//
//  Created by 昭荣伊 on 2020/10/4.
//

#import <Foundation/Foundation.h>

#define FB_ONE_KB 1024.0
#define FB_ONE_MB (FB_ONE_KB * FB_ONE_KB)
#define FB_ONE_GB (FB_ONE_MB * FB_ONE_KB)

@interface NSFileManager (Browser)


/// 根路径
@property (nonatomic, class, readonly) NSString *fb_rootPath;

/**
 应用目录
 */
@property (nonatomic, readonly) NSString *fb_appPath;

/**
 文档目录
 */
@property (nonatomic, readonly) NSString *fb_docPath;

/**
 信号设置目录
 */
@property (nonatomic, readonly) NSString *fb_libPrefPath;

/**
 缓存目录
 */
@property (nonatomic, readonly) NSString *fb_libCachePath;

/**
 缓存目录
 */
@property (nonatomic, readonly) NSString *fb_tmpPath;

/**
 创建文件

 @param path 文件路径
 @return 是否成功
 */
+ (BOOL)fb_touch:(NSString *)path;

/**
 创建文件

 @param fileName 文件名
 @return 是否成功
 */
+ (BOOL)fb_touchFile:(NSString *)fileName;

/// 获取目录大小
/// @param path 目录
+ (long long)fb_directorySizeAtPath:(NSString *)path;

/// 文件大小
/// @param path 路径
+ (long long)fb_fileSizeAtPath:(NSString *)path;

/// 文件列表
/// @param path 路径
+ (NSArray *)fb_fileListAtPath:(NSString *)path;

/// 文件是否存在
/// @param path 路径
+ (BOOL)fb_fileExistsAtPath:(NSString *)path;

@end

