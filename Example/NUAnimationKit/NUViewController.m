//
//  NUViewController.m
//  NUAnimationKit
//
//  Created by Victor on 01/22/2016.
//  Copyright (c) 2016 Victor. All rights reserved.
//

#import "NUViewController.h"
#import "NUAnimationController.h"

@interface NUViewController ()
@property (nonatomic, strong) UILabel *completionLabel;
@end

@implementation NUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *animationView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    animationView1.backgroundColor = [UIColor redColor];
    
    UIView *animationView2= [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    animationView2.backgroundColor = [UIColor greenColor];
    
    UIView *animationView3 = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    animationView3.backgroundColor = [UIColor blueColor];
    
    self.completionLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 300, 300, 20)];
    self.completionLabel.text = @"Not started";
    
    UILabel *progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 300, 20)];
    progressLabel.text = [NSString stringWithFormat:@"%f", 0.0f];
    
    [self.view addSubview:animationView1];
    [self.view addSubview:animationView2];
    [self.view addSubview:animationView3];
    [self.view addSubview:self.completionLabel];
    [self.view addSubview:progressLabel];
    
    self.controller = [[NUAnimationController alloc] init];
    
    [self.controller addAnimation:^{
        frameSetY(animationView1.frame, 400);
        animationView1.backgroundColor = [UIColor grayColor];
    }].withAnimationOption(UIViewAnimationOptionTransitionCrossDissolve)
    .andThen(^{
        self.completionLabel.text = @"Working on it";
    });
    
    [self.controller addAnimation:^{
        frameSetY(animationView2.frame, 400);
    }].withDelay(0.1).withDuration(0.3).withCurve(UIViewAnimationCurveEaseInOut);
    
    [self.controller addAnimation:^{
        frameSetY(animationView3.frame, 400);
    }].withType(NUAnimationTypeSpringy).withDuration(NUSpringAnimationNaturalDuration).
    alongSideBlock(^(CGFloat progress){
        progressLabel.text = [NSString stringWithFormat:@"%f", progress];
    });
    
}

- (void)startAnimation {
    [self.controller startAnimationChainWithCompletionBlock:^{
        self.completionLabel.text = @"All done";
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
