//
//  FBFile.h
//  FileBrowser
//
//  Created by 昭荣伊 on 2020/10/4.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FBFileType) {
    FBFileTypeUnkown = 0,       // 未知类型
    FBFileTypeDirectory,        // 目录
    FBFileTypePPT,              // PPT
    FBFileTypeDoc,              // DOC
    FBFileTypeExcel,            // Excel
    FBFileTypeMarkdown,         // Markdown
};

@interface FBFile : NSObject

@property (nonatomic, assign, readonly) FBFileType type;

@property (nonatomic, copy, readonly) NSString *path;

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, strong, readonly) UIImage *icon;

@property (nonatomic, strong, readonly) NSString *detail;

- (instancetype)initWithPath:(NSString *)path;

@end
