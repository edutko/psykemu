//
//  SecondViewController.m
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

#import "ManageKeyViewController.h"

#import "KeychainItemWrapper.h"
#import "YubiKeySha1Hmac.h"

@implementation ManageKeyViewController

@synthesize key, confirmKey, save, yubiKeyItem;

- (IBAction)saveButtonTapped:(UIButton *)sender {

	[key resignFirstResponder];
	[confirmKey resignFirstResponder];
	
	[yubiKeyItem setObject:[key text] forKey:(id)kSecValueData];	
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	
	BOOL allowChange = FALSE;
	
	NSCharacterSet *hexDigits = [NSCharacterSet characterSetWithCharactersInString: @"0123456789ABCDEFabcdef"];
	if ([[string stringByTrimmingCharactersInSet:hexDigits] isEqualToString:@""]) {
		allowChange = TRUE;
	}
	
	NSString* keyText = key.text;
	NSString* confirmText = confirmKey.text;
	
	if (allowChange) {
		if (textField == key) {
			keyText = [keyText stringByReplacingCharactersInRange:range withString:string];
		} else if (textField == confirmKey) {
			confirmText = [confirmText stringByReplacingCharactersInRange:range withString:string];
		}
	}
						   
    if ([keyText isEqualToString:confirmText]) {
		save.enabled = YES;
	} else {
		save.enabled = NO;
	}
	
	return allowChange;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[textField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	save.enabled = NO;
	
//	key.text = [YubiKeySha1Hmac convertDataToHex:[yubiKeyItem objectForKey:(id)kSecValueData]];
//	confirmKey.text = [YubiKeySha1Hmac convertDataToHex:[yubiKeyItem objectForKey:(id)kSecValueData]];
}

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
