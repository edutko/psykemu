//
//  YubiKeySampleAppDelegate.h
//  
//    Copyright 2013 Eric Dutko
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import <UIKit/UIKit.h>

#import "KeychainItemWrapper.h"
#import "ManageKeyViewController.h"
#import "TestHmacViewController.h"

@interface YubiKeySampleAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {

    UIWindow *window;
    UITabBarController *tabBarController;
	
	TestHmacViewController *testHmacViewController;
    ManageKeyViewController *manageKeyViewController;

	KeychainItemWrapper *yubiKeyItem;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (retain) IBOutlet TestHmacViewController *testHmacViewController;
@property (retain) IBOutlet ManageKeyViewController *manageKeyViewController;

@property (nonatomic, retain) KeychainItemWrapper *yubiKeyItem;

@end
