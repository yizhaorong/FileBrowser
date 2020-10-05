//
//  NSFileManager+Browser.m
//  FileBrowser
//
//  Created by 昭荣伊 on 2020/10/4.
//

#import "NSFileManager+Browser.h"

@implementation NSFileManager (Browser)

+ (NSString *)fb_rootPath {
    static NSString *_rootPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError * error = nil;
        NSArray *paths = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:NSHomeDirectory() error:&error];
        _rootPath = NSHomeDirectory();
    });
    
    return _rootPath;
}

+ (NSString *)fb_appPath {
    static NSString *_appPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError * error = nil;
        NSArray *paths = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:NSHomeDirectory() error:&error];
        
        for ( NSString *path in paths) {
            if ([path hasSuffix:@".app"]) {
                _appPath = [NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), path];
                break;
            }
        }
    });
    
    return _appPath;
}

+ (NSString *)fb_docPath {
    static NSString *_docPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _docPath = [paths objectAtIndex:0];
    });
    return _docPath;
}

+ (NSString *)fb_libPrefPath {
    static NSString *_libPrefPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preferences"];
        [NSFileManager fb_touch:path];
        _libPrefPath = path;
    });
    return _libPrefPath;
}

+ (NSString *)fb_libCachePath {
    static NSString *_libCachePath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
        [NSFileManager fb_touch:path];
        _libCachePath = path;
    });
    return _libCachePath;
}

+ (NSString *)fb_tmpPath {
    static NSString *_tmpPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/tmp"];
        [NSFileManager fb_touch:path];
        _tmpPath = path;
    });
    return _tmpPath;
}

+ (BOOL)fb_touch:(NSString *)path {
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] )
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    
    return YES;
}

+ (BOOL)fb_touchFile:(NSString *)fileName {
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:fileName] ) {
        return [[NSFileManager defaultManager] createFileAtPath:fileName
                                                       contents:[NSData data]
                                                     attributes:nil];
    }
    return YES;
}


+ (long long)fb_directorySizeAtPath:(NSString *)path {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        return 0;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:path] objectEnumerator];
    NSString *fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
        float singleFileSize = 0.0;
        if ([manager fileExistsAtPath:fileAbsolutePath]) {
            singleFileSize = [[manager attributesOfItemAtPath:fileAbsolutePath error:nil] fileSize];
        }
        folderSize += singleFileSize;
    }
    return folderSize;
}

+ (long long)fb_fileSizeAtPath:(NSString *)path {
    NSFileManager *manager = [NSFileManager defaultManager];
    float singleFileSize = 0.0;
    if ([manager fileExistsAtPath:path]) {
        singleFileSize = [[manager attributesOfItemAtPath:path error:nil] fileSize];
    }
    return singleFileSize;
}

+ (NSArray *)fb_fileListAtPath:(NSString *)path {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        return @[];
    }
    
    NSMutableArray *fileList = [NSMutableArray array];
    NSArray *fileNames = [manager contentsOfDirectoryAtPath:path error:nil];
    for (NSString *fileName in fileNames) {
        NSString *fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
        [fileList addObject:fileAbsolutePath];
    }
    return fileList;
}

+ (BOOL)fb_fileExistsAtPath:(NSString *)path {
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager fileExistsAtPath:path];
}

@end
