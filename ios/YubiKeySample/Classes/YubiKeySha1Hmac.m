//
//  YubiKeySha1Hmac.m
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
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>


@implementation YubiKeySha1Hmac

- (id) initWithKey: (NSData*)key {
	
	if (self = [super init]) {
		[_key autorelease];
		_key = [key retain];
	}
	
	return self;
}

- (id) initWithHexKey: (NSString*)key {
	return [self initWithKey:[YubiKeySha1Hmac convertHexToData:key]];
}

- (void) dealloc
{
    [_key release];
    [super dealloc];
}

- (NSData*) calculateSha1Hmac: (NSData*)data {
	
	unsigned char hmac[CC_SHA1_DIGEST_LENGTH];
	const char *key  = [_key bytes];
	const char *dataBytes = [data bytes];
	int length = [data length];
	
	if (length > 64) {
		length = 64;
	}
	
	if (length == 0) {
		((char*)dataBytes)[0] = '\0';
		length = 1;
		
	} else if (length == 64 || dataBytes[length - 1] == '\0') {
		char lastByte = dataBytes[length - 1];
		while (dataBytes[length - 1] == lastByte) {
			length--;
		}
	}

	CCHmac(kCCHmacAlgSHA1, key, [_key length], dataBytes, length, hmac);

	return [NSData dataWithBytes:hmac length:sizeof(hmac)];
}

+ (NSString*) convertDataToHex: (NSData*)data {

	NSString *hexString = [NSMutableString stringWithCapacity:data.length * 2];
	const unsigned char *buffer = (const unsigned char *)[data bytes];

	for (int i = 0; i < data.length; i++) {
		hexString = [hexString stringByAppendingFormat:@"%02lx", (unsigned long)buffer[i]];
	}

	return hexString;
}

unsigned char charsToByte(const char high, const char low) {
	char nybbles[3] = { high, low, '\0' };
	return (unsigned char)strtol(nybbles, NULL, 16);
}

+ (NSData*) convertHexToData: (NSString*)str {

	const char* asciiStr = [str UTF8String];
	NSMutableData *hexData = [NSMutableData dataWithCapacity:str.length / 2];

	for (int i = 0; i < str.length; i += 2) {
		unsigned char byte = charsToByte(asciiStr[i], asciiStr[i + 1]);
		[hexData appendBytes:&byte length: 1];
	}

	return hexData;
}

@end
