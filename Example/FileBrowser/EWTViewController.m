//
//  EWTViewController.m
//  FileBrowser
//
//  Created by yizhaorong on 10/04/2020.
//  Copyright (c) 2020 yizhaorong. All rights reserved.
//

#import "EWTViewController.h"
#import <FileBrowser/FBFileBrowerViewController.h>

@interface EWTViewController ()

@end

@implementation EWTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    FBFileBrowerViewController *vc = [FBFileBrowerViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
