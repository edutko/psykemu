//
//  PasswordSafeYubiKeySha1HmacAdapter.h
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

#import "YubiKeySha1Hmac.h"

@interface PasswordSafeYubiKeySha1HmacAdapter : YubiKeySha1Hmac {

}

/**
 Return a hex encoded representation of the YubiKey SHA-1 HMAC of password, using the same rules as Password Safe for Windows.
 */
- (NSString*) encodePassword: (NSString*)password;

@end
