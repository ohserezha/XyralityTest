//
//  LoginViewController.m
//  XyralityTest
//
//  Created by ezkeemo on 10/20/15.
//  Copyright © 2015 ezkeemo. All rights reserved.
//

#import "LoginViewController.h"
#import "APIManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)processButtonTapped:(id)sender {
    [[APIManager sharedManager] getWorldsListWithCredentialsLogin:self.loginTextField.text password:self.passwordTextField.text onSuccess:^(id responseObject) {
        NSLog(@"response %@", responseObject);
    } onFailure:^(NSError *error) {
        NSLog(@"error");
    }];
}
@end
