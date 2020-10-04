//
//  FBFileBrowerViewController.m
//  FileBrowser
//
//  Created by 昭荣伊 on 2020/10/4.
//

#import "FBFileBrowerViewController.h"
#import "FBFileCell.h"
#import "FBFile.h"
#import "NSFileManager+Browser.h"
#import <Masonry/Masonry.h>

static NSString *kRootPath;

@interface FBFileBrowerViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UILabel *summaryLabel;

@property (nonatomic, copy) NSString *path;

@property (nonatomic, copy) NSArray *paths;

@end

@implementation FBFileBrowerViewController

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kRootPath = [NSFileManager fb_rootPath];
    });
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupWithPath:nil];
    }
    return self;
}

- (instancetype)initWithPath:(NSString *)path {
    if (self = [super init]) {
        [self setupWithPath:path];
    }
    return self;
}

- (void)setupWithPath:(NSString *)path {
    if ([NSFileManager fb_fileExistsAtPath:path]) {
        _path = path;
        self.title = [path lastPathComponent];
    } else {
        _path = kRootPath;
        self.title = @"home";
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *fileList = [NSFileManager fb_fileListAtPath:self.path];
        NSMutableArray *paths = [NSMutableArray array];
        for (NSString *path in fileList) {
            [paths addObject:[[FBFile alloc] initWithPath:path]];
        }
        self.paths = [paths copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.summaryLabel.text = [NSString stringWithFormat:@"共%ld项", self.paths.count];
            [self.collectionView reloadData];
        });
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.summaryLabel];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-44);
    }];
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
}

- (void)showOperationsWithFile:(FBFile *)file {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:file.name message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if ([[NSFileManager defaultManager] removeItemAtPath:file.path error:nil]) {
            [self setupWithPath:self.path];
        }
    }];
    UIAlertAction *openAction = [UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIDocumentInteractionController *documentVC = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:file.path]];
        [documentVC presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    }];
    [alertController addAction:deleteAction];
    [alertController addAction:openAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.paths.count;
}

#pragma mark - UICollectionViewDelegate
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FBFileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FBFileCell" forIndexPath:indexPath];
    [cell setFile:self.paths[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FBFile *file = self.paths[indexPath.row];
    if (file.type == FBFileTypeDirectory) {
        FBFileBrowerViewController *vc = [[FBFileBrowerViewController alloc] initWithPath:file.path];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self showOperationsWithFile:file];
    }
    
}

#pragma mark - Setters And Getters
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = CGRectGetWidth(UIScreen.mainScreen.bounds);
        CGFloat height = CGRectGetHeight(UIScreen.mainScreen.bounds);
        CGFloat designWidth = MIN(width, height);
        CGFloat spacing = 10;
        CGFloat itemWidth = (designWidth - 5 * spacing) / 3;
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake(itemWidth, 116);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.contentInset = UIEdgeInsetsMake(16, 14, 16,14);
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:FBFileCell.class forCellWithReuseIdentifier:@"FBFileCell"];
    }
    return _collectionView;
}

- (UILabel *)summaryLabel {
    if (!_summaryLabel) {
        _summaryLabel = [UILabel new];
        _summaryLabel.font = [UIFont boldSystemFontOfSize:12];
        _summaryLabel.textColor = [UIColor blackColor];
        _summaryLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _summaryLabel;
}

@end
