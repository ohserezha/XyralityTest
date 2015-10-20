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
    #warning do not forget to remove
    self.loginTextField.text = @"ios.test@xyrality.com";
    self.passwordTextField.text = @"password";

    if (![self areLoginPassFieldsValid]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ouch!" message:@"One of textfields is empty. Please fill it with correct value" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [alertController dismissViewControllerAnimated:YES completion:nil];
                                                              }];
        [alertController addAction:defaultAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    [self showNetworkActivityView];
    [[APIManager sharedManager] getWorldsListWithCredentialsLogin:self.loginTextField.text password:self.passwordTextField.text onSuccess:^(id responseObject) {
        [self hideNetworkActivityView];
        NSLog(@"success");
        if (responseObject && responseObject[@"allAvailableWorlds"]) {
            NSArray *worldsList = (NSArray *)responseObject[@"allAvailableWorlds"];
            // provide data for table view
            // perform segue
        }
    } onFailure:^(NSError *error) {
        [self hideNetworkActivityView];
        NSLog(@"failure");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"An error occured while talking to server" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [alertController dismissViewControllerAnimated:YES completion:nil];
                                                              }];
        [alertController addAction:defaultAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}

#pragma mark - Helpers

- (BOOL)areLoginPassFieldsValid {
    if ([self.loginTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (void)showNetworkActivityView {
//    self.networkActivityView.hidden = NO;
//    [self.networkActivityView setUserInteractionEnabled:NO];
//    [self.networkActivityIndicator startAnimating];
}

- (void)hideNetworkActivityView {
//    [self.networkActivityIndicator stopAnimating];
//    self.networkActivityView.hidden = YES;
}
@end
