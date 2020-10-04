//
//  UIImage+Browser.m
//  FileBrowser
//
//  Created by 昭荣伊 on 2020/10/4.
//

#import "UIImage+Browser.h"
#import "FBFile.h"

@implementation UIImage (Browser)

+ (instancetype)fb_imageNamed:(NSString *)named {
    static NSBundle *kFileBrowserBundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *bundle = [NSBundle bundleForClass:FBFile.class];
        NSString *path = [bundle pathForResource:@"FileBrowser" ofType:@"bundle"];
        kFileBrowserBundle = [NSBundle bundleWithPath:path];
    });
    return [UIImage imageNamed:named inBundle:kFileBrowserBundle compatibleWithTraitCollection:nil];
}

@end
