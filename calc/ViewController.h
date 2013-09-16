//
//  ViewController.h
//  calc
//
//  Created by Mac on 13/9/16.
//  Copyright (c) 2013年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (retain, nonatomic) IBOutlet UILabel *displayLbl;

- (IBAction)click_num:(UIButton *)sender;
- (IBAction)click_clear:(UIButton *)sender;
- (IBAction)click_op:(UIButton *)sender;
- (IBAction)click_calc:(UIButton *)sender;


@end
