//
//  ViewController.m
//  GSStatusBarExampleApp
//
//  Created by Gard Sandholt on 14/02/14.
//  Copyright (c) 2014 GaSa Media. All rights reserved.
//

#import "ViewController.h"
#import "GSStatusBar.h"

@interface ViewController ()

@end

@implementation ViewController


- (IBAction)showButtonPressed:(id)sender {
    
    UIButton *showBtn = (UIButton *)sender;
    
    if ([GSStatusBar isVisible]) {
        [GSStatusBar hide];
        [showBtn setTitle:@"Show" forState:UIControlStateNormal];
        return;
    }

    [GSStatusBar show];
    [showBtn setTitle:@"Hide" forState:UIControlStateNormal];
}


@end
