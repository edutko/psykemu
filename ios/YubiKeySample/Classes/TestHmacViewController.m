//
//  FirstViewController.m
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

#import "TestHmacViewController.h"

#import "KeychainItemWrapper.h"
#import "PasswordSafeYubiKeySha1HmacAdapter.h"

@implementation TestHmacViewController

@synthesize password, encodedPassword, yubiKeyItem;

- (IBAction)encodeButtonTapped:(UIButton *)sender {

	[password resignFirstResponder];
	
	NSString *keyString = [yubiKeyItem objectForKey:(id)kSecValueData];
	NSData* key = [YubiKeySha1Hmac convertHexToData:keyString];

	PasswordSafeYubiKeySha1HmacAdapter* yubiKey = [[[PasswordSafeYubiKeySha1HmacAdapter alloc] initWithKey:key] autorelease];
	
	encodedPassword.text = [yubiKey encodePassword:password.text];
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[yubiKeyItem release];
    [super dealloc];
}

@end
