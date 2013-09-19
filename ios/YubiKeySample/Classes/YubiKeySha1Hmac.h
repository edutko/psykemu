//
//  YubiKeySha1Hmac.h
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

#import <Foundation/Foundation.h>


@interface YubiKeySha1Hmac : NSObject {

	NSData* _key;
}

/**
 Initialize with a binary key. The key should be 20 bytes.
*/
- (id) initWithKey: (NSData*)key;

/**
 Initialize with a hex-encoded string key.
 */
- (id) initWithHexKey: (NSString*)key;

/**
 Calculate the SHA-1 HMAC of the provided data, following the rules used by the YubiKey.
 */
- (NSData*) calculateSha1Hmac: (NSData*)data;

/**
 Convert binary data to the hex-encoded equivalent.
*/
+ (NSString*) convertDataToHex: (NSData*)data;

/**
 Convert hex-encoded data to the binary equivalent.
 */
+ (NSData*) convertHexToData: (NSString*)str;

@end
