//
//  FBFile.m
//  FileBrowser
//
//  Created by 昭荣伊 on 2020/10/4.
//

#import "FBFile.h"
#import "UIImage+Browser.h"
#import "NSFileManager+Browser.h"


@implementation FBFile

- (instancetype)initWithPath:(NSString *)path {
    if (self = [super init]) {
        _path = path;
        _name = path.lastPathComponent;
        BOOL isDir;
        [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
        if (isDir) {
            _type = FBFileTypeDirectory;
            _icon = [UIImage fb_imageNamed:@"forder"];
            _detail = [NSString stringWithFormat:@"共%ld项", [NSFileManager fb_fileListAtPath:path].count];
        } else {
            NSString *fileType = [[_name componentsSeparatedByString:@"."].lastObject lowercaseString];
            long long size = [NSFileManager fb_fileSizeAtPath:path];
            if (size >= FB_ONE_GB) {
                _detail = [NSString stringWithFormat:@"%.1fGB", size / FB_ONE_GB];
            } else if (size >= FB_ONE_MB) {
                _detail = [NSString stringWithFormat:@"%.1fMB", size / FB_ONE_MB];
            } else if (size >= FB_ONE_KB) {
                _detail = [NSString stringWithFormat:@"%.1fKB", size / FB_ONE_KB];
            } else {
                _detail = [NSString stringWithFormat:@"%lld字节", size];
            }
            
            if (fileType.length > 2) {
                static NSArray *images;
                static NSArray *videos;
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    images = @[@"jpg", @"jpeg", @"png", @"gif"];
                    videos = @[@"mp4", @"avi"];
                });
                if ([images containsObject:fileType]) {
                    fileType = @"image";
                    _icon = [UIImage imageWithContentsOfFile:path];
                } else if ([videos containsObject:fileType]) {
                    fileType = @"video";
                } else {
                    fileType = [fileType substringToIndex:3];
                }
            }
            
            if ([fileType isEqualToString:@"md"]) {
                _type = FBFileTypeMarkdown;
            }
            if (!_icon) {
                _icon = [UIImage fb_imageNamed:fileType];
                if (!_icon) {
                    _icon = [UIImage fb_imageNamed:@"unknown"];
                }
            }
        }
    }
    return self;
}

@end
